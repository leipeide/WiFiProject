package com.waho.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.waho.dao.AlarmDao;
import com.waho.dao.GroupDao;
import com.waho.dao.GroupNodeDao;
import com.waho.dao.NodeDao;
import com.waho.dao.PloyDao;
import com.waho.dao.PloyOperateDao;
import com.waho.dao.UserDao;
import com.waho.dao.impl.AlarmDaoImpl;
import com.waho.dao.impl.GroupDaoImpl;
import com.waho.dao.impl.GroupNodeDaoImpl;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.PloyDaoImpl;
import com.waho.dao.impl.PloyOperateDaoImpl;
import com.waho.dao.impl.UserDaoImpl;
import com.waho.domain.Alarm;
import com.waho.domain.Group;
import com.waho.domain.GroupNode;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.NodeTreeModel;
import com.waho.domain.Ploy;
import com.waho.domain.PloyOperate;
import com.waho.domain.TreeChildModel;
import com.waho.domain.User;
import com.waho.service.NodeService;
import com.waho.service.UserService;
import com.waho.util.MD5Utils;
import com.waho.websocket.WebSocketServlet;

public class UserServiceImpl implements UserService {
	private Logger logger = Logger.getLogger(this.getClass());

	@Override
	public Map<String, Object> login(String username, String password) {
		UserDao userDao = new UserDaoImpl();
		Map<String, Object> resultMap = null;
		User user;
		try {
			if (null != username && null != password && "".equals(username) == false && "".equals(password) == false) {
				user = userDao.selectUserByUsernameAndPassword(username, MD5Utils.MD5Encode(password, "utf-8"));
				if (user != null) {
					resultMap = new HashMap<String, Object>();
					resultMap.put("user", user);
					// 查询用户相关的设备数据
					NodeDao nodeDao = new NodeDaoImpl();
					List<Node> nodes = nodeDao.selectNodesByUserid(user.getId());
					resultMap.put("nodes", nodes);
				}
			} 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
}
	
	@Override
	public Map<String, Object> returnHome(String username, String password) {
		UserDao userDao = new UserDaoImpl();
		Map<String, Object> resultMap = null;
		User user;
		try {
			user = userDao.selectUserByUsernameAndPassword(username, password);
			if (user != null) {
				resultMap = new HashMap<String, Object>();        
				resultMap.put("user", user);
				// 查询用户相关的设备数据
				NodeDao nodeDao = new NodeDaoImpl();
				List<Node> nodes = nodeDao.selectNodesByUserid(user.getId());
				resultMap.put("nodes", nodes);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultMap;
	}

	@Override
	public Node getNodeByIdString(String nodeid) {
		int id;
		try {
			id = Integer.parseInt(nodeid);
			NodeDao nodeDao = new NodeDaoImpl();
			return nodeDao.selectNodeById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Boolean userWriteNodeCmd(String nodeid, String switchState, String percentage) {
		try {
			int id = Integer.parseInt(nodeid);
			NodeDao nodeDao = new NodeDaoImpl();
			Node node = nodeDao.selectNodeById(id);
			if (node == null || node.isOnline() == false) {
				return false;
			} else {// 设备存在，并且设备在线
				// 调用websocket发送指令接口,一个节点一个websocket
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
					if (socket.getId() == node.getId()) {
						Message cmd = new Message();
						cmd.setMsg("request");
						cmd.setCmd("write");
						cmd.setPrecentage(Integer.parseInt(percentage));
						if (switchState != null && switchState.equals("on")) {
							cmd.setSwitchState(1);
							 //4.记录此次操作类型lastOperateType;
							String operateType = "open";
							nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						} else {
							cmd.setSwitchState(0);
							 //4.记录此次操作类型lastOperateType;
							String operateType = "close";
							nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
						}
						String cmdStr = JSON.toJSONString(cmd);
						socket.sendMessage(cmdStr);
						logger.info("service to " + node.getMac() + ":" + cmdStr);
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
	public Boolean userRegister(String username, String password, String email) {
		if (username != null && "".equals(username) == false && password != null && "".equals(password) == false
				&& email != null && "".equals(email) == false) {
			UserDao userDao = new UserDaoImpl();
			User user;
			try {
				user = userDao.selectUserByUsername(username);
				if (user == null) {

					user = new User();
					user.setUsername(username);
					user.setPassword(MD5Utils.MD5Encode(password, "utf-8"));
					user.setEmail(email);

					int result = userDao.insert(user);
					if (result > 0) {
						return true;
					} else {
						return false;
					}
				} else {
					return false;
				}
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		return false;
	}

	@Override
	public String userRenameNode(String nodeid, String nodeName) {
		int id;
		String res = "";
		try {
			id = Integer.parseInt(nodeid);
			NodeDao nodeDao = new NodeDaoImpl();
			// 获得当前节点对象
			Node node = nodeDao.selectNodeById(id);
			// 查询当前节点名称是否已存在
			List<Node> list = new ArrayList<>();
		    list = nodeDao.selectNodesByUserid(node.getUserid());
		    for(Node obj : list) {
		    	if(obj.getNodeName().equals(nodeName)) {
		    		 res = "该名称已存在!";
		    		 return res;
		    	}
		    }
		    if(res == "" && node != null) {
		    	int result = nodeDao.updateNodeNameById(id, nodeName);
		    	if (result > 0) {
		    		res = "修改成功!";
				}else {
					res = "修改失败!";
				}
		    }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<Node> getNodeListByUserId(int id) {
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			List<Node> nodeList = nodeDao.selectNodesByUserid(id);
			return nodeList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public int removeNodeById(List<Integer> idList, int userid) {
		NodeDao nodeDao = new NodeDaoImpl();
		GroupNodeDao gnDao = new GroupNodeDaoImpl();
		GroupDao groupDao = new GroupDaoImpl();
		try {
			List<Node> nodeList = nodeDao.selectNodesByUserid(userid);
			List<Integer> newIdList = new ArrayList<Integer>();
			//所要删除的节点存在用户内，得到存在用户内的需删除节点的集合newIdList
			for (int id : idList) {
				for (Node node : nodeList) {
					if (id == node.getId()) {
						//若节点已加入到分组，从分组内移除，并更新分组节点的数量
						GroupNode obj = gnDao.selectNodeByUseridAndMac(node.getUserid(),node.getMac());
						if(obj != null) {
							 gnDao.deleteGroupNodeByGroupidAndNodeMac(obj.getMac(), obj.getGroupid());
							 Group group = groupDao.selectGroupByGroupid(obj.getGroupid());
							 groupDao.updataNodeNumByGroupid(group.getNodeNum()-1, group.getGroupid());
						}
						newIdList.add(id);
						break;
					}
				}
			}
			
			if (newIdList.size() > 0) {
				int[] result = nodeDao.updateUseridByid(1000,newIdList);
				int count = 0;
				for (int i : result) {
					if (i > 0) {
						count++;
					}
				}
				return count;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int userWriteWifiResetCmd(int userid, String ssid, String password, ArrayList<Integer> idList) {
		try {
			NodeDao nodeDao = new NodeDaoImpl();
			//根据节点的id集合得到节点对象集合
			List<Node> nodeList = new ArrayList<>();
			for(int id : idList) {
				Node obj = nodeDao.selectNodeById(id);
				if(obj.isOnline()) {	
					nodeList.add(obj);
				}
			}
	
			if (nodeList == null || nodeList.size() == 0) {
				return 0;
			} else {// 设备存在，并且设备在线
				int count = 0;
				// 调用websocket发送指令接口
				for (WebSocketServlet socket : WebSocketServlet.webSocketSet) {
					for (Node node : nodeList) {
						if (socket.getId() == node.getId()) {
							Message cmd = new Message();
							cmd.setMsg("request");
							cmd.setCmd("wifiReset");
							cmd.setSsid(ssid);
							cmd.setPw(password);
							String cmdStr = JSON.toJSONString(cmd);
							socket.sendMessage(cmdStr);
							logger.info("service to " + node.getMac() + ":" + cmdStr);
							count++;
						}
					}
				}
				return count;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	@Override
	public int addNodeToUser(String nodeMac, int userid) {
		NodeDao nodeDao = new NodeDaoImpl();
		try {
			Node node = nodeDao.selectNodeByMac(nodeMac);
			if (node == null) {
				return 0;
			} else {
				return nodeDao.updateUseridAndResetGroupState(userid, node.getId());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public User getUserMessage(int userid) {
		User user = new User();
		UserDao ud = new UserDaoImpl();
		try {
			user = ud.selectUserById(userid);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public boolean updateUserPassword(int userid, String newPassword) {
		UserDao userDao = new UserDaoImpl();
		boolean result = false;
		try {
			User user = userDao.selectUserById(userid);
			user.setPassword(newPassword);
			int num = userDao.updateUserPasswordByPassword(user);
			if(num != 0) {
				result = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Map<String, Object> getNodesByTypeAndUserid(int userid) {
		NodeDao nodeDao = new NodeDaoImpl();
		UserDao userDao = new UserDaoImpl();
		Map<String, Object> resultMap = null;
		//根据节点类型获取到镇流器节点集合、led驱动器集合、wifi无线调光器集合；
		List<Node> nodeList1 = null; //镇流器集合
		List<Node> nodeList2 = null; //led驱动器集合
		List<Node> nodeList3 = null; //wifi无线调光器集合
		try {
			//根据用户id和节点类型范围获得节点集合
			nodeList1 = nodeDao.selectBallastNodeByUseridAndType(userid);
			nodeList2 = nodeDao.selectLedNodeByUseridAndType(userid);
			nodeList3 = nodeDao.selectWifiNodeByUseridAndType(userid);
			resultMap = new HashMap<String, Object>();
			resultMap.put("ballast", nodeList1);
			resultMap.put("led", nodeList2);
			resultMap.put("wifi", nodeList3);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultMap;
	}

	@Override
	public boolean addBalletGroupToUser(String groupName, int userid) {
		GroupDao groupDao = new GroupDaoImpl();
		Boolean result = false;
		int type = 1; //镇流器分组
		//1.创建group对象
		Group group = new Group();
		group.setGroupName(groupName);
		group.setType(type);
		group.setUserid(userid);
		group.setNodeNum(0);
		//2.向用户里添加镇流器分组
		try {
			 if(groupDao.insertGroup(group) == 1) {
				 result = true;
			 }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Map<String, Object> getGroupByUserid(int userid) {
		GroupDao groupDao = new GroupDaoImpl();
		GroupNodeDao groupNodeDao = new GroupNodeDaoImpl();
		UserDao userDao = new UserDaoImpl();
		NodeDao nodeDao = new NodeDaoImpl();
		Map<String, Object> groupMap = null;
		//根据节点类型获取到镇流器分组集合、led驱动器分组集合、wifi无线调光器分组集合；
		List<Group> groupList1 = null; //镇流器分组集合
		List<Group> groupList2 = null; //led驱动器分组集合
		List<Group> groupList3 = null; //wifi无线调光器分组集合
		//type = 1 为镇流器分组；2为led驱动器分组；3为wifi无线调光器分组。
		int type1 = 1;
		int type2 = 2;
		int type3 = 3;
		try {
			
			groupList1 = groupDao.selectGroupByUseridAndType(userid,type1);
			groupList2 = groupDao.selectGroupByUseridAndType(userid,type2);
			groupList3 = groupDao.selectGroupByUseridAndType(userid,type3);
			groupMap = new HashMap<String, Object>();
			groupMap.put("ballastGroup", groupList1);
			groupMap.put("ledGroup", groupList2);
			groupMap.put("wifiGroup", groupList3);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return groupMap;
	}
	
	

	@Override
	public Map<String, Object> getGroupToRefersh(int userid) {
		GroupDao groupDao = new GroupDaoImpl();
		GroupNodeDao groupNodeDao = new GroupNodeDaoImpl();
		UserDao userDao = new UserDaoImpl();
		NodeDao nodeDao = new NodeDaoImpl();
		Map<String, Object> groupMap = null;
		//根据节点类型获取到镇流器分组集合、led驱动器分组集合、wifi无线调光器分组集合；
		List<Group> groupList1 = null; //镇流器分组集合
		List<Group> groupList2 = null; //led驱动器分组集合
		List<Group> groupList3 = null; //wifi无线调光器分组集合
		//type = 1 为镇流器分组；2为led驱动器分组；3为wifi无线调光器分组。
		int type1 = 1;
		int type2 = 2;
		int type3 = 3;
		try {
			
			groupList1 = groupDao.selectGroupByUseridAndType(userid,type1);
			groupList2 = groupDao.selectGroupByUseridAndType(userid,type2);
			groupList3 = groupDao.selectGroupByUseridAndType(userid,type3);
			groupMap = new HashMap<String, Object>();
			groupMap.put("ballastGroup", groupList1);
			groupMap.put("ledGroup", groupList2);
			groupMap.put("wifiGroup", groupList3);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return groupMap;

	}

	@Override
	public boolean addLedGroupToUser(String groupName, int userid) {
		GroupDao groupDao = new GroupDaoImpl();
		Boolean result = false;
		int type = 2;
		//1.创建group对象
		Group group = new Group();
		group.setGroupName(groupName);
		group.setType(type);
		group.setUserid(userid);
		group.setNodeNum(0);
		//2.向用户里添加镇流器分组
		try {
			 if(groupDao.insertGroup(group) == 1) {
				 result = true;
			 }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public boolean addWifiGroupToUser(String groupName, int userid) {
		GroupDao groupDao = new GroupDaoImpl();
		Boolean result = false;
		int type = 3;
		//1.创建group对象
		Group group = new Group();
		group.setGroupName(groupName);
		group.setType(type);
		group.setUserid(userid);
		group.setNodeNum(0);
		//2.向用户里添加镇流器分组
		try {
			 if(groupDao.insertGroup(group) == 1) {
				 result = true;
			 }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Node> getBallastNodes(int userid) {
		NodeDao nodeDao = new NodeDaoImpl();
		List<Node> list = null;
		try {
			//查询未加入分组的镇流器节点集合；镇流器type范围1-10
			list = nodeDao.selectBallastNodeByUseridAndTypeAndGroupState(userid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	@Override
	public List<Node> getLedNodes(int userid) {
		NodeDao nodeDao = new NodeDaoImpl();
		List<Node> list = null;
		try {
			//2.查找未加入到分组的led节点;镇流器type范围11-20;
			list = nodeDao.selectLedNodeByUseridAndTypeAndGroupState(userid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	@Override
	public List<Node> getWifiNodes(int userid) {
		NodeDao nodeDao = new NodeDaoImpl();
		List<Node> list = null;
		try {
			//2.查找未加入到分组的wifi节点;wifi无线调光器type范围21-30;
			list = nodeDao.selectWifiNodeByUseridAndTypeAndGroupState(userid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int addNodeToGroup(int groupid, String[] nodeMacArr) {
		GroupNodeDao gnd = new GroupNodeDaoImpl();
		GroupDao gd = new GroupDaoImpl();
		NodeDao nd = new NodeDaoImpl();
		Node node = new Node();
		int sum = 0;
		int num = 0;
		int groupState = 1;
		try {
			for(int i = 0; i < nodeMacArr.length; i++) {
				//1.向分组内插入节点
				node = nd.selectNodeByMac(nodeMacArr[i]);
				if(node.getGroupState() != 1) {
					 GroupNode groupNode = new GroupNode();
					 groupNode.setGroupid(groupid);
					 groupNode.setMac(node.getMac());
					 groupNode.setUserid(node.getUserid());
					 num = gnd.insertNodeToGroupByGroupid(groupNode);
					 if(num != 0) {
						sum++;
						//3.更新节点的分组标志位
						nd.updateGroupStateByMac(nodeMacArr[i],groupState);
						
			    		}
				}
			}
			//4.更新分组的节点数量
			 Group group = gd.selectGroupByGroupid(groupid);
			 gd.updataNodeNumByGroupid(group.getNodeNum()+sum,groupid);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sum;
	}
	

	@Override
	public boolean deleteGroupByGroupid(int groupid) {
		GroupDao gd = new GroupDaoImpl();
		NodeDao nd = new NodeDaoImpl();
		GroupNodeDao gnd = new GroupNodeDaoImpl();
		List<GroupNode> list = null;
		boolean result = false;
		try {
			
			list = gnd.selectNodeByGroupid(groupid);
			//1.更新节点的groupState属性，删除节点的分组后，设置groupState为0;
			if(list.size() > 0) {
				for(GroupNode obj : list) {
					nd.updateGroupStateByMacAndUserid(obj);
					Group group = gd.selectGroupByGroupid(groupid);
				}
				//2.删除分组（group_node）内的所有节点数据
				int num = gnd.deleteGroupNodeByGroupid(groupid);
				//3.删除分组（group_table）
				if(list.size() == num) {
					if(gd.deleteGroupByGroupid(groupid) == 1) {
						result = true;
					}
				}
			}else {
				int x = gd.deleteGroupByGroupid(groupid);
				if(x == 1) {
					result = true;
				}
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int renameGroupName(int userid, int groupid, String groupName) {
		GroupDao gd = new GroupDaoImpl();
		int x = 0;
	    try {
			x = gd.updateGroupNameByUseridAndGroupid(userid,groupid,groupName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return x;
	}

	@Override
	public int groupBroadcastDimByPwm(int userid, int groupid, int dimValue) {
			NodeDao nodeDao = new NodeDaoImpl();
			GroupNodeDao gnd = new GroupNodeDaoImpl();
			GroupDao groupDao = new GroupDaoImpl();
			List<Node> nodeList = null;
			int count = 0;
			//1.避免调光占空比范围超出100%
			if(dimValue > 100) {
				dimValue = 100;
			}
			
			try {
				//2.获取该分组下的节点集合
				List<GroupNode> groupNodeList = gnd.selectNodesByUseridAndGroupid(userid,groupid);
				if(groupNodeList == null || groupNodeList.size() ==0) {

				}else {//分组下存在节点
					for(GroupNode obj : groupNodeList) {
						Node node = nodeDao.selectOnlineNodesByUseridAndMac(obj.getMac(),userid);
						if(node != null) {
							for (WebSocketServlet socket : WebSocketServlet.webSocketSet) {
								if (socket.getId() == node.getId()) {
									Message cmd = new Message();
									cmd.setMsg("request");
									cmd.setCmd("write");
									cmd.setPrecentage(dimValue);
									cmd.setSwitchState(node.getSwitchState());
									String cmdStr = JSON.toJSONString(cmd);
									socket.sendMessage(cmdStr);
									count++;
									logger.info("service to " + node.getMac() + ":" + cmdStr);
									//记录此次节点和分组的操作类型lastOperateType;
									String operateType = "dim";
									nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
									groupDao.updateLastOperateTypeByGroupid(operateType,groupid);
								}
							}
						}
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return count;
	}

	@Override
	public int groupBroadcastSwitchNode(int userid, int groupid, int switchState, int percentage) {
		Node node = new Node();
		NodeDao nodeDao = new NodeDaoImpl();
		GroupNodeDao gnd = new GroupNodeDaoImpl();
		GroupDao gd = new GroupDaoImpl();
		List<GroupNode> groupNodeList = null;
		int count = 0;
		try {
			
			//1.获取该分组下的所有节点
			groupNodeList = gnd.selectNodesByUseridAndGroupid(userid, groupid);
			if(groupNodeList.size() > 0 || groupNodeList != null ) {
				for(GroupNode obj : groupNodeList) {
					//2.查询节点在线状态
				    node = nodeDao.selectOnlineNodesByUseridAndMac(obj.getMac(),userid);
				    //3.节点处于在线状态，匹配webSocket；发送指令
				    if(node != null) {
						for (WebSocketServlet socket : WebSocketServlet.webSocketSet) {
							if (socket.getId() == node.getId()) {
								Message cmd = new Message();
								cmd.setMsg("request");
								cmd.setCmd("write");
								cmd.setPrecentage(percentage);
								cmd.setSwitchState(switchState);
								String cmdStr = JSON.toJSONString(cmd);
								socket.sendMessage(cmdStr);
								count++;
								logger.info("service to " + node.getMac() + ":" + cmdStr);
								//4.记录此次节点与分组操作类型lastOperateType;
								if(switchState == 1) {
									String operateType = "open";
									nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
									gd.updateLastOperateTypeByGroupid(operateType,groupid);
								}else {
									String operateType = "close";
									nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
									gd.updateLastOperateTypeByGroupid(operateType,groupid);
								}
								
							}
						}
					}
				}
				//4.更新控制组的开关灯状态位
				gd.updateGroupswitchStatusByGroupid(switchState,groupid);
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int writeGroupBroadcastToningCmd(int userid, int groupid, int tonPrecentage) {
		GroupNodeDao gnd = new GroupNodeDaoImpl();
		NodeDao nd = new NodeDaoImpl();
		GroupDao groupDao = new GroupDaoImpl();
		List<GroupNode> list = null;
		Node node = new Node();
		int count = 0;
		try {
			
			list = gnd.selectNodesByUseridAndGroupid(userid, groupid);
			if(list.size() > 0 && list != null) {
				for(GroupNode obj : list) {
					node = nd.selectOnlineNodesByUseridAndMac(obj.getMac(), userid);
					if(node != null) {
						for (WebSocketServlet socket : WebSocketServlet.webSocketSet) {
							if (socket.getId() == node.getId()) {
								Message cmd = new Message();
								cmd.setMsg("request");
								cmd.setCmd("toning");
								cmd.setColorPrecentage(tonPrecentage);
								String cmdStr = JSON.toJSONString(cmd);
								socket.sendMessage(cmdStr);
								count++;
								logger.info("service to " + node.getMac() + ":" + cmdStr);
								//4.记录此次节点与分组操作类型lastOperateType;
								String operateType = "toning";
								nd.updateLastOperateTypeByNodeid(operateType,node.getId());
								groupDao.updateLastOperateTypeByGroupid(operateType,groupid);
							}
						}
					}
				}
			}
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int groupWriteLuxDimCmd(int userid, int groupid, int luxParam,String Cmd) {
		GroupNodeDao gnd = new GroupNodeDaoImpl();
		GroupDao groupDao = new GroupDaoImpl();
		NodeDao nd = new NodeDaoImpl();
		List<GroupNode> list = null;
		Node node = new Node();
		int count = 0;
		try {
			
			list = gnd.selectNodesByUseridAndGroupid(userid, groupid);
			if(list.size() > 0 && list != null) {
				for(GroupNode obj : list) {
					node = nd.selectOnlineNodesByUseridAndMac(obj.getMac(), userid);
					if(node != null) {
						for (WebSocketServlet socket : WebSocketServlet.webSocketSet) {
							if (socket.getId() == node.getId()) {
								Message cmd = new Message();
								cmd.setMsg("request");
								cmd.setCmd(Cmd);
								cmd.setLux(luxParam);
								String cmdStr = JSON.toJSONString(cmd);
								socket.sendMessage(cmdStr);
								count++;
								logger.info("service to " + node.getMac() + ":" + cmdStr);
								//4.记录此次节点与分组操作类型lastOperateType;
								String operateType = "luxdim";
								nd.updateLastOperateTypeByNodeid(operateType,node.getId());
								groupDao.updateLastOperateTypeByGroupid(operateType,groupid);
							}
						}
					}
				}
			}
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public Map<String, Object> getAllPloysByUserid(int userid) {
		Map<String, Object> result = null;
		//目前策略控制只针对led驱动器，故只用到ledPloyList 
		List<Ploy> ballastPloyList = null;
		List<Ploy> ledPloyList = null;
		List<Ploy> wifiPloyList = null;
		//groupType1为绑定镇流器分组；2为绑定led分组；3为绑定wifi无线调光器分组
		int groupType1 = 1;
		int groupType2 = 2;
		int groupType3 = 3;
		PloyDao ployDao = new PloyDaoImpl();
		try {
			result = new HashMap<String, Object>();
			ballastPloyList = ployDao.selectPloyByUseridAndGroupType(userid,groupType1);
			ledPloyList = ployDao.selectPloyByUseridAndGroupType(userid,groupType2);
			wifiPloyList = ployDao.selectPloyByUseridAndGroupType(userid,groupType3);
			result.put("ballastPloy", ballastPloyList);
			result.put("ledPloy",ledPloyList);
			result.put("wifiPloy", wifiPloyList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Group> getGroupByUseridAndGroupType(int userid, int groupType) {
		GroupDao groupDao = new GroupDaoImpl();
		//1.根据分组类型得到相应类型的分组集合
		List<Group> groupList = null;
		try {
			groupList = groupDao.selectGroupByUseridAndType(userid, groupType);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return groupList;
	}

	@Override
	public List<Ploy> getPloyByUseridAndPloyName(int userid, String ployName) {
		PloyDao ployDao = new PloyDaoImpl();
		List<Ploy> ployList = null;
		try {
			ployList = ployDao.selectPloyByUseridAndPloyName(userid,ployName);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ployList;
	}

	@Override
	public boolean addPloyToUserByGroupidAndGroupType(int userid, int groupType, int groupid, String ployName) {
		PloyDao ployDao = new PloyDaoImpl();
		boolean result = false;
		//1.新建策略对象ploy
		Ploy ploy = new Ploy();
		ploy.setGroupid(groupid);
		ploy.setGroupType(groupType);
		ploy.setPloyName(ployName);
		ploy.setRunState(0);
		ploy.setUserid(userid);
		//2.插入ploy对象
		int x = 0;
		try {
			x = ployDao.insertPloy(ploy);
			if(x==1){
				result = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int ployRename(int userid, int ployid, String ployName) {
		int result = 0;
		PloyDao ployDao = new PloyDaoImpl();
		try {
			//更新策略名称
		    if(ployDao.updatePloyNameByUseridAndPloyid(userid,ployid,ployName) == 1) {
		    	
		    	result = 1;
		    }
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Group getGroupObjByUseridAndGroupid(int userid, int groupid) {
		GroupDao groupDao = new GroupDaoImpl();
		Group group = new Group();
		try {
			
			group = groupDao.selectGroupByGroupidAndUserid(userid,groupid);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return group;
	}

	@Override
	public int deletePloy(int userid, int ployid) {
		PloyDao ployDao = new PloyDaoImpl();
		PloyOperateDao poDao = new PloyOperateDaoImpl();
		int x = 0;
		try {
			List<PloyOperate> list = poDao.selectPloyOpertaeByPloyid(ployid);
			if(list.size() > 0) { //策略下有操作，删除策略操作后删除策略
				int num = poDao.deletePloyOperateByPloyid(ployid);
				if(list.size() == num) {
					ployDao.deletePloyByUseridAndPloyid(userid,ployid);
					x = 1;
				}
			}else { ///策略下无操作，直接删除策略
				ployDao.deletePloyByUseridAndPloyid(userid,ployid);
				x = 1;
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return x;
	}

	@Override
	public boolean addPloyOperateOfSwitch(int userid, int ployid, int hours, int minutes, Date startDate, Date endDate,
			int value) {
		PloyOperateDao poDao = new PloyOperateDaoImpl();
		PloyDao ployDao = new PloyDaoImpl();
		Ploy ploy = new Ploy();
		boolean result = false;
		try {
			ploy = ployDao.selectPloyByPloyidAndUserids(ployid,userid);
			//创建ployOperate对象
			PloyOperate operate = new PloyOperate(); 
			operate.setPloyid(ployid);
			operate.setPloyName(ploy.getPloyName());
			operate.setStartDate(startDate);
			operate.setEndDate(endDate);
			operate.setHours(hours);
			operate.setMinutes(minutes);
			//策略操作的类型：开关灯设置为1；调光设置为2；调色设置为3
			operate.setOperateType(1);
			operate.setOperateParam(value);
			operate.setState(0);
			int num = 0;
			num = poDao.insertPloyOperate(operate);
			if(num > 0) {
				result = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result ;
	}

	@Override
	public boolean addPloyOperateOfDim(int userid, int ployid, int hours, int minutes, Date startDate, Date endDate,
			int value) {
		PloyOperateDao poDao = new PloyOperateDaoImpl();
		PloyDao ployDao = new PloyDaoImpl();
		Ploy ploy = new Ploy();
		boolean result = false;
		try {
			ploy = ployDao.selectPloyByPloyidAndUserids(ployid,userid);
			//创建ployOperate对象
			PloyOperate operate = new PloyOperate(); 
			operate.setPloyid(ployid);
			operate.setPloyName(ploy.getPloyName());
			operate.setStartDate(startDate);
			operate.setEndDate(endDate);
			operate.setHours(hours);
			operate.setMinutes(minutes);
			//策略操作的类型：开关灯设置为1；调光设置为2；调色设置为3
			operate.setOperateType(2); 
			operate.setOperateParam(value);
			int num = 0;
			num = poDao.insertPloyOperate(operate);
			if(num > 0) {
				result = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result ;
	}

	@Override
	public boolean addPloyOperateOfToning(int userid, int ployid, int hours, int minutes, Date startDate, Date endDate,
			int value) {
		PloyOperateDao poDao = new PloyOperateDaoImpl();
		PloyDao ployDao = new PloyDaoImpl();
		Ploy ploy = new Ploy();
		boolean result = false;
		try {
			ploy = ployDao.selectPloyByPloyidAndUserids(ployid,userid);
			//创建ployOperate对象
			PloyOperate operate = new PloyOperate(); 
			operate.setPloyid(ployid);
			operate.setPloyName(ploy.getPloyName());
			operate.setStartDate(startDate);
			operate.setEndDate(endDate);
			operate.setHours(hours);
			operate.setMinutes(minutes);
			//策略操作的类型：开关灯设置为1；调光设置为2；调色设置为3
			operate.setOperateType(3); 
			operate.setOperateParam(value);
			int num = 0;
			num = poDao.insertPloyOperate(operate);
			if(num > 0) {
				result = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result ;
	}

	@Override
	public int changePloyRunState(int userid, int ployid, int runState) {
		PloyDao ployDao = new PloyDaoImpl();
		int x =0;
		try {
			x = ployDao.updateRunStateByUseridAndId(userid,ployid,runState);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return x;
	}

	@Override
	public List<PloyOperate> getPloyOperate(int ployid) {
		PloyOperateDao poDao = new PloyOperateDaoImpl();
		List<PloyOperate> list = null;
		try {
			list = poDao.selectPloyOpertaeByPloyid(ployid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean deletePloyOperate(int operateId) {
		boolean result = false;
		PloyOperateDao poDao = new PloyOperateDaoImpl();
		try {
			int x = poDao.deletePloyOperateByid(operateId);
			if(x == 1) {
				result = true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Node> getGroupNode(int groupid) {
		List<Node> nodeList = null;
		List<GroupNode> gnList = null;
		NodeDao nodeDao = new NodeDaoImpl();
		NodeService ns = new NodeServiceImpl();
		GroupNodeDao gnDao = new GroupNodeDaoImpl();
		try {
			
			gnList = gnDao.selectNodeByGroupid(groupid);
			nodeList = ns.currencyGetNodeListInGroup(gnList);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return nodeList;
	}

	@Override
	public boolean removeNodeFromGroup(int userid, int nodeid,int groupid) {
		int x = 0;
		boolean result = false;
		NodeDao nodeDao = new NodeDaoImpl();
		GroupDao groupDao = new GroupDaoImpl();
		GroupNodeDao gnDao = new GroupNodeDaoImpl();
		try {
			Node node = nodeDao.selectNodeById(nodeid);
			x = gnDao.deleteGroupNodeByGroupidAndNodeMac(node.getMac(),groupid);
			if(x == 1) {
				int groupState = 0;
				//1.恢复节点的分组标志位
				nodeDao.updateGroupStateByMac(node.getMac(), groupState);
				result = true;
				Group group = groupDao.selectGroupByGroupid(groupid);
				//2.更新分组节点的数量
				groupDao.updataNodeNumByGroupid(group.getNodeNum()-1, groupid);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean writeNodeToningCmd(int nodeid, int tonPercentage) {
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
						//4.记录此次操作类型lastOperateType;
						String operateType = "toning";
						nodeDao.updateLastOperateTypeByNodeid(operateType,node.getId());
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
	public int getWarnningTips(int userid) {
		int result = 0;
		AlarmDao alarmDao = new AlarmDaoImpl();
		List<Alarm> list = null;
		try {
			//查找报警信息集合
			list = alarmDao.selectAlarmByUserid(userid);
			result = list.size();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Alarm> getAlarmMessage(int userid) {
		List<Alarm> alarmRecord = new ArrayList<>();
		AlarmDao alarmDao = new AlarmDaoImpl();
		try {
			//1.查询用户下的所有报警信息集合
			alarmRecord = alarmDao.selectAlarmByUserid(userid);
			//2.冒泡法进行日期排序：较近的日期靠前
			for(int i = 0;i < alarmRecord.size()-1;i++) {//外层循环控制排序趟数
				for(int j = 0; j < alarmRecord.size()-1-i; j++ ) {//内层循环控制每一趟排序多少次
					Date date1 = alarmRecord.get(j).getDate();
					Date date2 = alarmRecord.get(j+1).getDate();
					if(date1.before(date2)) {
						 Collections.swap(alarmRecord, j, j + 1);//集合中j和j+1位交换位置
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return alarmRecord;
	}

	@Override
	public int deleteAlarmMessage(String[] alarmIdArr) {
		int count = 0;
		AlarmDao alarmDao = new AlarmDaoImpl();
		try {
			for(int index=0; index < alarmIdArr.length; index++) {
				System.out.println("id:"+alarmIdArr[index]);
				int x = alarmDao.deleteAlarmById(Integer.parseInt(alarmIdArr[index]));
				if(x == 1) {
					count++;
				}
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public Map<String, Object> getNodeListByUserid(int userid) {
		NodeDao nodeDao = new NodeDaoImpl();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//根据节点类型获取到镇流器节点集合、led驱动器集合、wifi无线调光器集合；
		List<Node> nodeList1 = new ArrayList<Node>(); //镇流器集合
		List<Node> nodeList2 = new ArrayList<Node>();  //led驱动器集合
		List<Node> nodeList3 = new ArrayList<Node>();  //wifi无线调光器集合
		//根据用户id和节点类型范围获得节点集合
		try {
			nodeList1 = nodeDao.selectBallastNodeByUseridAndType(userid);
			nodeList2 = nodeDao.selectLedNodeByUseridAndType(userid);
			nodeList3 = nodeDao.selectWifiNodeByUseridAndType(userid);
			//新建子节点children tree对象集合
			List<TreeChildModel> treeChildrenList1 = new  ArrayList<TreeChildModel>();
			List<TreeChildModel> treeChildrenList2 = new  ArrayList<TreeChildModel>();
			List<TreeChildModel> treeChildrenList3 = new  ArrayList<TreeChildModel>();
			//得到三种类型节点灯具的子节点对象（childtree）集合
			for(Node obj : nodeList1) { //镇流器的树形子节点模型
				TreeChildModel treeChildModel1 = new TreeChildModel();
				treeChildModel1.setId(obj.getId());
				treeChildModel1.setLabel(obj.getNodeName());
				treeChildModel1.setChecked(false);
				treeChildrenList1.add(treeChildModel1);
			}
			for(Node obj2 : nodeList2) { //led的树形子节点模型
				TreeChildModel treeChildModel2 = new TreeChildModel();
				treeChildModel2.setId(obj2.getId());
				treeChildModel2.setLabel(obj2.getNodeName());
				treeChildModel2.setChecked(false);
				treeChildrenList2.add(treeChildModel2);
			}
			for(Node obj3 : nodeList3) { //wifi的树形子节点模型
				TreeChildModel treeChildModel3 = new TreeChildModel();
				treeChildModel3.setId(obj3.getId());
				treeChildModel3.setLabel(obj3.getNodeName());
				treeChildModel3.setChecked(false);
				treeChildrenList3.add(treeChildModel3);
			}
			//得到节点tree对象
			NodeTreeModel nodeTreeModel1 = new NodeTreeModel();
			nodeTreeModel1.setId(1);
			nodeTreeModel1.setLabel("镇流器");
			nodeTreeModel1.setSpread(false);
			nodeTreeModel1.setChildren(treeChildrenList1);
			
			NodeTreeModel nodeTreeModel2 = new NodeTreeModel();
			nodeTreeModel2.setId(2);
			nodeTreeModel2.setLabel("Led驱动器");
			nodeTreeModel2.setSpread(false);
			nodeTreeModel2.setChildren(treeChildrenList2);
			
			NodeTreeModel nodeTreeModel3 = new NodeTreeModel();
			nodeTreeModel3.setId(3);
			nodeTreeModel3.setLabel("wifi无线调光器");
			nodeTreeModel3.setSpread(false);
			nodeTreeModel3.setChildren(treeChildrenList3);
			
			resultMap.put("ballasts", nodeTreeModel1);
			resultMap.put("leds", nodeTreeModel2);
			resultMap.put("wifis", nodeTreeModel3);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	/*	NodeDao nodeDao = new NodeDaoImpl();
		UserDao userDao = new UserDaoImpl();
		Map<String, Object> resultMap = null;
		//根据节点类型获取到镇流器节点集合、led驱动器集合、wifi无线调光器集合；
		List<Node> nodeList1 = null; //镇流器集合
		List<Node> nodeList2 = null; //led驱动器集合
		List<Node> nodeList3 = null; //wifi无线调光器集合
		try {
			//根据用户id和节点类型范围获得节点集合
			nodeList1 = nodeDao.selectBallastNodeByUseridAndType(userid);
			nodeList2 = nodeDao.selectLedNodeByUseridAndType(userid);
			nodeList3 = nodeDao.selectWifiNodeByUseridAndType(userid);
			resultMap = new HashMap<String, Object>();
			resultMap.put("ballast", nodeList1);
			resultMap.put("led", nodeList2);
			resultMap.put("wifi", nodeList3);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		*/
		return resultMap;
	}

	@Override
	public Boolean resetNodeApModel(String[] nodeIdArr) {
		Boolean result = false;
		NodeDao nodeDao = new NodeDaoImpl();
		for(int i = 0; i < nodeIdArr.length; i++) {
			int id = Integer.parseInt(nodeIdArr[i]);
			try {
				Node node = nodeDao.selectNodeById(id);
				if (node == null || node.isOnline() == false) {
				
				} else {// 设备存在，并且设备在线
					// 调用websocket发送指令接口,一个节点一个websocket
					for (WebSocketServlet socket : WebSocketServlet.webSocketSet){
						if (socket.getId() == node.getId()) {
							System.out.println("if");
							Message cmd = new Message();{//恢复节点ap模式指令
							cmd.setMsg("request");
							cmd.setCmd("wifiApModel");
							String cmdStr = JSON.toJSONString(cmd);
							socket.sendMessage(cmdStr);
							logger.info("service to " + node.getMac() + ":" + cmdStr);
							result = true;
						}
					}
				}
			
			}
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
		}
		return result;
	}

	@Override
	public List<Group> getGroupByUseridForPloyChangeGroup(int groupid, int userid,int groupType) {
		GroupDao groupDao = new GroupDaoImpl();
		List<Group> result = new ArrayList<>();
		try {
			// 获取分组集合
			result = groupDao.selectGroupByUseridAndType(userid, groupType);
			
			// 移除变量groupid所在的分组
	        Iterator<Group> it = result.iterator(); //获取迭代器
	        while(it.hasNext()){
	            Group group = it.next();
	            if(group.getGroupid() == groupid){
	                it.remove();
	            }
	        }
	        

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Boolean changePloyGroup(int ployid, int groupid) {
		int x = 0;
		PloyDao ployDao = new PloyDaoImpl();
	    try {
			x = ployDao.updateGroupidByPloyid(ployid,groupid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(x > 0) {	
			return true;
		}else {
			return false;
		}
	}

	
	
	
	
}