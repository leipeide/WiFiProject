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
	.selectFunction{
		margin-left:20px;
		margin-top:30px;
		float:left;
	/*  	border:3px solid #C01C1C;     */
	}
	.paramDiv{
		margin-left:20px;
		margin-top:30px;
		float:right;
		margin-right:80px;
	/*   	border:3px solid #C01C1C;     */
	}
	.selectFunctionDiv{
	    width:100px;
		margin-top:10px;
		margin-left:30px;
	}
	
	}
	.label{
		float:left;
	}
	.submit{
		position:fixed;
 		margin-top: 130px; 
 		margin-left: 160px; 
	/*    	border:3px solid #C01C1C;     */
	}
</style>
</head>
<body>
	<form class="layui-form" action="" method="">
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
			<div class="switchValue" id="switchDiv" style="display: block">
				<label>请选择开关状态</label>
				<div style="margin-top: 10px; margin-left: 40px;">
					<input type="checkbox" id="checkInput" lay-skin="switch"
						lay-text="ON|OFF" checked>
				</div>
			</div>
			<div class="dimValue" id="dimDiv" style="display: none;">
				<label>请输入调光值</label>
				<div style="margin-top: 10px; margin-left: 40px; width: 80px;">
					<input type="text" id="dimInput" placeholder="0-100"
						autocomplete="off" class="layui-input" onchange="checkDim(this)">
				</div>
			</div>
			<div class="dimValue" id="toningDiv" style="display: none;">
				<label>请移动滑块</label>
				<div id="colorControlSlide"
					style="margin-top: 30px; margin-left: 40px; width: 80px;"></div>
			</div>
		</div>
	</form>
	<!-- 重要：按钮放在form标签外面，点击提交按钮后可阻止页面刷新 -->
	<div class="submit">
		<button class="layui-btn"
			onclick="submitBtn('${pageContext.request.contextPath }/ledBroadcastControlServlet',${userid})">提交</button>
	</div>

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
			    	return "红色"+value+"%";
			    //	if(value >=0 && value <=50){
			    //		return value+"(红色)";
			    //	}else if(value > 50 && value <= 100){
			    //		return value+"(蓝色)";
			    //	}	
			     }
			    ,change: function(value){
			    	//监听滑块改变的数值，并存入全局变量toningValue中，为调色函数提供调色参数
		  	    	toningValue = value;
			     }
			  });  
			
		}); 
	
		//3.控制调光范围
		function checkDim(obj){
			var val = document.getElementById("dimInput").value;
			//0-100的正则表达式
			var reg = new RegExp("^(\\d|[1-9]\\d|100)$");
			if(!reg.test(val)){
				layui.use(['layer'], function(){
					  var layer = layui.layer;
					//  layer.msg("请输入0-100以内的整数");
				});
			}
			if(val<0){
				obj.value = 0;
			}else if(val>100){
				obj.value = 100;
			}
		}
		
		//4.提交按钮
	    function submitBtn(url,userid){
			//alert("进入提交函数")
	    	var myselect = document.getElementById("selected"); //获取select DOM对象
	 	    var index = myselect.selectedIndex; //获取被选中的索引
	 	    var selected = myselect.options[index].value; //获取被选中的值
	 	    var functionStr = ""; //初始化功能种类字符串：switch 、 dim、 toning;
	 	    var value = ""; // 功能对应的参数值
 		    //根据switch赋予功能参数和功能字符串
 		    switch(selected){
 		         case "switch":
 		           //切换至开关灯功能
 		           	functionStr = "switch";
 		         	//若开关选中了，dom.checked为true;反之为false；checkValue值为两种状态：true,false;
 		         	var checkValue = document.getElementById("checkInput").checked;
 		         	if(checkValue){
 		         		value = 1;
 		         	}else{
 		         		value = 0;
 		         		//alert(value);
 		         	}
 			        break;
 			     case "dim":
 		            //切换至调光功能
 		            functionStr = "dim";
 		            //value为0-100的整数
 		         	value = document.getElementById("dimInput").value;
 		         	if(value==""){
 		         		layer.msg("未输入调光值!");
 		         		return;
 		         	}else{
 			            break;
 		         	}
 			     case "toning":
 		        	//切换至调色功能
 		        	functionStr = "toning";
 		        	//value为0-100的整数
 		        	if(toningValue != "0"){
 		        		value = toningValue.substring(0,(toningValue.length)-4);
 		        	}else{
 		        		value = toningValue;
 		        	}
 		        	break;      
 		        }
	 	    	
 			  if(value != "" || value == 0){
 				  //ajax传参
 	 			 layui.use(['layer'], function(){
 	 				  var $ = layui.$;
 	 				  var layer = layui.layer;
 		 			  $.ajax({
 		 				  type:"post",
 		 		          url:url,
 		 		          data:{
 		 		        	//参数
 		 		        	userid:userid,
 		 		            functionStr:functionStr,
 		 		            paramValue:value,
 		 		          },
 		 		          async : true,
 		 		          datatype: "String",
 		 		          success:function(datasource, textStatus, jqXHR) {
 		 		        	  //返回提示
 		 		        	  layer.msg(datasource,function(){
 		 		        		  location.reload();
 		 		        	  });	
 		 		          },
 		 		          error: function() {  
 		 		          	  layer.msg("指令发送失败!");	
 		 		          	}
 		 		  		});		  
 	 			 });
 			  }else{
 				 layer.msg("参数为空！") 
 			  }		   
			
		  }  
	</script>
</body>
</html>