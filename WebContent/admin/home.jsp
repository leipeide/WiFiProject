<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
<title>浙江雷培德WiFi灯光智能控制系统</title>
<style type="text/css">

</style>
</head>
<!-- <body class="layui-layout-body">  -->
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">雷培德WiFi灯控系统</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="javascript:void(0)"
					onclick="location.reload()">首页</a></li>
				<li class="layui-nav-item"><a href="javascript:void(0)"
					onclick="ployControl('${pageContext.request.contextPath}/groupFromServlet',${result.user.id})">分组管理</a></li>
				<li class="layui-nav-item"><a href="javascript:void(0)"
					onclick="ployControl('${pageContext.request.contextPath}/ployFromServlet',${result.user.id})">策略管理</a></li>
				<li class="layui-nav-item"><a href="javascript:void(0)"
					onclick="alarmMessage('${pageContext.request.contextPath}/alarmFromServlet',${result.user.id})">报警<span class="layui-badge" id="warnning"></span></a></li>
			</ul>
<!-- 			<ul class="layui-nav layui-layout-right"> -->
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> <img
						src="http://t.cn/RCzsdCq" class="layui-nav-img">
							${result.user.username }
				</a>
					<dl class="layui-nav-child">
						<dd>
								<a href="javascript:;" onclick="um('${pageContext.request.contextPath}/userMessagesPageServlet',${result.user.id})">基本资料</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="${pageContext.request.contextPath}/admin/login.jsp">退出</a></li>
			</ul>
		</div>

		<div class="layui-side">
			<div class="layui-side-scroll layui-bg-black">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<li class="layui-nav-item"><a href="javascript:;" onclick="addNode('${pageContext.request.contextPath}/addNodeFormServlet', ${result.user.id })">添加节点</a></li>
					<li class="layui-nav-item"><a href="javascript:;" onclick="removeNodeFunction('${pageContext.request.contextPath}/removeNodeFormServlet', ${result.user.id })">删除节点</a></li>
					<li class="layui-nav-item"><a href="javascript:;" onclick="wifiReset('${pageContext.request.contextPath}/wifiResetFormServlet', ${result.user.id })">更改WiFi网络</a></li>
 					<li class="layui-nav-item"><a href="javascript:;" onclick="wifiApModel('${pageContext.request.contextPath}/wifiApFormServlet', ${result.user.id })">清除WIFI信息</a></li>
				</ul>
			</div>
		</div>

		<div class="layui-body">
			<!-- 作为隐藏标签，传递用户id值 -->
			<input type="hidden" id="useridInput" value=${result.user.id }>
			<!-- 内容主体区域 -->
			<div style="padding: 15px;" id="body-div">
				<iframe style="min-height: 500px" name="fname" frameborder="0"
					scrolling="no" width="100%"
					  src="${pageContext.request.contextPath }/welcomeServlet?userid=${result.user.id }"
					class="body-frame"></iframe>
			</div>
		</div>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			© 雷培德WiFi灯控系统
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/home.js"></script>
	<script type="text/javascript">
	/**
	 * 获取报警数量提示
	 * @returns
	 */
	//A.创建XMLHttpRequest对象,获取“报警”栏信息数量提示
	function getXMLHttpRequest() {
			var xmlhttp;
			if (window.XMLHttpRequest) {
				// code for IE7+,Firefox,Chrome,Opera,Safari
				xmlhttp = new XMLHttpRequest();
			} else {
				// code for IE5,IE6,
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			return xmlhttp;
		}
	//B.创建回调函数，根据响应动态更新页面
	function AjaxGetAlarmTipsRequest() {
		//1.创建请求
		var req = getXMLHttpRequest();
		//4.服务器处理
		req.onreadystatechange = function() {
			if (req.readyState == 4) {// 请求成功
				if (req.status == 200) {// 服务器响应成功,动态获取报警信息表格
					var warnningNum = JSON.parse(req.responseText);
					document.getElementById("warnning").innerHTML = warnningNum;
				}
			}
		}
		//1.建立链接
		var userid = document.getElementById("useridInput").value;
		req.open("post","${pageContext.request.contextPath }/getWarnningTipsServlet");
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//2.发送请求
		req.send("userid="+userid);
	}
	window.onload = function() {
		AjaxGetAlarmTipsRequest();
	}
	setInterval(AjaxGetAlarmTipsRequest,1000*5);
	
	</script>
</body>
</html>