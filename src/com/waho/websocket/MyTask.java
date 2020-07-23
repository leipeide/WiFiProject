package com.waho.websocket;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.waho.dao.AlarmDao;
import com.waho.dao.NodeDao;
import com.waho.dao.NodeStateRecordDao;
import com.waho.dao.UserCmdRecordDao;
import com.waho.dao.UserDao;
import com.waho.dao.impl.AlarmDaoImpl;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.NodeStateRecordDaoImpl;
import com.waho.dao.impl.UserCmdRecordDaoImpl;
import com.waho.dao.impl.UserDaoImpl;
import com.waho.domain.Alarm;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.NodeStateRecord;
import com.waho.domain.User;
import com.waho.domain.UserCmdRecord;

/**
 * 任务一：每隔一小时对在线节点进行巡检，节点在线且节点的状态已经超过12个小时未更新了，则报警
 * 任务二：每天0-1点期间进行清除用户验证码和获取验证码操作次数清零
 * @author liyan
 */
public class MyTask extends TimerTask {
	private static Logger logger = Logger.getRootLogger();
	//以常量C_SCHEDULE_HOUR表示(晚上12点，也即0点)。
	private  static  final  int  C_SCHEDULE_HOUR =  0;
	//节点超过12个小时没有状态记录，即视为与服务器失去连接，AlarmTime为超时报警判断的基准时间(12H)
	private static final long AlarmTime =  1000 * 60 * 60 * 12;; 
	//避免第二次又被调度以引起执行冲突，设置了巡检任务标志1，当前是否正在执行的状态标志isRunning1
	private static  boolean  isRunning1  =  false;    
	//避免第二次又被调度以引起执行冲突，设置了清除用户信息任务标识2，当前是否正在执行的状态标志isRunning2
	private static  boolean  isRunning2  =  false;   
	//记录每次节点巡检的个数
	private Integer poolCount = 0;
	//发送读节点指令标志位
	private static boolean sendReadCmd = false;
	//发送读节点指令的个数
	private Integer sendReadCmdNumber = 0;
	//
	private  ServletContext  context  =  null;    
	

	public  MyTask(ServletContext  context)  {    
	            this.context  =  context;    
	      }    
	
