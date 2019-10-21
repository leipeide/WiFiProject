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
<title></title>
<style>
.bodyDiv{
	margin-top:10px;
	padding-buttom:5px;
/* 	border:5px solid #95E75D; */
}
.colorControlDiv{
	padding-top:5px;
	height:60px;
/* 	border:1px solid #00695F; */
}
.colorControlSlide{
	padding-top:50px;
	width:120px;
 	margin-left:50px; 
/*  	border:5px solid #000;  */
}
.nodeDiv{
	padding-top:10px;
/*  	border:1px solid #C01C1C;  */
}
</style>
</head>
<body>
	<from class="layui-form" 
		action="" method="post">
	<div class="bodyDiv">
	
		<div class="colorControlDiv">
			<div class="layui-form-item">
					<label class="layui-form-label">请移动滑块</label>
					<div id="colorControlSlide" class="colorControlSlide"></div>
			</div>
		</div>
		
		<div class="nodeDiv">
		<table class="layui-table">
			<colgroup>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>&nbsp;&nbsp;<input type="checkbox" id="allCheckbox" lay-filter="allChoose" lay-skin="primary" title="led驱动器"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${nodes.led}" var="led">
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="ledChoose" lay-skin="primary" value="${led.id}" title="${led.nodeName }"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" onclick="submitToning('${pageContext.request.contextPath }/colorControlServlet')">提交</button>
			</div>
		</div>
		</div>

	</div>
	</from>
	<script type="text/javascript" 
		src="${pageContext.request.contextPath }/admin/js/colorControl.js"></script>
</body>
</html>