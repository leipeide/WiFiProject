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
<title>Insert title here</title>
</head>
<body>
	<%
//搜索节点错误返回节点页面提示错误信息
     Object message = request.getAttribute("message");
     if(message!=null && !"".equals(message)){
  %>
	<script type="text/javascript">
      		layui.use('layer', function() {
				var layer = layui.layer;
				layer.alert('<%=message%>',{
					offset:['50px','350px']
				});  
			});
      </script>
	<%} %>
	<form class="layui-form"
		action="${pageContext.request.contextPath }/deleteAlarmMessageServlet"
		method="post">
		<input type="hidden" id="userid" name="userid" value="${userid}">
		<button class="layui-btn" lay-submit lay-filter="*">删除记录</button>
		<table class="layui-table">
			<colgroup>
				<col width="30">
				<col width="120">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" id="checkAll" lay-skin="primary"
						lay-filter="allChoose"></th>
					<th>节点地址</th>
					<th>报警原因</th>
					<th>参数</th>
					<th>报警时间</th>
				</tr>
			</thead>
			<!-- ajax动态获取表格内容 -->
			<tbody id="tbody"></tbody>
		</table>
		<div id="paging" style="margin-left: 40%"></div>
	</form>
	<script>
		layui.use(['form'], function() {
			var form = layui.form;
			form.render();
			form.on('checkbox(allChoose)', function(data){
				if(data.elem.checked){
					var oneCheck = document.getElementsByName("checkOne");
					for(var i=0; i < oneCheck.length; i++){
						oneCheck[i].checked = true;
						}
				}else{
					var oneCheck = document.getElementsByName("checkOne");
					for(var i=0; i < oneCheck.length; i++){
						oneCheck[i].checked = false;
						}
				}
				form.render();
			});        

		});
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
			function AjaxGetAlarmMessageRequest() {
				//1.创建请求
				var req = getXMLHttpRequest();
				//4.服务器处理
				req.onreadystatechange = function() {
					if (req.readyState == 4) {// 请求成功
						if (req.status == 200) {// 服务器响应成功,动态获取报警信息表格
							var list = JSON.parse(req.responseText);
							var inner = "";
							var alarm = "";
							for(var i = 0; i < list.length; i ++){
								alarm = list[i];
								msTime = new Date(alarm.date);
								dateTime = msTime.toLocaleString();
								inner = inner + "<tr><td><input type='checkbox' name='checkOne' value='" + alarm.id + "' lay-skin='primary' lay-filter='oneChoose'></td>\
								<td>" + alarm.mac + "</td>\
								<td>";
								if (alarm.type == 1) {
									inner = inner + "节点过功率";
								} else if(alarm.type == 2){
									inner = inner + "节点断开连接";
								} else if(alarm.type == 3){
									inner = inner + "节点高温报警";
								}
								inner = inner + "</td>\
								<td>";
								if (alarm.type == 1) {
									inner = inner + alarm.power + "W";
								} else if(alarm.type == 2){
									inner = inner + "- -";
								} else if(alarm.type == 3){
									inner = inner + alarm.temperature + '&#8451;';
								}
								inner = inner + "</td>\
								<td>" + dateTime + "</td>\
								</tr>";
							}
							document.getElementById("tbody").innerHTML = inner;
							layui.use(['form'], function() {
								var form = layui.form;
								form.render();
							});
						}
					}
				}
				//1.建立链接
				var userid = document.getElementById("userid").value;
				req.open("post","${pageContext.request.contextPath }/getWarnningMessageServlet");
				req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				//2.发送请求
				req.send("userid="+userid);
			}
			window.onload = function() {
				AjaxGetAlarmMessageRequest();
			}
			/*
			*注意：
			*页面刷新，指定2分钟刷新一次；
			*由于页面操作时会刷新数据；且报警页面只针对离线/高温/过功率报警，出现报警情况的发生概率较低
			*故不需要刷新太频繁，在此将刷新时间设置为2分钟
			*/
			setInterval(AjaxGetAlarmMessageRequest,1000*60*2);
			
	</script>
</body>
</html>