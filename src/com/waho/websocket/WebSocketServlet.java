package com.waho.websocket;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.waho.dao.AlarmDao;
import com.waho.dao.GroupNodeDao;
import com.waho.dao.NodeDao;
import com.waho.dao.PloyDao;
import com.waho.dao.PloyOperateDao;
import com.waho.dao.impl.AlarmDaoImpl;
import com.waho.dao.impl.GroupNodeDaoImpl;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.PloyDaoImpl;
import com.waho.dao.impl.PloyOperateDaoImpl;
import com.waho.domain.Alarm;
import com.waho.domain.GroupNode;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.Ploy;
import com.waho.domain.PloyOperate;
import com.waho.domain.User;
import com.waho.service.NodeService;
import com.waho.service.impl.NodeServiceImpl;

/**
 * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 *                 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 */
@ServerEndpoint("/websocket")
public class WebSocketServlet {
	private Logger logger = Logger.getLogger(this.getClass());
	// 超时30s
	public static final int TIMEOUT = 30;
	
	// 静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
	private static int onlineCount = 0;

	// concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
	public static CopyOnWriteArraySet<WebSocketServlet> webSocketSet = new CopyOnWriteArraySet<WebSocketServlet>();

	// 定时器
	public static Timer timer;

	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;

	private int timeCount = 0;

	public static void setOnlineCount(int onlineCount) {
		WebSocketServlet.onlineCount = onlineCount;
	}

	// 绑定的nodeid
	private int id;

	public WebSocketServlet() {
		super();
		//30s无心跳包断开连接
		if (WebSocketServlet.timer == null) {
			WebSocketServlet.timer = new Timer();
			WebSocketServlet.timer.schedule(new TimerTask() {
				@Override
				public void run() {
					// 分两次循环进行操作，因为不确定调用session的close方法后，从set集合删除操作何时进行的。防止出现遍历过程中set发生变化，遍历越界。
					for (WebSocketServlet servlet : webSocketSet) {
						servlet.timeCount += 3;
					}
					for (WebSocketServlet servlet : webSocketSet) {
						//1.执行策略广播,每隔3秒轮询一次
						PloyBroadcastCmdHandler.SendPloyBroadcastCmd(servlet);
						if (servlet.timeCount > TIMEOUT) {
							try {
								//2.节点断开连接报警
								if(servlet.getId() != 0) {
									NodeDao nodeDao = new NodeDaoImpl();
									AlarmDao alarmDao = new AlarmDaoImpl();
									Node node = nodeDao.selectNodeById(servlet.getId());
									int type = 2;//报警信息中type为2是节点与服务器断开连接
									Date date = new Date();
									//查询节点报警类型为2的报警记录是否存在
									Alarm alarmRecord = alarmDao.selectAlarmByUseridAndMacAndType(node.getUserid(),node.getMac(),type);
									if(alarmRecord == null) {//若不存在，插入新的记录
										Alarm alarm = new Alarm();
										alarm.setDate(date);
										alarm.setMac(node.getMac());
										alarm.setType(2);
										alarm.setUserid(node.getUserid());
										alarmDao.insertUnconnectAlarm(alarm);
									}else {//若存在，更新该记录的报警信息
										alarmDao.updateAlarmDateById(alarmRecord.getId(),date);
									}
									
								}
								//3.30秒内未收到客户端的心跳包，websocket主动断开与客户端的连接
								//用于日志提示
								//logger.info("timeCount = " + timeCount + "超时关闭");
								servlet.session.close(); //session 关闭以后直接调用onClose方法，webScoket失去连接
								
							} catch (Exception e) {
								e.printStackTrace();
							}
						} 
					}
					
				}
				
			}, 3000, 3000);
		}
		
		
	}
	
	
	/**
	 * 连接建立成功调用的方法,连接建立时触发
	 * 
	 * @param session
	 * 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
	 */
	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		webSocketSet.add(this); // 加入set中
		addOnlineCount(); // 在线数加1
		System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
		logger.info("有新连接加入！当前在线人数为" + getOnlineCount());
		
	}

	/**
	 * 连接关闭调用的方法
	 */
	@OnClose
	public void onClose() {
		webSocketSet.remove(this); // 从set中删除
		subOnlineCount(); // 在线数减1
		System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
		logger.info("有一连接关闭！当前在线人数为" + getOnlineCount());
		if (this.getId() != 0) {
			NodeService nodeService = new NodeServiceImpl();
			nodeService.setNodeOfflineById(this.getId()); //更新分组内在线、离线节点数量
		}
	}

	/**
	 * 收到客户端消息后调用的方法,客户端接收服务端数据时触发
	 * 
	 * @param message
	 *            客户端发送过来的消息
	 * @param session
	 *            可选的参数
	 */
	@OnMessage
	public void onMessage(String message, Session session) {
		System.out.println("来自客户端的消息:" + message);
		Message obj = JSON.parseObject(message, Message.class); //将字符串转为json对象
		logger.info("Node to" + obj.getMac() + ":" + message);
		WebSocketRequestHandler.RequestHandle(message, this);
		WebSocketResponseHandler.responseHandle(message, session);
	}
	
	/**
	 * 发生错误时调用
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {
		System.out.println("发生错误");
		logger.info("发生错误");
		error.printStackTrace();
	}

	/**
	 * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
	 * 
	 * @param message
	 * @throws IOException
	 */
	public void sendMessage(String message) throws IOException {
		this.session.getBasicRemote().sendText(message);
		System.out.println("发送给客户端的消息:" + message);
	}
	
	
	
	public static synchronized int getOnlineCount() {
		return onlineCount;
	}

	public static synchronized void addOnlineCount() {
		WebSocketServlet.onlineCount++;
	}

	public static synchronized void subOnlineCount() {
		WebSocketServlet.onlineCount--;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}

	public int getTimeCount() {
		return timeCount;
	}

	public void setTimeCount(int timeCount) {
		this.timeCount = timeCount;
	}

}
