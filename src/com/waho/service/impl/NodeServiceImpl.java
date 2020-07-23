package com.waho.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.waho.dao.GroupDao;
import com.waho.dao.GroupNodeDao;
import com.waho.dao.NodeDao;
import com.waho.dao.UserCmdRecordDao;
import com.waho.dao.impl.GroupDaoImpl;
import com.waho.dao.impl.GroupNodeDaoImpl;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.UserCmdRecordDaoImpl;
import com.waho.domain.Group;
import com.waho.domain.GroupNode;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.UserCmdRecord;
import com.waho.service.NodeService;
import com.waho.websocket.WebSocketServlet;

public class NodeServiceImpl implements NodeService {
	private Logger logger = Logger.getLogger(this.getClass());

	@Override
	public void setNodeOfflineById(int id) {
		NodeDao nodeDao = new NodeDaoImpl();
		
		try {
			//1.将节点置为离线
			int x = nodeDao.updateOnlineById(false, id);
			
		/*	//2.记录分组中的在线节点数量
			GroupNodeDao groupNodeDao = new GroupNodeDaoImpl();
			GroupDao groupDao = new GroupDaoImpl();
			Node node = nodeDao.selectNodeById(id);
			GroupNode groupNode = groupNodeDao.selectNodeByMac(node.getMac());
			if(groupNode != null) {
				Group group = groupDao.selectGroupByGroupid(groupNode.getGroupid());
				int onlineNum = group.getOnlineNum()-1;
				int offlineNum = group.getOfflineNum()+1;
				int groupid = group.getGroupid();
				groupDao.updateOnlineNumAndOfflineNum(onlineNum, offlineNum, groupid);
			}
			*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int ColorControlBroadcast(int tonPercentage, String[] nodeId) {
		int count = 0;
		NodeDao nodeDao = new NodeDaoImpl();
		for (WebSocketServlet socket : WebSocketServlet.webSocketSet) {
			for (String idStr : nodeId) {
				int nodeid = Integer.parseInt(idStr);
				try {
					Node node = nodeDao.selectNodeById(nodeid);
					if (socket.getId() == node.getId()) {
						    //1.新建指令对象
							Message cmd = new Message();
							cmd.setMsg("request");
							cmd.setCmd("toning");
							cmd.setColorPrecentage(tonPercentage);
							String cmdStr = JSON.toJSONString(cmd);
						    //2.发送指令给节点
						    socket.sendMessage(cmdStr);
						    count++;
						    logger.info("service to " + node.getMac() + ":" + cmdStr);
						    //3.记录此次操作类型lastOperateType;
						    String operateType = "toning";
							nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
					   
			}
		}
		return count++;
	}

	@Override
	public boolean switchNodeControl(int nodeid, String switchState) {
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		//新建用户指令对象
		UserCmdRecord userCmdRecord = new UserCmdRecord();
	    Date date = new Date();
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(nodeid);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						//1.新建指令对象
						Message cmd = new Message();
						cmd.setMsg("request");
						cmd.setCmd("write");
						cmd.setPrecentage(100);	//默认开灯时的灯光百分比为100；
						if (switchState != null && switchState.equals("on")) {
							cmd.setSwitchState(1);
							userCmdRecord.setCmdType(userCmdRecord.CMD_OPEN); //设置用户指令类型：开灯
							//2.记录此次操作类型lastOperateType;
						    String operateType = "open";
							nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						} else {
							cmd.setSwitchState(0);
							userCmdRecord.setCmdType(userCmdRecord.CMD_CLOSE); //设置用户指令类型：关灯
							//2.记录此次操作类型lastOperateType;
							String operateType = "close";
							nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						}
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr); //发送指令
						logger.info("service to " + node.getMac() + ":" + cmdStr);
						
						//3.记录用户指令并写入数据库user_cmd_record
						userCmdRecord.setDate(date);
						userCmdRecord.setMac(node.getMac());
						userCmdRecord.setParamter(Integer.toString(cmd.getPrecentage()));
						userCmdRecord.setUserid(node.getUserid());
						userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
						
						return true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}

	@Override
	public boolean dimNodeControl(int nodeid,int percentage) {
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		//新建用户指令对象
		UserCmdRecord userCmdRecord = new UserCmdRecord();
	    Date date = new Date();
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(nodeid);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						//1.新建指令对象
						Message cmd = new Message();
						cmd.setMsg("request");
						cmd.setCmd("write");
						cmd.setPrecentage(percentage);//默认开灯时的灯光百分比为100
						cmd.setSwitchState(node.getSwitchState());
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr); //发送指令
						logger.info("service to " + node.getMac() + ":" + cmdStr);
					    /*
					    //2.记录此次操作类型lastOperateType;
						String operateType = "dim";
						nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						*/
						//3.记录用户指令并写入数据库user_cmd_record
						userCmdRecord.setDate(date);
						userCmdRecord.setMac(node.getMac());
						userCmdRecord.setCmdType(userCmdRecord.CMD_PWM); //pwm调光
						userCmdRecord.setParamter(Integer.toString(cmd.getPrecentage()));
						userCmdRecord.setUserid(node.getUserid());
						userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
						return true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}

	@Override
	public boolean wifiNodeLuxDimByNodeid(int nodeid, int dimParam,String Cmd) {
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		//新建用户指令对象
		UserCmdRecord userCmdRecord = new UserCmdRecord();
	    Date date = new Date();
	    
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(nodeid);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						//1.发送用户指令
						Message cmd = new Message();
						cmd.setMsg("request");
						cmd.setCmd(Cmd);
						if(Cmd.equals("autoluxdim")) {
							cmd.setLux(dimParam);
							userCmdRecord.setCmdType(userCmdRecord.CMD_AUTOLUX); //lux自动调光
						}else if(Cmd.equals("pwmdim")) {
							cmd.setPrecentage(dimParam);
							userCmdRecord.setCmdType(userCmdRecord.CMD_PWM); //pwm调光
						}
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr);
						logger.info("service to " + " " + node.getMac() + ":" + cmdStr);
						
						//2.记录此次操作类型lastOperateType;
						String operateType = "dim";
						nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						
						//3.记录用户指令并写入数据库user_cmd_record
						userCmdRecord.setDate(date);
						userCmdRecord.setMac(node.getMac());
						userCmdRecord.setParamter(Integer.toString(dimParam)); 
						userCmdRecord.setUserid(node.getUserid());
						userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
						return true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<Node> currencyGetNodeListInGroup(List<GroupNode> gnList) {
		List<Node> list =  new ArrayList<>();
		NodeDao nodeDao = new NodeDaoImpl();
		Node node = null;
		for(GroupNode gnObj : gnList) {
			try {
				node = nodeDao.selectNodesByUseridAndMac(gnObj.getMac(), gnObj.getUserid());
				if(node != null) {
					list.add(node);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public Boolean writeLedBroadcastCmd(int userid, int paramValue, String functionStr) {
		//functionStr字段为switch 、 dim、 toning
		NodeDao nodeDao = new NodeDaoImpl();
		List<Node> list =  new ArrayList<>();
		UserCmdRecord userCmdRecord = new UserCmdRecord();
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		int cmdType = 0; //用户指令类型,默认为0，0不是一个用户指令
		int count = 0; //记录发送指令的个数
		int recordParam = 0; //初始化用户指令记录参数为0
		
		try {
			//1.根据用户id查找led节点集合；注意：led节点类型type的范围是11-20；
			list = nodeDao.selectLedNodeByUseridAndType(userid);
			if (list.size() == 0) {
				return false;
			} else {// 设备存在
				//2.依次给led节点发送广播指令
				for(Node obj : list) {
					if(obj.isOnline()) {//判断节点是否在线，节点在线；给节点发送广播指令
						for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
							if (socket.getId() == obj.getId()) {
								//3.判断广播指令的类型发送对应功能的指令
								Message cmd = new Message();
								if(functionStr.equals("switch")) { // 开关指令
									cmd.setMsg("request");
								    cmd.setCmd("write");
								    cmd.setPrecentage(obj.getPrecentage());
								    cmd.setSwitchState(paramValue);
								    
								    recordParam = cmd.getPrecentage(); //赋值给用户指令参数 
								    //4.记录此次操作类型lastOperateType;
								    String operateType;
								    if(paramValue == 1) {
								    	operateType = "open";
								    	cmdType = UserCmdRecord.CMD_OPEN;
								    }else {
								    	operateType = "close";
								    	cmdType = UserCmdRecord.CMD_CLOSE;
								    }
									nodeDao.updateLastOperateTypeByNodeid(operateType,obj.getId());
							
								}else if(functionStr.equals("dim")) { // led调光指令
									cmd.setMsg("request");
								    cmd.setCmd("write");
								    cmd.setPrecentage(paramValue);
								    cmd.setSwitchState(obj.getSwitchState());
								    cmdType = UserCmdRecord.CMD_PWM;
								    
								    recordParam = cmd.getPrecentage(); //赋值给用户指令参数 
								  //4.记录此次操作类型lastOperateType;
									String operateType = "dim";
									nodeDao.updateLastOperateTypeByNodeid(operateType,obj.getId());
								}else if(functionStr.equals("toning")){ // 调色指令
									cmd.setMsg("request");
								    cmd.setCmd("toning");
							    	cmd.setColorPrecentage(paramValue);
							    	cmdType = UserCmdRecord.CMD_TONING;
							    	recordParam = cmd.getColorPrecentage(); //赋值给用户指令参数 
							        /*//2.记录此次操作类型lastOperateType;
									String operateType = "toning";
									nodeDao.updateLastOperateTypeByNodeid(operateType,obj.getId());
								    */
								}
								// 5.发送json格式的指令
								String cmdStr = JSON.toJSONString(cmd);
								socket.sendMessage(cmdStr);
								count++;
								logger.info("service to " + obj.getMac() + ":" + cmdStr);
								// 6.记录用户指令
								Date date = new Date();
								userCmdRecord.setDate(date);
								userCmdRecord.setCmdType(cmdType);
								userCmdRecord.setMac(obj.getMac());
								userCmdRecord.setParamter(Integer.toString(recordParam));
								userCmdRecord.setUserid(obj.getUserid());
								userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
								
							}
						}
					}
					
				}
				
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(count > 0) {
			return true;
		} else {
			return false;
		}
		
	}

	@Override
	public Boolean writeBallastBroadcastCmd(int userid, int paramValue, String functionStr) {
		NodeDao nodeDao = new NodeDaoImpl();
		List<Node> list =  new ArrayList<>();
		UserCmdRecord userCmdRecord = new UserCmdRecord();
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		int cmdType = 0; // 用户指令类型,默认为0，0不是一个用户指令
		int count = 0; // 发送指令的个数
		//functionStr字段为switch 、 dim
		
		try {
			//1.根据用户id查找镇流器节点集合；注意：镇流器节点类型type的范围是1-10；
			list = nodeDao.selectBallastNodeByUseridAndType(userid);
			if (list.size() == 0) {
				return false;
			} else {// 设备存在
				//2.依次给镇流器节点发送广播指令
				for(Node obj : list) {
					if(obj.isOnline()) {//判断节点是否在线，节点在线；给节点发送广播指令
						for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
							if (socket.getId() == obj.getId()) {
								
								//3.判断广播指令的类型发送对应功能的指令
								Message cmd = new Message();
								if(functionStr.equals("switch")) { // 开关指令
									cmd.setMsg("request");
								    cmd.setCmd("write");
								    cmd.setPrecentage(obj.getPrecentage());
								    cmd.setSwitchState(paramValue);
								    //4.记录此次操作类型lastOperateType;
								    String operateType;
								    if(paramValue == 1) {
								    	operateType = "open";
								    	cmdType = UserCmdRecord.CMD_OPEN;
								    }else {
								    	operateType = "close";
								    	cmdType = UserCmdRecord.CMD_CLOSE;
								    }
									nodeDao.updateLastOperateTypeByNodeid(operateType,obj.getId());
								
								}else if(functionStr.equals("dim")) { // 镇流器调光指令
									cmd.setMsg("request");
								    cmd.setCmd("write");
								    cmd.setPrecentage(paramValue);
								    cmd.setSwitchState(obj.getSwitchState());
								    cmdType = UserCmdRecord.CMD_PWM;
								    //4.记录此次操作类型lastOperateType;
									//String operateType = "dim";
									//nodeDao.updateLastOperateTypeByNodeid(operateType,obj.getId());
								}
								// 4.发送json格式的指令
								String cmdStr = JSON.toJSONString(cmd);
								socket.sendMessage(cmdStr);
								count++;
								logger.info("service to " + obj.getMac() + ":" + cmdStr);
								
								//5.记录用户指令
								Date date = new Date();
								userCmdRecord.setDate(date);
								userCmdRecord.setCmdType(cmdType);
								userCmdRecord.setMac(obj.getMac());
								userCmdRecord.setParamter(Integer.toString(cmd.getPrecentage()));
								userCmdRecord.setUserid(obj.getUserid());
								userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
								
							}
						}
					}
				}	
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(count > 0) {
			
			return true;
		}else {
			return false;
		}
		
	}

	@Override
	public Boolean writeWifiBroadcastCmd(int userid, int dimParam, String Cmd) {
		//cmd字段为autoluxdim、pwmdim；调光功能类型字符串：自动调光、pwm调光，
		NodeDao nodeDao = new NodeDaoImpl();
		List<Node> list =  new ArrayList<>();
		UserCmdRecord userCmdRecord = new UserCmdRecord();
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		int cmdType = 0; //指令类型初始化为0，0不是用户指令类型
		int count = 0; // 发送指令的个数
		
		try {
			//1.根据用户id查找wifi无线调光器节点集合；注意：wifi无线调光器节点类型type的范围是21-30；
			list = nodeDao.selectWifiNodeByUseridAndType(userid);
			if (list.size() == 0) {
				return false;
			} else {// 设备存在
				//2.依次给led节点发送广播指令
				for(Node obj : list) {
					if(obj.isOnline()) {//判断节点是否在线，节点在线；给节点发送广播指令
						for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
							if (socket.getId() == obj.getId()) {
								//3.发送json格式的调光指令
								Message cmd = new Message();
								cmd.setMsg("request");
								cmd.setCmd(Cmd);
								if(Cmd.equals("autoluxdim")) {
									cmd.setLux(dimParam);
									cmdType = UserCmdRecord.CMD_AUTOLUX;
									
								}else if(Cmd.equals("pwmdim")) {
									cmd.setPrecentage(dimParam);
									cmdType = UserCmdRecord.CMD_PWM;
									
								}else {
									return false;
								}
								String cmdStr = JSON.toJSONString(cmd);
								socket.sendMessage(cmdStr);
								count++;
								logger.info("service to " + obj.getMac() + ":" + cmdStr);
								
								//5.记录用户指令
								Date date = new Date();
								userCmdRecord.setDate(date);
								userCmdRecord.setCmdType(cmdType);
								userCmdRecord.setMac(obj.getMac());
								userCmdRecord.setParamter(Integer.toString(dimParam));
								userCmdRecord.setUserid(obj.getUserid());
								userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
								
							}
						}
					}
				}	
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(count > 0) {
			return true;
		}else{
			return false;
		}
				
	}

	@Override
	public Boolean nodeInGroupWriteCmd(int nodeid, int switchState) {
		UserCmdRecord userCmdRecord = new UserCmdRecord();
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		int cmdType = 0; //指令类型初始化为0，0不是用户指令类型
		
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(nodeid);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						//1.发送用户指令
						Message cmd = new Message();
						cmd.setMsg("request");
						cmd.setCmd("write");
						cmd.setSwitchState(switchState);
						cmd.setPrecentage(100); //默认开灯时的灯光百分比为100；
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr);
						logger.info("service to " + node.getMac() + ":" + cmdStr);
						 //记录此次操作类型lastOperateType;
						String operateType;
						if(switchState == 1) {
							operateType = "open";
							cmdType = UserCmdRecord.CMD_OPEN;
						}else {
							operateType = "close";
							cmdType = UserCmdRecord.CMD_CLOSE;
						}
						nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						
						//5.记录用户指令
						Date date = new Date();
						userCmdRecord.setDate(date);
						userCmdRecord.setCmdType(cmdType);
						userCmdRecord.setMac(node.getMac());
						userCmdRecord.setParamter(Integer.toString(cmd.getPrecentage()));
						userCmdRecord.setUserid(node.getUserid());
						userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
						
						return true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}

	@Override
	public Boolean nodeInGroupPwmDimCmd(int nodeid, int percentage) {
		UserCmdRecord userCmdRecord = new UserCmdRecord();
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(nodeid);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						//1.发送用户指令
						Message cmd = new Message();
						cmd.setMsg("request");
						cmd.setCmd("write");
						cmd.setSwitchState(node.getSwitchState());
						cmd.setPrecentage(percentage);//默认开灯时的灯光百分比为100
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr);
						logger.info("service to " + node.getMac() + ":" + cmdStr);
					   /*	
					    * //4.记录此次操作类型lastOperateType;
						String operateType = "dim";
						nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						*/
						//5.记录用户指令
						Date date = new Date();
						userCmdRecord.setDate(date);
						userCmdRecord.setCmdType(UserCmdRecord.CMD_PWM);
						userCmdRecord.setMac(node.getMac());
						userCmdRecord.setParamter(Integer.toString(cmd.getPrecentage()));
						userCmdRecord.setUserid(node.getUserid());
						userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
						
						return true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Boolean NodeInGroupToningCmd(int nodeid, int tonPercentage) {
    	try {
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(nodeid);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						Message cmd = new Message();
						cmd.setMsg("request");
					    cmd.setCmd("toning");
				    	cmd.setColorPrecentage(tonPercentage);
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr);
						logger.info("service to " + node.getMac() + ":" + cmdStr);
					/*	 //4.记录此次操作类型lastOperateType;
						String operateType = "toning";
						nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						*/
						return true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean nodeInGrouopLuxDimCmd(int nodeid, int dimParam, String Cmd) {
		UserCmdRecord userCmdRecord = new UserCmdRecord();
		UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
		int cmdType = 0; //指令类型初始化为0，0不是用户指令类型
		
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(nodeid);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						Message cmd = new Message();
						cmd.setMsg("request");
						cmd.setCmd(Cmd);
						if(Cmd.equals("autoluxdim")) {
							cmd.setLux(dimParam);
							cmdType=UserCmdRecord.CMD_AUTOLUX;
						}else if(Cmd.equals("pwmdim")) {
							cmd.setPrecentage(dimParam);
							cmdType=UserCmdRecord.CMD_PWM;
						}else {
							return false;
						}
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr);
						logger.info("service to " + node.getMac() + ":" + cmdStr);
						 //4.记录此次操作类型lastOperateType;
						String operateType = "luxdim";
						nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						
						//5.记录用户指令
						Date date = new Date();
						userCmdRecord.setDate(date);
						userCmdRecord.setCmdType(cmdType);
						userCmdRecord.setMac(node.getMac());
						userCmdRecord.setParamter(Integer.toString(dimParam));
						userCmdRecord.setUserid(node.getUserid());
						userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
						
						return true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	
	

}


 