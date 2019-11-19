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
<style>
.userMessage {
	position: absolute;
	margin-right: 200px;
	padding: 50px;
	height: 60%;
	width: 50%;
	border: 1px
}
</style>
</head>
<body class="layui-layout-body" method="post">
	<form class="layui-form">
		<input id="hiddenLan" type="hidden" value="${i18nLanguage}">
		<div>
			<blockquote class="layui-elem-quote layui-quote-nm">
				<font size='5' class="i18n" name="LChangePassword"></font>
			</blockquote>
			<hr class="layui-bg-cyan">
		</div>
		<div class="userMessage">
			<div class="layui-form-item">
				<label class="layui-form-label"  style="width:130px;" name="OldPassword"></label>
				<div class="layui-input-inline">
					<input type="password" id="prePasswordInput" required
						lay-verify="required" class="layui-input" style="width:210px;"
						selectname="passwordPlaceholder" selectattr="placeholder"
						autocomplete="off">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label"  style="width:130px;" name="NewPassword"></label>
				<div class="layui-input-inline">
					<input type="password" id="newPasswordInput" required
						lay-verify="required" selectname="NewPasswordPlaceholder"
						selectattr="placeholder" autocomplete="off" class="layui-input" style="width:210px;">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label" style="width:130px;" name="ConfirmPassword"></label>
				<div class="layui-input-inline">
					<input type="password" id="rePasswordInput" required
						lay-verify="required" selectname="ReNewPasswordPlaceholder"
						selectattr="placeholder" autocomplete="off" class="layui-input" style="width:210px;">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block" style="margin-left:160px;">
					<a class="layui-btn" name="Lsubmit" lay-submit
						lay-filter="sub" onclick="submitBtn('${pageContext.request.contextPath }/repasswordServlet',${userid})"></a>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		// 1.加载form表单
		layui.use('form', function() {
			var form = layui.form;
			//监听提交
			form.on('submit(sub)', function(data) {
				
			});
		});
		
		// 2.全局变量，当前系统的语言类型
		var i18nLanguage = jQuery("#hiddenLan").val();
		
		// 3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
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
		          	 // 第二类：layui的label
		             var insertLabelEle = jQuery(".layui-form-label"); // 获得所有id为i18n的元素
		             insertLabelEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		           	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		             });
		             // 第三类：layui的button
		             var insertBtnEle = jQuery(".layui-btn"); // 获得所有id为i18n的元素
		             insertBtnEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		           	   jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	                  });
	                 // 第四类：layui的input
	                 var insertInputEle = jQuery(".layui-input");
	                 insertInputEle.each(function() {
	                	 var selectAttr = jQuery(this).attr('selectattr');
		                 if (!selectAttr) {
		                      selectAttr = "value";
		                   };
		                 jQuery(this).attr(selectAttr, jQuery.i18n.prop(jQuery(this).attr('selectname')));    
		              });
		     	}
		  });
		
		//4.提交函数
		function submitBtn(url,userid){
			var prePasswordVal = jQuery("#prePasswordInput").val(); //旧密码
			var newPasswordVal = jQuery("#newPasswordInput").val(); //新密码
			var rePasswordVal = jQuery("#rePasswordInput").val(); //重复新密码
			if(newPasswordVal != rePasswordVal){ //两遍密码不一致
				layer.msg(jQuery.i18n.prop('TowPasswordNotSame'),function(){
					 location.reload();
				});	
			}else{ //提交
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	//参数
			        	userid: userid,
			        	prePassword: prePasswordVal,
			        	newPassword: newPasswordVal,
			        	rePassword: rePasswordVal,
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	  if(datasource == "原密码错误请重新输入"){
			        		 layer.msg(jQuery.i18n.prop('OldPasswordError'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "密码修改成功"){
			        		 layer.msg(jQuery.i18n.prop('PassworsModifySuccess'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "提交失败"){
			        		  layer.msg(jQuery.i18n.prop('submitFailed'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "密码修改失败"){
			        		  layer.msg(jQuery.i18n.prop('PasswordModifyFailed'),function(){
		 		        		  location.reload();
		 		        	  });
			        	  }else{
			        		  
			        	  }
			        	  
			          },
			          error: function() {  
			          	  layer.msg(jQuery.i18n.prop('cmdSendFail'));	
			          	}
			  		});
			}
			
		}
</script>
</body>
</html>