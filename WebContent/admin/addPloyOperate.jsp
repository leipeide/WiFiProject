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
	.functionDiv{
		margin-top:20px; 
		margin-left:40px;
		width:350px;
		height:80px;
	/*  	border:3px solid #000;    */
		
	}
	.selectFunction{
		float:left;
	/*  	border:3px solid #C01C1C;     */
	}
	.paramDiv{
		float:right;
		margin-right:60px;
	/*   	border:3px solid #C01C1C;     */
	}
	.selectFunctionDiv{
	    width:100px;
		margin-top:10px;
		margin-left:30px;
	}
	
	
	.timeDiv{
		height:120px;
		margin-left:40px;
/* 	   	border:3px solid #00695F;     */
	}
	.time{
		width:340px;
		height:50px;
		margin-top:15px;
/* 		border:3px solid #C01C1C;  */
	}
	.date{
		width:340px;
		height:50px;
		margin-top:10px;
/* 		border:3px solid #C01C1C;  */
	}
	.label{
		float:left;
	}
	.dateInput{
	 	margin-right:48px;
	 	float:right;
	}
	.timeInput{
	 	margin-right:125px; 
	 	float:right;
	}
	
	.submit{
		margin-top:10px;
		margin-left:160px;
	/*    	border:3px solid #C01C1C;     */
	}
</style>
</head>
<body>
	<form class="layui-form" action="" method="">
		<input type="hidden" name="userid" value="${userid }">
		<input type="hidden" name="ployid" value="${ployid }">
		<div class="content">
			<div class="functionDiv">
				<div class="selectFunction">
					<label>请选择功能</label>
					<div class="selectFunctionDiv">
						<select id="selected" lay-verify="" lay-filter="selected">
						  <option value="switch">开关</option>
						  <option value="dim">调光</option>
						  <option value="toning">调色</option>
						</select> 
					</div>
				</div>
				<div class="paramDiv">
					<div class="switchValue" id="switchDiv" style="display:block">
						<label>请选择开关状态</label>
						<div style="margin-top:10px;margin-left:40px;">
							<input type="checkbox" id="checkInput" lay-skin="switch" lay-text="ON|OFF" checked>
						</div>
					</div>
					<div class="dimValue" id="dimDiv" style="display:none;">
						<label>请输入调光值</label>
						<div style="margin-top:10px;margin-left:40px;width:80px;">
							<input type="text" id="dimInput" placeholder="0-100" 
								autocomplete="off" class="layui-input" onchange="checkDim(this)">  
						</div>
					</div>
					<div class="dimValue" id="toningDiv" style="display:none;">
						<label>请移动滑块</label>
						<div id="colorControlSlide" style="margin-top:30px;margin-left:40px;width:80px;"></div>
					</div>
				</div>
			</div>
			
			<div class="timeDiv">
				<div class="time">
					<label class="label">执行时间点</label>
					<div class="timeInput">
						<input type="text" id="minutes" required lay-verify="number" placeholder="MM"
							autocomplete="off" style="width: 50px;height:30px;float:right;margin-top:0px;" class="layui-input">
							<div style="float:right; margin-left:5px;"> ：</div>
						<input type="text" id="hours" required lay-verify="number" placeholder="HH"
							value="" autocomplete="off" style="width: 50px;height:30px;float:right;margin-top:0px;" class="layui-input">
					</div>
				</div>
				<div class="date">
					<label class="label">执行时间范围</label>
					<div class="dateInput">
						<input type="text" id="endDate" required lay-verify="date" placeholder="xxxx/xx/xx"
							value="" autocomplete="off" style="width: 90px;height:30px;float:right;margin-top:0px;" class="layui-input"> 
						<div style="float:right;margin-left:5px;margin-right:5px;"> - </div>
						<input type="text" id="startDate" required lay-verify="date" placeholder="xxxx/xx/xx"
							value="" autocomplete="off" style="width: 90px;height:30px;float:right;margin-top:0px;"  class="layui-input">
					</div>
				</div>
				
			</div>
			
			
		</div>
	</form>
<!-- 重要：按钮放在form标签外面，点击提交按钮后可阻止页面刷新 -->
	<div class="submit">
		 <button class="layui-btn" onclick="submitBtn('${pageContext.request.contextPath }/addPloyOperateServlet',${userid},${ployid})">提交</button>
	</div>
	
	<script type="text/javascript"
	src="${pageContext.request.contextPath }/admin/js/addPloyOperate.js"></script>
	
	<script type="text/javascript">
	//初始化调色参数
	var toningValue = 0;
	layui.use(['element','slider','form','layer'], function(){
		  var element = layui.element;
		  var slider = layui.slider;
		  var form = layui.form;
		  var layer = layui.layer;
		  //1.监听select，根据select选择值切换功能参数区域
		  form.on('select(selected)', function(data){
			  var switcher = document.getElementById("switchDiv");
		   	  var dim = document.getElementById("dimDiv");
			  var toning = document.getElementById("toningDiv");
			  switch(data.value){
		         case "switch":
		           //切换至开关灯功能
    	            switcher.style.display = "block";
		            dim.style.display = "none";
		            toning.style.display = "none";
			        break;
			     case "dim":
		            //切换至调光功能
			       	switcher.style.display = "none";
		            dim.style.display = "block";
		            toning.style.display = "none";
		            break;
			     case "toning":
		        	//切换至调色功能
			       	switcher.style.display = "none";
			        dim.style.display = "none";
		            toning.style.display = "block";
		        	break;      
		        }
			});    
		  
		  //2.调色滑块的使用
		  slider.render({
		    elem: '#colorControlSlide'
		    ,setTips: function(value){ //自定义提示文本
		    	if(value >=0 && value <=50){
		    		return value+"(红色)";
		    	}else if(value > 50 && value <= 100){
		    		return value+"(蓝色)";
		    	}	
		     }
		    ,change: function(value){
		    	//监听滑块改变的数值，并存入全局变量toningValue中，为调色函数提供调色参数
	  	    	toningValue = value;
		     }
		  });  
		
	});    
	</script>
</body>
</html>