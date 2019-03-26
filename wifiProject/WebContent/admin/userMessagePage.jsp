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
<style> 
.userMessage{
	position: absolute;
	margin-right:200px;
	padding:50px;
	padding-left:150px;
	height:60%;
	width:50%; 
	border:1px } 
</style> 
</head>
<body><form class="layui-form" action="" method="post">
		<div>
			<div><blockquote class="layui-elem-quote layui-quote-nm" >
					<font size='5'>个人资料</font></blockquote>
				 <hr class="layui-bg-cyan" > 
			</div>
			<div class="userMessage" >
				<div class="layui-form-item">
					<label>用户ID：<span>${user.id }</span></label>
					</div>
				<div class="layui-form-item">
					<label>用户名：<span>${user.username }</span></label>
					</div>
				<div class="layui-form-item">
					<label>邮箱地址：<span>${user.email }</span></label>
					</div>
<!-- 				<div class="layui-form-item"> -->
<%-- 					<label>电话号码：<span>${user.phone}</span></label> --%>
<!-- 				</div> -->
			</div>	
		</div>
	  </form>
</body>
</html>