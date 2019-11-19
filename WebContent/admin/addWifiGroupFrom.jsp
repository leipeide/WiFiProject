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
</head>
<body>
	<form class="layui-form">
<%-- 		action="${pageContext.request.contextPath }/addWifiGroupServlet?userid=${userid}" method="post"> --%>
		<!-- 隐藏标签，在页面中传递系统当前语言环境 -->
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div class="layui-form-item">
			<label class="i18n" name="AGroupName" style="width:100px;margin-left:20px;float:left;margin-top:10px;"></label> 
			<div style="width:120px;float:right;margin-right:60px;margin-top:0px;">
				<input id="text1" type="text" required lay-verify="required" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn layui-btn-sm" style="margin-left: 10px;"  
					onclick="submitFun('${pageContext.request.contextPath }/addWifiGroupServlet',${userid })">
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
		//1.全局变量，当前系统的语言环境
		var i18nLanguage = jQuery("#hiddenLan").val();
	
		//2.加载layui模块
		layui.use('form', function(){
			  var form = layui.form;
			});
		
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
		
		//4.提交函数
		function submitFun(url,userid){
			var newGroupName = jQuery("#text1").val(); //新名称输入框
			if(newGroupName != "" && newGroupName != null){
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			            userid:userid,
			            newName: newGroupName,
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	  if(datasource == "新建分组成功"){
				        		 layer.msg(jQuery.i18n.prop('NewGroupSuccess'),function(){
				        			 location.reload();
				        		 }); 
				        	 }else if(datasource == "新建分组失败"){
				        		 layer.msg(jQuery.i18n.prop('NewGroupFailed'),function(){
				        			 location.reload();
				        		 }); 
				        	 }else if(datasource == "该分组已存在"){
				        		 layer.msg(jQuery.i18n.prop('GroupExists'),function(){
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
				 layer.msg(jQuery.i18n.prop('InputIsNull'));	
			}
		}	
	</script>
</body>
</html>