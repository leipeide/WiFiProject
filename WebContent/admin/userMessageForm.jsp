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
<title class="i18n" name="UserInformation"></title>
</head>
<body><form  class="layui-form" action="" method="post">
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div><div class="layui-nav layui-nav-tree layui-nav-side">
				<div class="layui-nav-item">
					<a href="${pageContext.request.contextPath }/showUserMessageServlet?userid=${userid}&i18nLanguage=${i18nLanguage}" target="userM">
						<i class="layui-icon layui-icon-user" style="font-size: 35px;"></i>
						&nbsp;&nbsp;
						<font class="i18n" name="LUserHomepage"></font>
					</a></div>
				<div class="layui-nav-item">
					<a href="${pageContext.request.contextPath }/repasswordFormServlet?userid=${userid}&i18nLanguage=${i18nLanguage}" target="userM">
					<i class="layui-icon layui-icon-password"></i>
					&nbsp;&nbsp;
					<font class="i18n" name="LChangePassword"></font>
				</a></div>
				<div class="layui-nav-item">
					<a href="javascript:;" onclick="homePage('${pageContext.request.contextPath }/returnHomeServlet',${userid})">
						<i class="layui-icon layui-icon-home"></i>
						&nbsp;&nbsp;
						<span class="i18n" name="LreturnPage"></span>
					</a></div>
			</div>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div style="padding: 15px;" id="body-div">
				<iframe style="min-height: 500px" name="userM" frameborder="0" scrolling="no" width="100%"
					src="${pageContext.request.contextPath }/showUserMessageServlet?userid=${userid}&i18nLanguage=${i18nLanguage }" 
					class="body-frame"></iframe>
		     </div>
	 	</div></div>
	</form>
	<script type="text/javascript" 
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>  
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">
		// 全局变量系统环境语言类型
		var i18nLanguage = jQuery("#hiddenLan").val();
	
		//重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
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
			
		//1.跳转到主页
		function homePage(url,userid){
			location.href = url + "?userid="+userid+"&i18nLanguage="+i18nLanguage;
			}
	</script>
</body>
</html>