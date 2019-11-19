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
		<input type="hidden" id="userid" value="${userid}">
		<input type="hidden" id="ployid" value="${ployid}">
		<input type="hidden" id="hiddenLan" value="${i18nLanguage}">
		<div class="layui-form-item">
			<label class="layui-form-label" name="NewName"></label>
			<div class="layui-input-block" style="width: 160px;">
				<input type="text" id="newNameInput" required lay-verify="required"
					 autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn layui-btn-sm" lay-submit lay-filter="*" 
					onclick="submitBtn('${pageContext.request.contextPath }/ployRenameServlet')">
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
		//1.全局变量，获取id为hiddenLan的value值，是当前系统的语言环境
	    var i18nLanguage = jQuery("#hiddenLan").val();
		
		//2.加载layui模块
		layui.use('form', function() {
			var form = layui.form;

		});
		
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
	    jQuery.i18n.properties({
	      	 name : 'common', //资源文件名称,本页面只用到common.properties
	      	 path : 'admin/i18n/', //资源文件路径
	      	 mode : 'both', //用Map的方式使用资源文件中的值
	           language : i18nLanguage,
	           callback : function() {//加载成功后设置显示内容
	        	     // 第一类：layui的label
		             var insertLabelEle = jQuery(".layui-form-label"); // 获得所有class为layui-form-label的元素
		             insertLabelEle.each(function() {  // 遍历，根据layui-form-label元素的 name 获取语言库对应的内容写入
		            	  jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		                });
	                 //第二类：layui的i18n
		             var insertEle = jQuery(".i18n"); // 获得所有class为i18n的元素
		             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
	       	  }
	      }); 
		
		//4.提交函数
		function submitBtn(url){
			var userId = jQuery("#userid").val();
			var ployId = jQuery("#ployid").val();
			var newName = jQuery("#newNameInput").val();
			if(newName != ""){
				jQuery.ajax({
	      			  type:"post",
	      			  url:url,
	      			  data:{
	      				userid: userId,
	      				ployid: ployId,
	      				newName: newName,
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回删除提示
	      				  if(datasource == "修改成功"){
		      					layer.msg(jQuery.i18n.prop('ModifiedSuccess'),function(){
			      					location.reload();
			      				  });
	      				  }else if(datasource == "修改失败"){
		      					layer.msg(jQuery.i18n.prop('ModificationFailed'),function(){
		      						location.reload();
			      				  });
	      				  }else if(datasource == "该名称已存在"){
		      					layer.msg(jQuery.i18n.prop('NameExist'),function(){
		      						location.reload();
			      				  });
	      				  }else if(datasource == "参数不完整"){
		      					layer.msg(jQuery.i18n.prop('IncompletePara'),function(){
		      						location.reload();
			      				  });
	      				  }else{
	      					  
	      				  }
	      			  },
	      			  error: function() {  //提交失败
	      				  layer.msg(jQuery.i18n.prop('submitFailed'));
	      			
	      	      		}
	        		});	
			}else{
				
			}
		}
	</script>
</body>
</html>