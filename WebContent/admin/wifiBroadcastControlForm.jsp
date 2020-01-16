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
</head>
<body class="layui-layout-body">
	<form class="layui-form">
		<input type="hidden" id="nodeid" name="nodeid" value="${nodeid }">
		<!-- 用于储存语言类型,在正在项目中传递 -->
		<input type="hidden" id="hiddenLan" value="${i18nLanguage}">
		<div class="layui-form-item" style="margin-top:10px;"> 
			<label class="i18n" style="width:140px;margin-left:25px;" name="ChooseDimType"></label>
			<div class="layui-input-block" style="width:150px;margin-top:10px;">
				<select id="selected" lay-verify="" lay-filter="selected">
					<option class="i18n"  value="pwmDim" name="PwmDim"></option>
					<option class="i18n"  value="autoDim" name="AutoDim"></option>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="i18n" style="width:180px;margin-left:25px;" name="EnterDimPara"></label>
			<div id="pwmDiv" class="layui-input-inline" style="display:block;">
				<input id="text1" type="text" name="pwmParam"  style="width:150px;margin-top:10px"
					placeholder="0-100" autocomplete="off" class="layui-input" onchange="percentCheck(this)">
			</div>
			<div id="autoDiv" class="layui-input-inline" style="display:none;">
				<input id="text2" type="text" name="luxParam"  style="width:150px;margin-top:10px"
					placeholder="1-60000" autocomplete="off" class="layui-input" onchange="luxCheck(this)">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn layui-btn-sm" 
					onclick="submitBtn('${pageContext.request.contextPath }/wifiBroadcastControlServlet',${userid})">
					<font class="i18n" name="Lsubmit"></font>
				</a>
			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">
	//2.获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
	var i18nLanguage = jQuery("#hiddenLan").val(); 
	//1.加载form模块
	layui.use('form', function() {
		var form = layui.form;
		form.on('select(selected)', function(data){
			  var pwmDiv = document.getElementById("pwmDiv");
		   	  var autoDiv = document.getElementById("autoDiv");
			  switch(data.value){
		         case "pwmDim":
		           //切换至pwm调光
   	            	pwmDiv.style.display = "block";
   	            	autoDiv.style.display = "none";		
			        break;
			     case "autoDim":
		            //切换至调光功能
			       	pwmDiv.style.display = "none";
			       	autoDiv.style.display = "block";
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
		    	 // 第一类：layui的layui-form-label
	             var insertEle = jQuery(".i18n"); // 获得所有class为layui-form-label的元素
	             insertEle.each(function() {  // 遍历，根据layui-form-label元素的 name 获取语言库对应的内容写入
	            	jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	             });
	     	}
	  });
	
	//4.检查调光范围
	function percentCheck(obj){
		var val = document.getElementById("text1").value;
		if(val<0){
			obj.value = 0;
		}if(val>100){
			obj.value = 100;
		}
	}
	function luxCheck(obj){
		var val = document.getElementById("text2").value;
		if(val<1){
			obj.value = 1;
		}if(val>60000){
			obj.value = 60000;
		}
	}
	
	//提交函数
	function submitBtn(url,userid){
	 	var myselect = document.getElementById("selected"); //获取select DOM对象
	 	var index = myselect.selectedIndex; //获取被选中的索引
	    var selectedVal = myselect.options[index].value; //获取被选中的值
	 	var functionStr = ""; //初始化功能种类字符串：pwmdim 、 autoluxdim;
	 	var dimParam = ""; // 功能对应的参数值,默认为pwm调光参数100
		var allNumber = true; // 判断调光参数内是否都是数字
	 	if(selectedVal == "autoDim"){
	 		dimParam = jQuery("#text2").val();
	 		functionStr = "autoluxdim";
	 	}else{
	 		dimParam = jQuery("#text1").val();
	 		functionStr = "pwmdim";
	 	}
	 	//判断参数内含有字符，非数字
	 	for(var i=dimParam.length;--i>=0;){
	        var chr = dimParam.charAt(i);//方法用于返回指定索引处的字符
	        var unicode = chr.charCodeAt(0).toString(10);//获取字符的unicode码
	        if( unicode<48 || unicode>57) {
	        	allNumber = false;
	        	break;
	        }
		}
		if(allNumber && dimParam!= ""){
			jQuery.ajax({
				  type:"post",
		          url:url,
		          data:{
		        	//参数
		        	userid:userid,
		        	dimParam:dimParam,
		        	functionStr:functionStr
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
		        	  }else if(datasource == "提交失败"){
		        		  layer.msg(jQuery.i18n.prop('submitFailed'),function(){
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
			layer.msg(jQuery.i18n.prop('DimParaNullOrNotNumber'));
		}
				
	}
	</script>
</body>
</html>