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
<body>
	<form class="layui-form">
		<input type="hidden" id="hiddenLan" value="${i18nLanguage }">
		<div class="layui-form-item" style="margin-top:10px;">
			<label class="i18n" style="width:140px;margin-left:25px;" name="OpenAutoLuxDim"></label>
			<div class="layui-input-block">
				<input type="checkbox" id="checkBox" name="switchState" lay-skin="switch">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="i18n" style="width:180px;margin-left:25px;" name="EnterDimPara"></label>
			<div class="layui-input-block">
				<input id="text1" type="text" name="lux" required lay-verify="required" placeholder="1-60000"
					autocomplete="off" class="layui-input" onchange="percentCheck(this)" style="width:150px;margin-top:10px">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
					<a class="layui-btn layui-btn-sm"
						onclick="submitBtn('${pageContext.request.contextPath }/nodeLuxDimServlet',${nodeid })">
						<font class="i18n" name="Lsubmit"></font>
					</a>
			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1.加载layui表单
		layui.use('form', function() {
			var form = layui.form;
		});
		
		//2.获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var i18nLanguage = $("#hiddenLan").val(); 
		
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
		
		//4.控制调光范围在1-60000
		function percentCheck(obj){
			var val = document.getElementById("text1").value;
			if(val<0){
				obj.value = 1;
			}if(val>60000){
				obj.value = 60000;
			}
		}
		
		//5.提交函数
		function submitBtn(url,nodeid){
		 	// checkBox选择调光类型；luxParam为false,则为调光功能；为true,则为自动调光
			var switchState = document.getElementById("checkBox").checked;
			var luxParam = jQuery("#text1").val();
			if(luxParam != ""){
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	//参数
			        	nodeid:nodeid,
			        	lux:luxParam,
			        	switchState:switchState
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
				layer.msg(jQuery.i18n.prop('DimParaNULL'));	
			}
					
		}
	</script>
</body>
</html>