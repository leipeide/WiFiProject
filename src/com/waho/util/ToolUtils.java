package com.waho.util;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.waho.domain.Node;

/**
 * 作为工具类，里面包含通用方法，可直接调用，降低代码繁琐性
 * @author yan li
 *
 */

public class ToolUtils {
	/**
	 * 通用方法，可直接调用
	 * 将节点集合里的网络属性：在线离线状态，进行排序；使得前端展示的是在线节点先显示，离线节点后显示
	 * @param OldList
	 * @return
	 */
	public static List<Node> NodeNetStateSort(List<Node> OldList) {
		List<Node> OfflineList = new ArrayList<Node>();
		List<Node> NewList = new ArrayList<Node>();
		for(Node obj : OldList) {
			if(obj.isOnline()) { //节点在线
				NewList.add(obj); //节点在线则加入在线节点集合
				
			}else {
				OfflineList.add(obj); //离线节点先载入新的集合中
			}
			
		}
		//最后将离线节点集合添加到在线集合中；list集合遵循有序原则:存储和取出元素顺序一致
		NewList.addAll(OfflineList); 
		return NewList;
	}

}
