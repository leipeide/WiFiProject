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
.label{
	margin-left : 25px;
	width : 160px;
}
.layui-form-item{
	padding-top:20px;
}
</style>
</head>
<body>
	<form class="layui-form" action="${pageContext.request.contextPath }/ployChangeGroupServlet?ployid=${ployid}" method="post">
		<div class="layui-form-item">
 			<label class="label" >请从下面选项中选择一个</label></br> 
			<div class="layui-input-block" >
				<c:forEach items="${groupList}" var="group">
 					<input type="radio" name="oneCheck" value="${group.groupid}" title="${group.groupName }" lay-filter="filter"></br> 
				</c:forEach>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn">确定</button>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		layui.use(['form'], function(){
			  var form = layui.form;
			  //1.监听单选框
			  form.on('radio()', function(data){
				  
				}); 
			  
			});	 
	</script>
</body>
</html>