	public  void  run()  {   
		
		  UserDao userDao = new UserDaoImpl();
		  NodeDao nodeDao = new NodeDaoImpl();
		  AlarmDao alarmDao = new AlarmDaoImpl();
		  UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		  NodeStateRecordDao nodeRecordDao = new NodeStateRecordDaoImpl();
		  
		  //任务1: 节点状态巡检功能，每隔一小时进行一次巡检
	      if(!isRunning1){  
	    	  	try {
	    	  	    isRunning1  =  true;  
	    	  	    logger.info("开始执行任务一");
		        
					List<User> userList = userDao.getAllUsers(); //得到该系统的所有用户集合
					
					if(userList.size() > 0) {
					
						for(User admin : userList) {
							//查找用户下的所有在线的节点
							List<Node> nodeList = nodeDao.selectOnlineNodesByUserid(admin.getId());
							//1.给所有在线节点发送读节点指令
							for(Node nodeObj : nodeList) { //遍历所有在线节点
									for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
										if (socket.getId() == nodeObj.getId()) { //发送读节点指令
												System.out.println("节点与通讯线程匹配");
												logger.info("节点与通讯线程匹配");
												Message cmd = new Message();
												cmd.setMsg("request");
											    cmd.setCmd("read");
												String cmdStr = JSON.toJSONString(cmd);
												socket.sendMessage(cmdStr);
												logger.info("service to " + nodeObj.getMac() + ":" + cmdStr);
												//记录用户指令
												UserCmdRecord userCmdRecord = new UserCmdRecord();
												userCmdRecord.setDate(new Date());
												userCmdRecord.setCmdType(UserCmdRecord.CMD_READ);
												userCmdRecord.setMac(nodeObj.getMac());
												userCmdRecord.setParamter(Integer.toString(cmd.getPrecentage()));
												userCmdRecord.setUserid(nodeObj.getUserid());
												userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
												//发送读节点指令的个数
												sendReadCmdNumber++;
												System.out.println("发送查询节点个数"+sendReadCmdNumber);
												logger.info("发送查询节点个数"+sendReadCmdNumber);
												
												
											}
										}
								}
							
							//2.节点状态检查，节点在线时与服务器保持连接的时间是否超过报警时间，如果超过则报警
							if(sendReadCmdNumber >= nodeList.size()) { //所有在线节点读节点指令已发送完成，进行节点状态巡检，不符合状态则报警
								 System.out.println("进行巡检");
						  		 logger.info("进行巡检");
								 for(Node checkNode : nodeList) { //遍历所有在线节点
										poolCount ++; //巡检节点个数加1
										NodeStateRecord lastRecord =  nodeRecordDao.selectNewNodeStateRecord(checkNode);
										Date date = new Date();
										if(!lastRecord.getMac().equals("")) { //正常情况下，节点在线是存在节点记录的
											//判断节点在线时与服务器保持连接的时间是否超过报警时间，如果超过则报警
											if(date.getTime() - lastRecord.getDate().getTime() > AlarmTime) {
												//查找该节点与服务器失去连接报警类型的集合
												List<Alarm> alarmList = alarmDao.
														selectAlarmByMacAndAlarmType(Alarm.ALARM_DISCONNECT, checkNode.getMac());
												//3.如果数据库中没有相应的报警信息，生成报警信息，type = ALARM_DISCONNECT，存入数据库。
												if (alarmList.size() == 0) { //该集控器无报警
													Alarm alarm = new Alarm(new Date(), checkNode.getMac(), 
															Alarm.ALARM_DISCONNECT, checkNode.getUserid(),
															checkNode.getPower(), checkNode.getTemperature());
													alarmDao.insert(alarm);
												}else {// 判断是否有相应类型的超时报警信息，如果有，直接将之前的报警记录修改
													if (alarmList.size() > 0) {
														for(int i = 0; i < alarmList.size(); i++) {
															Alarm alarm = new Alarm(new Date(), checkNode.getMac(), 																		Alarm.ALARM_DISCONNECT, checkNode.getUserid(),
																	checkNode.getPower(), checkNode.getTemperature());
															alarmDao.updataAlarmRecordById(alarmList.get(i).getId(), alarm);
														}
													
													}
												}
													
											}else { //不存在失去连接报警，那么在这里可以进行判断是否过功率，过温情况
													
											}
										}
									}
								}
							}
									
								
					}
					
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
	    	  	
	    	  		//3.将各个参数复位
	                logger.info("巡检任务执行结束" + "本次共对" + poolCount + "个节点进行了巡检"); 
	                //巡检任务结束后任务标志位设置为执行结束状态
	                isRunning1  =  false;  
	                //巡检任务结束后，上一次巡检时的节点个数清零，下一次巡检时再次进行巡检个数计数
	                poolCount = 0; 
	                //巡检任务结束后，上一次发送读节点指令个数清零，下一次巡检时再次进行计数                       
					sendReadCmdNumber = 0; 
	               
					
	        }else{    
	        	
	        	 logger.info("上一次任务一执行还未结束");
	          
	        }  
	      
	      
	      //任务2：清除用户找回密码功能记录下的相关信息
	      if(!isRunning2){  
	    	  Calendar  cal  =  Calendar.getInstance();  
	    	  if(C_SCHEDULE_HOUR  ==  cal.get(Calendar.HOUR_OF_DAY))  {          
	    		  
	                isRunning2  =  true;   
	                logger.info("开始执行任务二:定时清除用户验证码信息");
	                context.log("开始执行任务二");    
	                //定时清除用户验证码信息
	       			String verCode = null;
	       			int operateNum = 0; //获取验证码的次数
	       			try {
	       				
	       				userDao.clearVercodeAndOpreateNum(verCode,operateNum);//清除用户验证码信息
	       			
	       			} catch (Exception e) {
	       				// TODO Auto-generated catch block
	       				e.printStackTrace();
	       			}
	       			
	                isRunning2  =  false;   
	                logger.info("清除用户操作信息任务执行结束");
	                                           
	             }
	    	  
	        }else{  
	        	
	        	 logger.info("上一次任务2执行还未结束");
	         
	        }   
	      
	     
	      
	    }    
	      

	

}
