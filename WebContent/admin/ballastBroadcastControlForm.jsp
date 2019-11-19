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
<style type="text/css">
.selectFunction {
	margin-top: 30px;
	margin-left: 20px;
	float: left;
/* 	border: 3px solid #C01C1C; */
}

.paramDiv {
	float: right;
	margin-right: 50px;
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
 	margin-top: 160px; 
 	margin-left: 170px; 
/* 	border: 3px solid #C01C1C; */
}
</style>
</head>
<body>
	<form class="layui-form" action="" method="post">
		<!--  作为隐藏标签,用于储存语言类型,在项目中传递  -->
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div>
			<div class="selectFunction">
				<label class="i18n" name="SelectFunction"></label>
				<div class="selectFunctionDiv">
					<select id="selected" lay-verify="" lay-filter="selected">
						<option class="i18n" name="LSwitch" value="switch"></option>
						<option class="i18n" name="LDim" value="dim"></option>
					</select>
				</div>
			</div>
			<div class="paramDiv">
				<div class="switchValue" id="switchDiv" style="display: block">
					<label class="i18n" name="SelectSwitchStatus"></label>
					<div style="margin-top: 10px; margin-left: 40px;">
						<input type="checkbox" id="checkInput" lay-skin="switch" lay-text="ON|OFF" checked>
					</div>
				</div>
				<div class="dimValue" id="dimDiv" style="display: none;">
					<label class="i18n" name="EnterDimPara" style="width:200px;"></label>
					<div style="margin-top: 10px; margin-left: 40px; width: 100px;">
						<input type="text" id="dimInput" placeholder="0-100" required lay-verify="required"
							autocomplete="off" class="layui-input" onchange="checkDim(this)">
					</div>
				</div>
			</div>
		</div>
		<div class="submit">
			<a class="layui-btn" name="Lsubmit"
				onclick="submitBtn('${pageContext.request.contextPath }/ballastBroadcastControlServlet',${userid})">
			</a>
	</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">
		//1.获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var i18nLanguage = jQuery("#hiddenLan").val(); 
		
		//2.监听select；根据select选择值切换功能参数区域
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
		
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		jQuery.i18n.properties({
		  	 name : 'common', //资源文件名称,本页面只用到common.properties
		  	 path : 'admin/i18n/', //资源文件路径
		  	 mode : 'both', //用Map的方式使用资源文件中的值
		     language : i18nLanguage,
		     callback : function() {//加载成功后设置显示内容
			    	 // 第一类：layui的i18n
		             var insertEle = jQuery(".i18n"); // 获得所有class为i18n的元素
		             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		             // 第二类：layui的button
		             var insertBtnEle = jQuery(".layui-btn"); // 获得所有class为layui-btn的元素
		             insertBtnEle.each(function() {  // 遍历，根据layui-btn元素的 name 获取语言库对应的内容写入
		           	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });     
		     	}
		  });
		
		//4.控制调光范围
		function checkDim(obj){
			var val = document.getElementById("dimInput").value;
			if(val<0){
				obj.value = 0;
			}else if(val>100){
				obj.value = 100;
			}
		}
		
		//5.提交按钮
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
 		         		//未输入调光值
 		         		layer.msg(jQuery.i18n.prop('DimParaNULL'));
 		         		return;
 		         	}else{
 			            break;
 		         	}
 		        }
 			  if(value != "" || value == 0){
 				  //ajax传参
 		 		  jQuery.ajax({
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
 		 		        	  if(datasource == "指令发送成功"){
 		 		        		 layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
 	 		 		        		  location.reload();
 	 		 		        	  });	
 		 		        	  }else if(datasource == "节点离线或节点不存在"){
 		 		        		 layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){
	 		 		        		  location.reload();
	 		 		        	  });	
 		 		        	  }else{
 		 		        		  
 		 		        	  }
 		 		        	  
 		 		          },
 		 		          error: function() {  
 		 		          	  layer.msg(jQuery.i18n.prop('cmdSendFail'));	
 		 		          	}
 		 		  		});		  
 			  }else{
 				// 参数为空
 				layer.msg(jQuery.i18n.prop('ParaNULL'));
 			  }		   
			
		  }  
	</script>
</body>
</html>