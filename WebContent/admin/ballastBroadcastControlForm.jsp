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
.selectFunction {
	margin-top: 30px;
	margin-left: 20px;
	float: left;
/* 	border: 3px solid #C01C1C; */
}

.paramDiv {
	float: right;
	margin-right: 70px;
	margin-top: 30px;
/* 	border: 3px solid #C01C1C; */
}

.selectFunctionDiv {
	width: 100px;
	margin-top: 10px;
	margin-left: 30px;
/* 	border: 3px solid #C01C1C; */
}

.label {
	float: left;
}

.submit {
	position:fixed;
 	margin-top: 130px; 
 	margin-left: 160px; 
/* 	border: 3px solid #C01C1C; */
}
</style>
</head>
<body>
	<form class="layui-form" action="" method="post">
		<div>
			<div class="selectFunction">
				<label>请选择功能</label>
				<div class="selectFunctionDiv">
					<select id="selected" lay-verify="" lay-filter="selected">
						<option value="switch">开关</option>
						<option value="dim">调光</option>
					</select>
				</div>
			</div>
			<div class="paramDiv">
				<div class="switchValue" id="switchDiv" style="display: block">
					<label>请选择开关状态</label>
					<div style="margin-top: 10px; margin-left: 40px;">
						<input type="checkbox" id="checkInput" lay-skin="switch" lay-text="ON|OFF" checked>
					</div>
				</div>
				<div class="dimValue" id="dimDiv" style="display: none;">
					<label>请输入调光值</label>
					<div style="margin-top: 10px; margin-left: 40px; width: 100px;">
						<input type="text" id="dimInput" placeholder="0-100" required lay-verify="required"
							autocomplete="off" class="layui-input" onchange="checkDim(this)">
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="submit">
		<button class="layui-btn"
			onclick="submitBtn('${pageContext.request.contextPath }/ballastBroadcastControlServlet',${userid})">提交</button>
	</div>
	<script type="text/javascript">
		//1.监听select；根据select选择值切换功能参数区域
		layui.use(['form','layer'], function(){
			  var form = layui.form;
			  var layer = layui.layer;
			  form.on('select(selected)', function(data){
				  var switcher = document.getElementById("switchDiv");
			   	  var dim = document.getElementById("dimDiv");
				  switch(data.value){
			         case "switch":
			           //切换至开关灯功能
	    	            switcher.style.display = "block";
			            dim.style.display = "none";		
				        break;
				     case "dim":
			            //切换至调光功能
				       	switcher.style.display = "none";
			            dim.style.display = "block";
			            break;  
				 	 }
				});    
			});    
			  
		//2.控制调光范围
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
		
		//3.提交按钮
	    function submitBtn(url,userid){
	    	var myselect = document.getElementById("selected"); //获取select DOM对象
	 	    var index = myselect.selectedIndex; //获取被选中的索引
	 	    var selected = myselect.options[index].value; //获取被选中的值
	 	    var functionStr = ""; //初始化功能种类字符串：switch 、 dim;
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
 		 		            paramValue:value
 		 		          },
 		 		          async : true,
 		 		          datatype: "String",
 		 		          success:function(datasource, textStatus, jqXHR) {
 		 		        	  //返回删除提示
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