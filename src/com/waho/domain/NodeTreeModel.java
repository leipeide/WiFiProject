package com.waho.domain;

import java.util.List;

public class NodeTreeModel {
	private String label; //tree节点标题
	private Integer id; // 节点唯一索引值，用于对指定节点进行各类操作
	private boolean spread; //树形结构内元素不展开设置spread: false
	private List<TreeChildModel> children; // 解析数据列表
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public boolean isSpread() {
		return spread;
	}
	public void setSpread(boolean spread) {
		this.spread = spread;
	}
	public List<TreeChildModel> getChildren() {
		return children;
	}
	public void setChildren(List<TreeChildModel> children) {
		this.children = children;
	}
	@Override
	public String toString() {
		return "NodeTreeModel [label=" + label + ", id=" + id + ", spread=" + spread + ", children=" + children
				+ ", getLabel()=" + getLabel() + ", getId()=" + getId() + ", isSpread()=" + isSpread()
				+ ", getChildren()=" + getChildren() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	
	
}
