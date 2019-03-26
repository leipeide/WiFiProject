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
.userMessage {
	position: absolute;
	margin-right: 200px;
	padding: 50px;
/* 	padding-left: 70px; */
	height: 60%;
	width: 50%;
	border: 1px
}
</style> 
</head>
<body><form class="layui-form" action="${pageContext.request.contextPath }/repasswordServlet" method="post">
		<input name="userid" type="hidden" value="${userid}" >
	  	<div>
	  		<blockquote class="layui-elem-quote layui-quote-nm" ><font size='5'>修改密码</font></blockquote>
			<hr class="layui-bg-cyan" >
		</div>
		<div class="userMessage">
			<div class="layui-form-item">
							<label class="layui-form-label">旧密码</label>
							<div class="layui-input-inline">
								<input type="password" name="prePassword" value="" required
									lay-verify="required" placeholder="请输入密码" autocomplete="off"
									class="layui-input">${ckpw}
							</div>
						</div>
						
			<div class="layui-form-item">
							<label class="layui-form-label">新密码</label>
							<div class="layui-input-inline">
								<input type="password" name="newPassword" value="" required
									lay-verify="required" placeholder="请输入新密码" autocomplete="off"
									class="layui-input">
							</div>
						</div>
						
			<div class="layui-form-item">
							<label class="layui-form-label">请确认密码</label>
							<div class="layui-input-inline">
								<input type="password" name="rePassword" value="" required
									lay-verify="required" placeholder="请再次输入密码" autocomplete="off"
									class="layui-input">${cknpw}
							</div>
						</div>		
				
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn layui-btn-sm" lay-submit lay-filter="sub">提交</button>
						${retext}
				</div></div>
			</div>
		</div>
	</form>
	
<script>
		//Demo
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(sub)', function(data) {
				//layer.msg(JSON.stringify(data.field));
				console.log(data.form)
				//return false;
			});
		});
</script>
</body>
</html>