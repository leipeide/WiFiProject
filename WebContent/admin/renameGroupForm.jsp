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
		<!-- 隐藏标签，传递参数 -->
		<input type="hidden" id="hiddenLan" value="${i18nLanguage }">
		<div class="layui-form-item">
			<label class="layui-form-label" name="NewName"></label>
			<div class="layui-input-block" style="width: 160px;">
				<input type="text" id="newName" name="newName" required lay-verify="required"
					 autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn layui-btn-sm" lay-submit lay-filter="*"
					onclick="submitBtn('${pageContext.request.contextPath }/groupRenameServlet',${userid },${groupid })">
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
		//1.加载layui form表单
		layui.use('form', function() {
			var form = layui.form;

		});
		
		//2. 全局变量，当前系统的语言环境
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
		             // 第二类：layui的label
		             var insertLabelEle = jQuery(".layui-form-label"); // 获得所有class为layui-form-label的元素
		             insertLabelEle.each(function() {  // 遍历，根据layui-form-label元素的 name 获取语言库对应的内容写入
		                 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		     	}
		  });
		
		//4.提交按钮
		function submitBtn(url, userid, groupid){
			var groupName = jQuery("#newName").val();
			if(groupName != "" &&  groupName != null){
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	userid: userid,
			        	groupid:groupid,
			        	newName:groupName
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	 if(datasource == '修改成功'){
			        		  layer.msg(jQuery.i18n.prop('ModifiedSuccess'),function(){
				        		 location.reload();
				        	  });
			        	  }else if(datasource == '修改失败'){
			        		  layer.msg(jQuery.i18n.prop('ModificationFailed'),function(){
				        		  location.reload();
				        	  });
			        	  }else if(datasource == '该名称已存在'){
			        		  layer.msg(jQuery.i18n.prop('NameExist'),function(){
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
				//input未输入
				layer.msg(jQuery.i18n.prop('InputIsNull'));	
			}
		}
	</script>
</body>
</html>