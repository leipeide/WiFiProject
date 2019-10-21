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
		action="${pageContext.request.contextPath }/addLedToGroupServlet?groupid=${groupid}" method="post">
		<div class="layui-form-item">
			<label class="layui-form-label">请选择</label>
			<div class="layui-input-block">
				<input type="checkbox" id="checkAll" lay-filter="allChoose" lay-skin="primary">
				<span id="chooseOrCancel">全选</span></br>
				<c:forEach items="${leds}" var="led">
					<input type="checkbox" name="checkOne" value="${led.mac}" class="check" lay-skin="primary" title="${led.nodeName}"></br>
				</c:forEach>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn">提交</button>
			</div>
		</div>
	</form>
	<script type="text/javascript">
	layui.use('form', function(){
		  var form = layui.form;
		  //1.监听全选操作
		  form.on('checkbox(allChoose)', function(data){
			  //2.是否被选中，true或者false
			  var array = document.getElementsByName("checkOne");
			  var span = document.getElementById("chooseOrCancel");
			  if(data.elem.checked){
				 for(var index=0; index < array.length; index++){
					 array[index].checked=true;
				 }
				 span.innerHTML="取消全选";
			  }else{
				  for(var index=0; index < array.length; index++){
						 array[index].checked=false;
					 }
				  span.innerHTML="全选";
			  }
			  //3.更新渲染
			  form.render();
			});  
		  
		});
	</script>
</body>
</html>