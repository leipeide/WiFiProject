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
	<form class="layui-form"
		action="${pageContext.request.contextPath }/nodeLuxDimServlet" method="post">
		<input type="hidden" name="nodeid" value="${nodeid }">
		<!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 100px;">打开自动调光</label>
			<div class="layui-input-block">
				<input type="checkbox" name="switchState" lay-skin="switch">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 180px;">输入调光参数（1-60000）</label>
			<div style="width: 180px;margin-left:80px">
				<input id="text1" type="text" name="lux" required lay-verify="required"
					autocomplete="off" class="layui-input" onchange="percentCheck(this)">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn">提交</button>
			</div>
		</div>

	</form>
	<script>
		layui.use('form', function() {
			var form = layui.form;
			
		});
		
		function percentCheck(obj){
			var val = document.getElementById("text1").value;
			if(val<0){
				obj.value = 0;
			}if(val>60000){
				obj.value = 60000;
			}
		}
	</script>
</body>
</html>