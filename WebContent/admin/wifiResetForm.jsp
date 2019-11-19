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
	    <input type="hidden" id="hiddenLan" name="i18nLanguage" value=${i18nLanguage }>
		<div class="layui-form-item">
			<label class="layui-form-label" name="LwifiName"></label>
			<div class="layui-input-block" style="width: 160px;">
				<input type="text" id="ssidInput" required lay-verify="required" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" name="LwifiPassword"></label>
			<div class="layui-input-block" style="width: 160px;">
				<input type="text" id="passwordInput" required lay-verify="required" autocomplete="off" class="layui-input">
			</div>
		</div>
		<table class="layui-table">
			<colgroup>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="i18n" name="LNodeList"></th> 
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" id="allCheckbox" lay-filter="allChoose" lay-skin="primary">
					    <span class="i18n" name="LallCheck" id="chooseOrCancel"></span></td>
				</tr>
				<c:forEach items="${nodeList }" var="node">
					<tr>
						<td><input type="checkbox" name="checkBoxInput" value=${node.id } class="check" lay-skin="primary" title="${node.nodeName }"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="layui-form-item" >
			<div class="layui-input-block" style="margin-left:145px;">
				<a class="layui-btn layui-btn-sm" lay-submit lay-filter="*"
					onclick="submitBtn('${pageContext.request.contextPath }/wifiResetServlet',${userid })">
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
		//1. 获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var i18nLanguage = jQuery("#hiddenLan").val(); 
		
		//2. 监听form表单
		layui.use('form', function(){
			var form = layui.form;
			form.on('checkbox(allChoose)', function(data) {
					ckAll();
					//有些表单元素动态插入,这时 form 模块 的自动化渲染是会对其失效的,需要更新渲染，很重要
					form.render();
			});
		});
		
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		jQuery.i18n.properties({
		  	 name : 'common', //资源文件名称,本页面只用到common.properties
		  	 path : 'admin/i18n/', //资源文件路径
		  	 mode : 'both', //用Map的方式使用资源文件中的值
		     language : i18nLanguage,
		     callback : function() {//加载成功后设置显示内容
		    	
		             // 第一类：class未使用layui的框架；自己命名的i18n
		             var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
		             insertEle.each(function() {  // 遍历insertEle，根据i18n元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		             // 第二类：layui的label
		             var insertLabelEle = jQuery(".layui-form-label"); // 获得所有id为i18n的元素
		             insertLabelEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		           	     jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		     	}
		  });

	    //4.全选与取消
		function ckAll(){
			var checked = document.getElementById("allCheckbox").checked;
			var oneCheck = document.getElementsByClassName("check");
			var chooseSpan = document.getElementById("chooseOrCancel");
			if(checked){ //取消全选操作
				for(var i=0; i< oneCheck.length; i++){
					oneCheck[i].checked=true;
				}
				chooseSpan.innerHTML=jQuery.i18n.prop("Lcancel");//Lcancel取消全选
			}else{//全选操作
				for(var i=0; i< oneCheck.length; i++){
					oneCheck[i].checked=false;
				}
				chooseSpan.innerHTML=jQuery.i18n.prop("LallCheck");//LallCheck全选
			}
		}
	    
	//5.提交函数
	function submitBtn(url,userid){
		var ssidVal = jQuery("#ssidInput").val(); 
		var passwordVal = jQuery("#passwordInput").val();
		var chenBoxObj = document.getElementsByName('checkBoxInput');
		var nodeIdArr = new Array();
		//获取选择checkbox的值（节点id）
		for(var i=0; i < chenBoxObj.length; i++){
			if(chenBoxObj[i].checked){
				nodeIdArr.push(chenBoxObj[i].value);
			}
		}
		//ajax请求删除
		if(ssidVal == "" ||  passwordVal == ""){//输入框未填
			 layer.msg(jQuery.i18n.prop('InputIsNull'));
			
		}else if(nodeIdArr.length == 0){//未选择对象
			 layer.msg(jQuery.i18n.prop('noChooseObj'));
		
		}else{
			jQuery.ajax({
  			  type:"post",
  			  url:url,
  			  data:{
  				userid: userid,
  				ssid: ssidVal,
  				password: passwordVal,
  				nodeIdArr: nodeIdArr.join(","),
  			  },
  			  async : true,
  			  datatype: "String",
  			  success:function(datasource, textStatus, jqXHR) {
  				  if(datasource > 0){
	      					layer.msg(datasource + " " + jQuery.i18n.prop('NCmdSuccess') + jQuery.i18n.prop('NCmdSuccess'),function(){
		      					location.reload();
		      				  });
  				  }else if(datasource == "指令发送失败"){
	      					layer.msg(jQuery.i18n.prop('cmdSendFail'),function(){
	      						location.reload();
		      				  });
  				  }else if(datasource == "指令发送失败请检查设备是否已离线"){
  					layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){
  						location.reload();
      				  });
  				  }else{
  					  
  				  }
  			  },
  			  error: function() {  
  				  //提交失败
  				  layer.msg(jQuery.i18n.prop('submitFailed'));
  	      		}
    		});	
		}
	}
	</script>
</body>
</html>