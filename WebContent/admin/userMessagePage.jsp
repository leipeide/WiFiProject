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
.userMessage{
	position: absolute;
	margin-right:200px;
	padding:50px;
	padding-left:150px;
	height:60%;
	width:50%; 
	border:1px } 
</style> 
</head>
<body><form class="layui-form" action="" method="post">
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div>
			<div><blockquote class="layui-elem-quote layui-quote-nm" >
					<font size='5' class="i18n" name="UserInformation"></font></blockquote>
				 <hr class="layui-bg-cyan" > 
			</div>
			<div class="userMessage" >
				<div class="layui-form-item">
					<label class="i18n" name="UserIdM"></label>
					<span>${user.id }</span>
				</div>
				<div class="layui-form-item">
					<label class="i18n" name="UserNameM"></label>
					<span>${user.username }</span>
				</div>
				<div class="layui-form-item">
					<label class="i18n" name="EmailAddrM"></label>
					<span>${user.email }</span>
				</div>
<!-- 				<div class="layui-form-item"> -->
<%-- 					<label>电话号码：<span>${user.phone}</span></label> --%>
<!-- 				</div> -->
			</div>	
		</div>
	  </form>
	  <script type="text/javascript" 
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>  
 	  <script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
 	  <script type="text/javascript">
 	  		// 1. 获取当前语言环境
 	  		var i18nLanguage = jQuery("#hiddenLan").val();
 	  		
 	  		// 2.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
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
 	  </script>
</body>
</html>