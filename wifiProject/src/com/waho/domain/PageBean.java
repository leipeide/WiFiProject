package com.waho.domain;

import java.util.List;

public class PageBean {
	//分页总的页数
	private int totalPage;
	//每页显示数据的个数
	private int pageSize;
	//当前页面
	private int currentPage;
	//所有节点总数
	private int count;
	//每页节点
	private List<Node>nodes;
	//每页开始数据
	private int star;
	
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currPage) {
		this.currentPage = currPage;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List<Node> getNodes() {
		return nodes;
	}
	public void setNodes(List<Node> nodes) {
		this.nodes = nodes;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	
}
