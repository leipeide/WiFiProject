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
<title></title>
</head>
<body>
	<form class="layui-form">
		<!-- 作为隐藏标签,用于储存语言类型,在项目中传递 -->
		<input type="hidden" id="hiddenLan" name="i18nLanguage" value="${i18nLanguage}">
		<div class="layui-form-item">
			<label class="layui-form-label" name="LmacAddr"></label>
			<div class="layui-input-block" style="width: 160px;">
				<input type="text" id="nodeMacInput" required lay-verify="required"
					autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn" name="Lsubmit" lay-submit lay-filter="*"
					onclick="submitBtn('${pageContext.request.contextPath }/addNodeServlet',${userid })"></a>
			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1. Layui JavaScript代码区域
		layui.use('form', function() {
			var form = layui.form;

		});

		//2. 获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var i18nLanguage = jQuery("#hiddenLan").val();

		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		jQuery.i18n.properties({
			name : 'common', //资源文件名称,本页面只用到common.properties
			path : 'admin/i18n/', //资源文件路径
			mode : 'both', //用Map的方式使用资源文件中的值
			language : i18nLanguage,
			callback : function() {//加载成功后设置显示内容
				// 第一类：layui的label
				var insertLabelEle = jQuery(".layui-form-label"); // 获得所有id为i18n的元素
				insertLabelEle.each(function() { // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
					jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
				});
				// 第二类：layui的button
				var insertBtnEle = jQuery(".layui-btn"); // 获得所有id为i18n的元素
				insertBtnEle.each(function() { // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
					jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
				});

			}

		});
		//4.提交函数
		function submitBtn(url,userid){
			var nodeMac = jQuery('#nodeMacInput').val();
			if(nodeMac != null &&  nodeMac != ""){
				jQuery.ajax({
					  type:"post",
					  url:url,
					  data:{
						  userid:userid,
						  nodeMac:nodeMac,
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