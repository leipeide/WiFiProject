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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
<title></title>
<style>
/*layui-layout-body.{
	overflow:visible
}
*/
</style>
</head>
<body>
	<input type="hidden" id="userid" value=${userid}>
	<div class="layui-form-item">
		<div id="nodeTree" class="demo-tree"></div>
	</div>
	<div class="layui-form-item">
		<div class="layui-input-block">
			<button type="button" class="layui-btn layui-btn-sm" lay-demo="getChecked">提交</button>
		</div>
	</div>
	<script>
		var userid = document.getElementById("userid").value;
		layui
				.use(
						[ 'tree', 'util' ],
						function() {
							var tree = layui.tree, util = layui.util, $ = layui.$//由于layer弹层依赖jQuery，所以可以直接得到
							, layer = layui.layer;
							$
									.ajax({
										type : "post",
										url : "${pageContext.request.contextPath }/getNodeTreeDataServlet",
										data : {
											id : userid
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
											layer.msg("获取数据失败!");
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
							    	layer.alert("未选择操作对象!");
							    }else{
							      $
									.ajax({
										type : "post",
										url : "${pageContext.request.contextPath }/resetNodeApModelServlet",
										data : {
											//checkedData  : checkedJsonData 
											nodeid : JSON.stringify(nodeIdArr),
										},
										async : true,
										datatype : "Json",
										success : function(datasource,textStatus, jqXHR) {
											layer.msg(datasource,function(){
												location.reload();
											});
										},
										error : function() {
											layer.msg("提交失败!");
										}
									});
							    }

							    },
							  });
						});
							 
	</script>
</body>
</html>