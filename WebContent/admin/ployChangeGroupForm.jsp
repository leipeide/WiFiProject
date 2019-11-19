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
<style type="text/css">
.label{
	margin-left : 25px;
	width : 160px;
}
.layui-form-item{
	padding-top:20px;
}
</style>
</head>
<body>
	<form class="layui-form">
		<!-- 隐藏标签，在页面中传递系统语言环境 -->
		<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
		<div class="layui-form-item">
 			<label class="label" name="ChooseOne"></label></br>
			<div class="layui-input-block">
				<c:set var="length" scope="session" value="${groupListSize }" />
				<!-- 无分组选择，提示 -->
				<c:if test="${length == 0}">
					<div style="margin-top:30px;">
						<span class="i18n" name="NoGroupToChoose"></span>
					</div>
				</c:if>
				<!-- 分组的情况下，展示分组 -->
				<c:if test="${length != 0}">
						<c:forEach items="${groupList}" var="group">
	 					<input type="radio" name="oneCheck" value="${group.groupid}" title="${group.groupName }"
	 						lay-filter="filter" required lay-verify="required"></br> 
					</c:forEach>
				</c:if>			
					</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<a class="layui-btn layui-btn-sm" lay-submit lay-filter="*" 
					onclick="submitBtn('${pageContext.request.contextPath }/ployChangeGroupServlet',${ployid})">
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
		/*
		* 1.加载layui form模块
		*/
		layui.use(['form'], function(){
			  var form = layui.form;
			  //监听单选框
			  form.on('radio()', function(data){
				  
				}); 
			});	 
		
		//2.全局变量,获取id为hiddenLan的value值，是当前系统的语言环境
	    var i18nLanguage = jQuery("#hiddenLan").val();
	
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
	    jQuery.i18n.properties({
	      	 name : 'common', //资源文件名称,本页面只用到common.properties
	      	 path : 'admin/i18n/', //资源文件路径
	      	 mode : 'both', //用Map的方式使用资源文件中的值
	         language : i18nLanguage,
	         callback : function() {//加载成功后设置显示内容
	                 // 第一类：class未使用layui的框架；自己命名的i18n
	                 var insertlabelEle = jQuery(".label"); // 获得所有class为label的元素
	                 insertlabelEle.each(function() {  // 遍历insertlabelEle，根据label元素的 name 获取语言库对应的内容写入
	                	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	                  });
		             // 第三类：class未使用layui的框架；自己命名的i18n
	                 var insertEle = jQuery(".i18n"); // 获得所有class为label的元素
	                 insertEle.each(function() {  // 遍历insertlabelEle，根据label元素的 name 获取语言库对应的内容写入
	                	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
	                  });
	       	  }
	      }); 
		
		//4.提交函数
		function submitBtn(url, ployId){
			var radioObj = document.getElementsByName('oneCheck'); 
			var radioVal = "";//分组id
			for(var i=0; i < radioObj.length; i++ ){
				if(radioObj[i].checked){
					radioVal = radioObj[i].value;
				}
			}
			if(radioVal == ""){
				layer.msg(jQuery.i18n.prop('noChooseObj'),function(){
				});	
			}else{
				jQuery.ajax({
					  type:"post",
			          url:url,
			          data:{
			        	//参数
			        	ployid: ployId,
			        	oneCheck: radioVal,
			          },
			          async : true,
			          datatype: "String",
			          success:function(datasource, textStatus, jqXHR) {
			        	  if(datasource == "重新绑定分组成功"){
			        		 layer.msg(jQuery.i18n.prop('SuccessfulOperation'),function(){
		 		        		  location.reload();
		 		        	  });	
			        	  }else if(datasource == "重新绑定分组失败"){
			        		 layer.msg(jQuery.i18n.prop('OperationFailed'),function(){
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
				}
		}
	</script>
</body>
</html>