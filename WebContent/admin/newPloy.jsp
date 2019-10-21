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
	<form class="layui-form" action="${pageContext.request.contextPath }/newPloyServlet?userid=${userid }&groupType=${groupType }" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">策略名称</label>
			<div class="layui-input-block" style="width: 150px;">
				<input type="text" id="newName" name="newName" required lay-verify="required" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">选择分组</label>
			<div class="layui-input-block" style="width: 150px;">
				<select id="groupSelect" name="groupid" lay-filter="selectGroup" required lay-verify="required">
  						<option value="">请选择</option>
					<c:forEach items="${groups}" var="group">
  						<option value="${group.groupid}">${group.groupName}</option>
					</c:forEach>
				</select>   
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn">提交</button>
			</div>
		</div>
	</form>
	<script type="text/javascript">    
		layui.use(['form'], function(){
			  var layer = layui.layer;
			  //1.监听select下拉选择框
			  form.on('select(selectGroup)', function(data){
				
				});  
			});	 
	</script>
</body>
</html>