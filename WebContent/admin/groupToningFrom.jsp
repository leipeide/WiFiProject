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
.submitDiv{
	padding-top:30px;
	margin-left:30px;
/*  border:1px solid #C01C1C;   */
}
</style>
</head>
<body>
	<from class="layui-form" >
	<div class="bodyDiv">
		<div class="colorControlDiv">
			<div class="layui-form-item">
					<label class="layui-form-label">请移动滑块</label>
					<div id="colorControlSlide" class="colorControlSlide"></div>
			</div>
		</div>
		<div class="submitDiv">
			<button class="layui-btn"  onclick="submitToning('${pageContext.request.contextPath }/groupToningServlet',${groupid },${userid})">提交</button>
		</div>
	</div>
	</from>
	<script type="text/javascript" >
	var toningValue = 0;
	layui.use(['element','slider','form','layer'], function(){
		  var element = layui.element;
		  var slider = layui.slider;
		  var form = layui.form;
		  var layer = layui.layer;
		  //1.调色滑块的使用
		  slider.render({
		    elem: '#colorControlSlide'
		    ,setTips: function(value){ //自定义提示文本
		    	//if(value >=0 && value <=50){
		    		return "红色"+value+"%";
		    	//}else if(value > 50 && value <= 100){
		    	//	return value+"(蓝色)";
		    	//}
		    		
		     }
		    ,change: function(value){
		    	//监听滑块改变的数值，并存入全局变量toningValue中，为调色函数提供调色参数
	  	    	toningValue = value;
		     }
		  });
		  
	});
	
	//led驱动器调光，提交函数
	function submitToning(url,groupid,userid){
		//1.获取调色的占空比
		if(toningValue != "0"){
			var tonPercentage = toningValue.substring(0,(toningValue.length)-4);
		}else{
			var tonPercentage = toningValue;
		}
		//2.携带参数至servlet
		location.href = url + '?groupid=' + groupid + '&userid=' + userid + '&tonPercentage=' + tonPercentage;
		}
	</script>
</body>
</html>