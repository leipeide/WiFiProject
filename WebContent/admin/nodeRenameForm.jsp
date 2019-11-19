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
		<input type="hidden" id="hiddenLan" value="${i18nLanguage}">
		<div class="layui-form-item">
			<label class="layui-form-label" name="NewName"></label>
			<div class="layui-input-block" style="width: 130px;">
				<input type="text" id="nodeNameInput" required lay-verify="required" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn layui-btn-sm" lay-submit lay-filter="*" 
					onclick="submitBtn('${pageContext.request.contextPath }/nodeRenameServlet',${nodeid })">
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
	//1. 全局变量
	var i18nLanguage = jQuery('#hiddenLan').val(); // 当前系统语言类型
	
	//2. 监听form表单
	layui.use('form', function(){
		var form = layui.form;
	});
	
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
		     	}
		  });
	
	//4.提交函数
	function submitBtn(url,nodeid){
		var newNodeName = jQuery('#nodeNameInput').val();
		if(newNodeName != null &&  newNodeName != ""){
			jQuery.ajax({
				  type:"post",
				  url:url,
				  data:{
					  nodeid:nodeid,
					  nodeName:newNodeName,
					  i18nLanguage:i18nLanguage
				  },
				  async : true,
				  datatype: "String",
				  success:function(datasource, textStatus, jqXHR) {
					  //返回提示
					  layer.msg(datasource,function(){
							location.reload();
						 });
				  },
				  error: function() {  
					  //提交失败
					  layer.msg(jQuery.i18n.prop('submitFailed'));	
		        	}
				});
		}else{
			//未填写节点地址
			layer.msg(jQuery.i18n.prop('InputIsNull'));	
		}
	}
 	</script> 
</body>
</html>