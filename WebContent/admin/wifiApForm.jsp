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
	<input type="hidden" id="userid" value=${userid }>
	<!-- 作为隐藏标签,用于储存语言类型,在项目中传递 -->
	<input type="hidden" id="hiddenLan" name="i18nLanguage" value=${i18nLanguage }>
	<div class="layui-form-item" style="margin-top:20px;margin-left:15px;">
		<div id="nodeTree" class="demo-tree"></div>
	</div>
	<div class="layui-form-item">
		<div class="layui-input-block" style="margin-left:145px;">
			<button type="button" class="layui-btn layui-btn-sm" lay-demo="getChecked">
				<font class="i18n" name="Lsubmit"></font>
			</button>
		</div>
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>       
 	<script type="text/javascript"
 		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script>
		//1. 全局变量
		var userid = document.getElementById("userid").value;
		var i18nLanguage = document.getElementById("hiddenLan").value;
		
		//2.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		jQuery.i18n.properties({
		  	 name : 'common', //资源文件名称,本页面只用到common.properties
		  	 path : 'admin/i18n/', //资源文件路径
		  	 mode : 'both', //用Map的方式使用资源文件中的值
		     language : i18nLanguage,
		     callback : function() {//加载成功后设置显示内容
		             // 第三类：layui的button
		             var insertEle = jQuery(".i18n"); // 获得所有id为i18n的元素
		             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		     	}
		  });
		
		//3.加载layui模块
		layui.use([ 'tree', 'util' ],function() {
				var tree = layui.tree, util = layui.util//由于layer弹层依赖jQuery，所以可以直接得到
				, layer = layui.layer;
				jQuery.ajax({
					type : "post",
					url : "${pageContext.request.contextPath }/getNodeTreeDataServlet",
					data : {
						id : userid,
						i18nLanguage:i18nLanguage,
					},
					async : true,
					datatype : "Json",
					success : function(datasource,
							textStatus, jqXHR) {
						var ballasts = datasource.ballasts;
						var leds = datasource.leds;
						var wifis = datasource.wifis;
						var data = new Array()
						
						data[2] = ballasts;
						data[1] = leds;
						data[0] = wifis;
						//开启复选框
						tree.render({
							elem : '#nodeTree',
							data : data,
							showCheckbox : true,
							id: 'treeId'
						});
	
					},
					error : function() {
						//获取数据失败
						layer.msg(jQuery.i18n.prop('getDataFail'));
					}				
					});
										
			   //按钮事件
			   util.event('lay-demo', { getChecked: function(othis){
					var nodeIdArr = []; //选中的节点id数组
					var checkedData = tree.getChecked('treeId'); //获取选中节点的数据
				    // alert(JSON.stringify(checkedData));
				    // alert("totallength:"+checkedData.length);
					for(var i = 0; i < checkedData.length; i++){
				    	  var treeObj = checkedData[i].children;
				    	  for(var j = 0; j < treeObj.length; j++){
						      nodeIdArr.push(treeObj[j].id);
				    	  }
				      }
				    // alert("ndoeid:"+JSON.stringify(nodeIdArr));
				    if(nodeIdArr.length == 0){
				    	layer.alert(jQuery.i18n.prop('noChooseObj'),{
				    		title:jQuery.i18n.prop('Tips'),
				    	    btn: jQuery.i18n.prop('confirmBtn'), //可以无限个按钮
				    	});
				    }else{
				        jQuery.ajax({
							type : "post",
							url : "${pageContext.request.contextPath }/resetNodeApModelServlet",
							data : {
								nodeid : JSON.stringify(nodeIdArr),
							},
							async : true,
							datatype : "Json",
							success : function(datasource,textStatus, jqXHR) {
								if(datasource == "指令发送成功"){
									layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
										location.reload();
									});
								}else if(datasource == "指令发送失败请检查设备是否已离线"){
									layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){
										location.reload();
									});
								}else if(datasource == "未选择对象"){
									layer.msg(jQuery.i18n.prop('noChooseObj'),function(){
										location.reload();
									});
								}
							},
							error : function() {
								//提交失败;
								layer.msg(jQuery.i18n.prop('submitFailed'));
							}
						});
				    }
				 },
			 });
	  	});				 
	</script>
</body>
</html>