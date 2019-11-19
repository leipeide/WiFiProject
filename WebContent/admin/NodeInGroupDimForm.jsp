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
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
		<div class="layui-form-item" style="margin-top:10px;">
			<label class="i18n" style="width:130px;margin-left:25px;" name="DimPara"></label>
			<div class="layui-input-block" style="width:130px;margin-left:60px;margin-top:10px;">
				<input id="text1" type="text" placeholder="0-100" autocomplete="off" 
					required lay-verify="required" class="layui-input" onchange="percentCheck(this)">
			</div>
		</div>
			<!-- 注意：此处不能使用button,因为form表单button提交后，会主动刷新页面，此时i18nLanguage无法获取 -->
			<div class="layui-form-item" style="margin-left:60px;">
				<a class="layui-btn layui-btn-sm" 
					onclick="submitFunction('${pageContext.request.contextPath}/nodeInGroupPwmDimServlet',${nodeid })">
					<font class="i18n" name="Lsubmit"></font>
				</a>					
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1.加载layui模块
		layui.use('form', function() {
			var form = layui.form;
			
		});
	
		//2.获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var i18nLanguage = jQuery("#hiddenLan").val();	
		
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		jQuery.i18n.properties({
		  	 name : 'common', //资源文件名称,本页面只用到common.properties
		  	 path : 'admin/i18n/', //资源文件路径
		  	 mode : 'both', //用Map的方式使用资源文件中的值
		     language : i18nLanguage,
		     callback : function() {//加载成功后设置显示内容
		             // 第一类：layui的i18n
		             var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
		             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		               });
		     	}
		  });
		
		//4.核对调光范围
		function percentCheck(obj){
			var val = document.getElementById("text1").value;
			if(val<0){
				obj.value = 0;
			}if(val>100){
				obj.value = 100;
			}
		}
		
		//5.提交函数
		function submitFunction(url,nodeId){
			var text1 = jQuery("#text1").val(); //调光百分比
			if(text1 != ""){
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			            nodeid: nodeId,
			            percentage:text1,
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	 if(datasource == "发送成功"){
			        		  layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
				        		 location.reload();
				        	  });
			        	  }else if(datasource == "发送失败请检查设备是否已离线"){
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
			          		layer.msg(jQuery.i18n.prop('submitFailed'));	
			          	}
			  		});	
			}else{
				layer.msg(jQuery.i18n.prop('DimParaNULL'));
			}
		}
	</script>
</body>
</html>