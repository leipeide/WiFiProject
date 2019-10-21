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
<style type="text/css">
.input{
	margin-top:20px;
}
.submit{
	margin-top:40px;
}
</style>
</head>
<body>
	<form class="layui-form"
		action="${pageContext.request.contextPath }/nodeInGroupPwmDimServlet" method="post">
		<input type="hidden" name="nodeid" value="${nodeid }">
		<!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
		<div class="input">
			<label class="layui-form-label">输出百分比</label>
			<div class="layui-input-block" style="width: 100px;">
				<input id="text1" type="text" name="percentage" placeholder="0-100" autocomplete="off" 
					required lay-verify="required" class="layui-input" onchange="percentCheck(this)">
			</div>
		</div>
		<div class="submit">
			<div class="layui-input-block">
				<button class="layui-btn">提交</button>
			</div>
		</div>
		<!-- 更多表单结构排版请移步文档左侧【页面元素-表单】一项阅览 -->
	</form>
	<script>
		layui.use('form', function() {
			var form = layui.form;
			
		});
		
		function percentCheck(obj){
			var val = document.getElementById("text1").value;
			if(val<0){
				obj.value = 0;
			}if(val>100){
				obj.value = 100;
			}
		}
	</script>
</body>
</html>