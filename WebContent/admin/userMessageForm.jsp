
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
<title>个人主页</title>
</head>
<body><form  class="layui-form" action="" method="post">
		<div><div class="layui-nav layui-nav-tree layui-nav-side">
				<div class="layui-nav-item">
					<a href="${pageContext.request.contextPath }/showUserMessageServlet?userid=${userid}" target="userM"><i class="layui-icon layui-icon-user" style="font-size: 35px;"></i>  个人主页</a></div>
				<div class="layui-nav-item">
					<a href="${pageContext.request.contextPath }/repasswordFormServlet?userid=${userid}" target="userM"><i class="layui-icon layui-icon-password"></i>  修改密码</a></div>
				<div class="layui-nav-item">
					<a href="javascript:;" onclick="homePage('${pageContext.request.contextPath }/returnHomeServlet',${userid})"><i class="layui-icon layui-icon-home"></i> 返回首页</a></div>
			</div>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div style="padding: 15px;" id="body-div">
				<iframe style="min-height: 500px" name="userM" frameborder="0" scrolling="no" width="100%"
					src="${pageContext.request.contextPath }/showUserMessageServlet?userid=${userid}" 
					class="body-frame"></iframe>
		     </div>
	 	</div></div>
	</form>
	
	<script type="text/javascript">
		//1.跳转到主页
		function homePage(url,userid){
			location.href = url + "?userid="+userid;
			}
	</script>
</body>
</html>