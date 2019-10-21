package com.waho.domain;

import java.util.List;

public class TreeChildModel {
	private String label; //tree节点标题
	private Integer id; // 节点唯一索引值,节点id
	private boolean checked; //节点是否初始为选中状态（如果开启复选框的话）
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
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
}
