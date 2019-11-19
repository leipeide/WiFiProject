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
		margin-left:10px;
		margin-top:30px;
		float:right;
		margin-right:40px;
/*   	border:3px solid #C01C1C;      */
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
 		margin-top: 160px; 
 		margin-left: 170px; 
	/*    	border:3px solid #C01C1C;     */
	}
</style>
</head>
<body>
	<form class="layui-form" action="" method="">
		<!--  作为隐藏标签,用于储存语言类型,在项目中传递  -->
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div class="selectFunction">
			<label class="i18n" name="SelectFunction"></label>
			<div class="selectFunctionDiv">
				<select id="selected" lay-verify="" lay-filter="selected">
					<option class="i18n" name="LSwitch" value="switch"></option>
					<option class="i18n" name="LDim" value="dim"></option>
					<option class="i18n" name="LToning" value="toning"></option>
				</select>
			</div>
		</div>
		<div class="paramDiv">
			<div class="switchValue" id="switchDiv" style="display: block">
				<label class="i18n" name="SelectSwitchStatus"></label>
				<div style="margin-top: 10px; margin-left: 50px;">
					<input type="checkbox" id="checkInput" lay-skin="switch"
						lay-text="ON|OFF" checked>
				</div>
			</div>
			<div class="dimValue" id="dimDiv" style="display: none;">
				<label class="i18n" name="EnterDimPara"></label>
				<div style="margin-top: 10px; margin-left: 40px; width: 80px;">
					<input type="text" id="dimInput" placeholder="0-100"
						autocomplete="off" class="layui-input" onchange="checkDim(this)">
				</div>
			</div>
			<div class="dimValue" id="toningDiv" style="display: none;">
				<label class="i18n" name="MoveSlider"></label>
				<div id="colorControlSlide" style="margin-top: 30px; margin-left: 50px; width: 90px;"></div>
				<label class="BlueSpan" name="color-blue" style="float:right;margin-right:8px;margin-top:10px;"></label>
				<label class="RedSpan" name="color-red" style="float:right;margin-right:22px;margin-top:10px;"></label>
			</div>
		</div>
	</form>
	<!-- 重要：按钮放在form标签外面，点击提交按钮后可阻止页面刷新 -->
	<div class="submit">
		<button class="layui-btn" name="Lsubmit"
			onclick="submitBtn('${pageContext.request.contextPath }/ledBroadcastControlServlet',${userid})"></button>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">
		//1.全局变量
		var i18nLanguage = jQuery("#hiddenLan").val();  //获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var toningValue = 0;//初始化调色参数
		
		//2.加载layui模块
		layui.use(['element','slider','form','layer'], function(){
			  var element = layui.element;
			  var slider = layui.slider;
			  var form = layui.form;
			  var layer = layui.layer;
			  //2.1.监听select，根据select选择值切换功能参数区域
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
			  
			  //2.2.调色滑块的使用
			  slider.render({
			    elem: '#colorControlSlide'
			    ,setTips: function(value){ //自定义提示文本
			    	return value+"%";
			     }
			    ,change: function(value){
			    	//监听滑块改变的数值，并存入全局变量toningValue中，为调色函数提供调色参数
		  	    	toningValue = value;
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
		             // 第三类：获取class为RedSpan
		             var insertRedEle = jQuery(".RedSpan"); 
		             insertRedEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		             // 第四类：获取class为BlueSpan
		             var insertBlueEle = jQuery(".BlueSpan"); 
		             insertBlueEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		                });
		     	}
		  });
		
		
		//4.控制调光范围
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
//  		         		layer.msg("未输入调光值!");
 		         		layer.msg(jQuery.i18n.prop('DimParaNULL'));
 		         		return;
 		         	}else{
 			            break;
 		         	}
 			     case "toning":
 		        	//切换至调色功能
 		        	functionStr = "toning";
 		        	//value为0-100的整数
 		        	if(toningValue != "0"){
 		        		//从滑块的文本value%，提取value
 		        		value = toningValue.substring(0,(toningValue.length)-1);
 		        	}else{
 		        		value = toningValue;
 		        	}
 		        	break;      
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
 		 		            paramValue:value,
 		 		          },
 		 		          async : true,
 		 		          datatype: "String",
 		 		          success:function(datasource, textStatus, jqXHR) {
 		 		        	  //返回提示
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
 		 		          	 // layer.msg("指令发送失败!");	
 		 		        	layer.msg(jQuery.i18n.prop('cmdSendFail'));
 		 		          	}
 		 		  		});		  
 			  }else{
 				 //layer.msg("参数为空！") 
 				 layer.msg(jQuery.i18n.prop('ParaNULL'));
 			  }		   
			
		  }  
	</script>
</body>
</html>