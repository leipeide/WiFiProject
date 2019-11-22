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
<style>
.inputDiv {
	margin-top: 15px;
	padding-top: 10px;
	height: 50px;
	/*   	border:3px solid #00695F;  */
}

.selectDiv {
	/* 	margin-top:10px;  */
	padding-top: 10px;
	height: 50px;
	/*   	border:3px solid #00695F;  */
}

.label {
	padding-top: 5px;
	float: left;
	margin-left: 20px;
	/* 	border:3px solid #00695F;   */
}

.FunctionDiv {
	float: right;
	margin-right: 120px;
	width: 150px;
}
</style>
</head>
<body class="layui-layout-body">
	<form class="layui-form">
<%-- 		action="${pageContext.request.contextPath }/newPloyServlet?userid=${userid }&groupType=${groupType }&i18nLanguage=${i18nLanguage }" --%>
		<!-- 用于储存语言类型,在正在项目中传递 -->
		<input type="hidden" id="hiddenLan" value="${i18nLanguage}">
		<div class="inputDiv">
			<label class="label" name="APolicyName"></label>
			<div class="FunctionDiv">
				<input type="text" id="newNameInput" required lay-verify="required" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="selectDiv">
			<label class="label" name="SelectGroup"></label>
			<div class="FunctionDiv">
				<select id="groupSelect" name="groupid" lay-filter="selectGroup"
					required lay-verify="required">
					<option class="i18n" name="PleaseSelect" value=""></option>
					<c:forEach items="${groups }" var="group">
						<option value="${group.groupid}">${group.groupName}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<div style="margin-top: 10px; margin-left: 130px;">
				<a class="layui-btn" lay-submit lay-filter="*" name="Lsubmit"
					onclick="submitBtn('${pageContext.request.contextPath }/newPloyServlet', ${userid }, ${groupType })"></a>
			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1.获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var i18nLanguage = jQuery("#hiddenLan").val();

		//2.layui加载模块
		layui.use('form', function() {
			var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
			//.监听select下拉选择框
			form.on('select(selectGroup)', function(data) {
			});
			form.render();
		});
		
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		jQuery.i18n.properties({
			name : 'common', //资源文件名称,本页面只用到common.properties
			path : 'admin/i18n/', //资源文件路径
			mode : 'both', //用Map的方式使用资源文件中的值
			language : i18nLanguage,
			callback : function() {//加载成功后设置显示内容
				// 第一类：layui的label
				var insertLabelEle = jQuery(".label"); // 获得所有id为label的元素
				insertLabelEle.each(function() { // 遍历，根据label元素的 name 获取语言库对应的内容写入
					jQuery(this).html(
							jQuery.i18n.prop(jQuery(this).attr('name')));
				});
				// 第二类：layui的button
				var insertBtnEle = jQuery(".layui-btn"); // 获得所有id为layui-btn的元素
				insertBtnEle.each(function() { // 遍历，根据layui-btn元素的 name 获取语言库对应的内容写入
					jQuery(this).html(
							jQuery.i18n.prop(jQuery(this).attr('name')));
				});
				// 第一类：layui 的i18n
				var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
				insertEle.each(function() { // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
					jQuery(this).html(
							jQuery.i18n.prop(jQuery(this).attr('name')));
				});
			}
		});
		
		//4.提交函数
		function submitBtn(url, userid, groupType){
			var ployNameVal = jQuery('#newNameInput').val();
			var options=jQuery("#groupSelect option:selected"); //获取选中的项
			var selectValue = options.val(); //获取选中的值,groupid
			if(ployNameVal == ""){
				//名称未输入，layui自带提醒
			}else if(selectValue == ""){ //未选择绑定的分组
				layer.msg(jQuery.i18n.prop('NoGroupSelected'));	
			}else{
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	//参数
			        	userid:userid,
			        	groupid:selectValue,
			        	groupType:groupType,
			        	newName:ployNameVal,

			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	  if(datasource == "新建成功"){
			        		 layer.msg(jQuery.i18n.prop('NewPloySuccess'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "新建失败"){
			        		 layer.msg(jQuery.i18n.prop('OperationFailed'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "提交失败"){
			        		  layer.msg(jQuery.i18n.prop('submitFailed'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "该名称已存在"){
			        		  layer.msg(jQuery.i18n.prop('NameExist'),function(){
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