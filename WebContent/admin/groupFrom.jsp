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
<style>
.functionDiv1 {
	/* 	border:3px solid #00695F;     */
	height: 40px;
}

.addGroupDiv1 {
	float: left;
}

.selectGroupDiv1 {
	float: left;
	margin-left: 20px;
	width: 110px;
	height: 50px;
	/* 	border:3px solid #00695F; */
}

.tableDiv1 {
	/*     border:3px solid #00695F;      */
	
}


/* led选项卡区域 */
.addGroupDiv2 {
	float: left;
}
.selectGroupDiv2 {
	float: left;
	margin-left: 20px;
	width: 110px;
	height: 50px;
	/* 	border:3px solid #00695F; */
}

/* wifi选项卡区域 */
.addGroupDiv3 {
	float: left;
}
.selectGroupDiv3 {
	float: left;
	margin-left: 20px;
	width: 110px;
	height: 50px;
	/* 	border:3px solid #00695F; */
}
</style>
</head>
<body>
	<form class="layui-form" method="" action="">
		<input type="hidden" name="useridDiv" id="useridDiv" value="${userid }">
		<div class="layui-tab layui-tab-brief" lay-filter="TabBrief">
			<ul class="layui-tab-title">
				<li class="layui-this" lay-id="ballastGroup">镇流器组</li>
				<li lay-id="ledDriverGroup">led驱动器组</li>
				<li lay-id="wifiGroup">wifi无线调光器组</li>
			</ul>
			
			<div class="layui-tab-content">
			
				<!-- 			1.Tab镇流器分组区域 -->
				<div class="layui-tab-item layui-show" id="ballast_table">
					<div class="functionDiv1">
						<div class="addGroupDiv1">
							<a href="javascript:;" class="layui-btn"
								onclick="addBalletGroup('${pageContext.request.contextPath }/addBallastGroupFromServlet',${userid })">添加分组</a>
						</div>
						<div class="selectGroupDiv1">
							<select name="select1" lay-filter="select1">
								<option value="allGroup">所有分组</option>
								<c:forEach items="${GroupMap.ballastGroup}" var="ballastGroup">
									<option value=${ballastGroup.groupid}>${ballastGroup.groupName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv1">
						<div id="allGroupTableDiv1" style="display: block">
							<table class="layui-table">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>组名</th>
										<th>节点数量</th>
								<!-- 	<th>在线镇流器</th>
										<th>离线镇流器</th> -->
										<th>添加镇流器</th>
										<th>删除分组</th>
										<th>广播控制</th>
									</tr>
								</thead>
								<tbody id="ballastGroupTableTbody">
<%--  									<c:forEach items="${GroupMap.ballastGroup}" var="ballastGroup">  
										<tr>
											<td><a href="javascript:;"
												onclick="groupRename('${pageContext.request.contextPath }/groupRenameFormServlet',${ballastGroup.groupid},${userid})"><span><font
														color="#009688">${ballastGroup.groupName }</font></span></a></td>
											<td>${ballastGroup.onlineNum}</td>
											<td>${ballastGroup.offlineNum}</td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="addBallestToBallestGroup('${pageContext.request.contextPath }/addBallastToBallastGroupFromServlet',${ballastGroup.groupid},${userid })">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet',${ballastGroup.groupid})"><i
													class="layui-icon">&#xe640;</i></a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet',${ballastGroup.groupid },${userid })">开灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet',${ballastGroup.groupid },${userid })">关灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet',${ballastGroup.groupid },${userid })">调光</a>
											</td>
										</tr>
									</c:forEach>
								--%>
								</tbody>
							</table>
						</div>
						<!-- 分组内的节点表格 -->
						<div id="oneGroupTableDiv1" style="display: none">
							<table class="layui-table">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>节点mac地址</th>
										<th>节点名称</th>
										<th>网络状态</th>
										<th>开关状态</th>
										<th>调光参数</th>
     									<th>单灯控制</th>
										<th>删除</th>
									</tr>
								</thead>
								<tbody id="ballastGroupsTbody">
									<!-- 分组内的节点表格数据通过ajax获取 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				
				<!-- 			2.led驱动器分组区域 -->
				<div class="layui-tab-item" id="ledDriver_table">
					<div class="functionDiv2">
						<div class="addGroupDiv2">
							<a href="javascript:;" class="layui-btn"
								onclick="addLedGroup('${pageContext.request.contextPath }/addLedGroupFromServlet',${userid })">添加分组</a>
						</div>
						<div class="selectGroupDiv2">
							<select name="select2" lay-filter="select2">
								<option value="allGroup">所有分组</option>
								<c:forEach items="${GroupMap.ledGroup}" var="ledGroup">
									<option value=${ledGroup.groupid}>${ledGroup.groupName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv2">
						<div id="allGroupTableDiv2" style="display: block">
							<table class="layui-table">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>组名</th>
										<th>节点数量</th>
<!-- 									<th>在线led</th>
										<th>离线led</th> -->
										<th>添加led</th>
										<th>删除分组</th>
										<th>广播控制</th>
									</tr>
								</thead>
								<tbody id="ledGroupTableTbody">
<%--  									<c:forEach items="${GroupMap.ledGroup}" var="ledGroup"> 
										<tr>
											<td><a href="javascript:;"
												onclick="groupRename('${pageContext.request.contextPath }/groupRenameFormServlet',${ledGroup.groupid},${userid})">
													<span><font color="#009688">${ledGroup.groupName}</font></span>
											</a></td>
											<td>${ledGroup.onlineNum}</td>
											<td>${ledGroup.offlineNum}</td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="addLedToLedGroup('${pageContext.request.contextPath }/addLedToLedGroupFromServlet',${ledGroup.groupid},${userid })">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet',${ledGroup.groupid})">
													<i class="layui-icon">&#xe640;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet',${ledGroup.groupid},${userid })">开灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet',${ledGroup.groupid},${userid })">关灯</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet',${ledGroup.groupid},${userid })">调光</a>
												<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet',${ledGroup.groupid},${userid })">调色</a>
											</td>
										</tr>
									</c:forEach>
									--%>
								</tbody>
							</table>
						</div>
						<div id="oneGroupTableDiv2" style="display: none">
							<table class="layui-table">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>节点mac地址</th>
										<th>节点名称</th>
										<th>网络状态</th>
										<th>开关状态</th>
										<th>调光参数</th>
										<th>调色参数</th>
 										<th>单灯控制</th> 
										<th>删除</th>
									</tr>
								</thead>
								<tbody id="ledGroupsTbody">
									<!-- 分组内的节点表格数据通过ajax获取 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<%--wifi无线调光器分组Tab选项区域 --%>
				<div class="layui-tab-item">
					<div class="functionDiv3">
						<div class="addGroupDiv3">
							<a href="javascript:;" class="layui-btn"
								onclick="addWifiGroup('${pageContext.request.contextPath }/addWifiGroupFromServlet',${userid })">添加分组</a>
						</div>
						<div class="selectGroupDiv3">
							<select name="select3" lay-filter="select3">
								<option value="allGroup">所有分组</option>
								<c:forEach items="${GroupMap.wifiGroup}" var="wifiGroup">
									<option value=${wifiGroup.groupid}>${wifiGroup.groupName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="tableDiv3">
						<div id="allGroupTableDiv3" style="display: block">
							<table class="layui-table">
								<colgroup>
									<col width="150">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>组名</th>
										<th>节点数量</th>
<!-- 									<td>在线调光器</td> 
										<td>离线调光器</td>-->
										<th>添加调光器</th>
										<th>删除分组</th>
										<th>调光控制</th>
									</tr>
								</thead>
								<tbody id="wifiGroupTableTbody">
<%-- 									<c:forEach items="${GroupMap.wifiGroup}" var="wifiGroup">
										<tr>
											<td><a href="javascript:;"
												onclick="groupRename('${pageContext.request.contextPath }/groupRenameFormServlet',${wifiGroup.groupid},${userid})"><span><font
														color="#009688">${wifiGroup.groupName}</font></span></a></td>
											<td>${wifiGroup.onlineNum}</td>
											<td>${wifiGroup.offlineNum}</td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="addWifiToWifiGroup('${pageContext.request.contextPath }/addWifiToWifiGroupFromServlet',${wifiGroup.groupid},${userid })">
													<i class="layui-icon">&#xe654;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet',${wifiGroup.groupid})">
													<i class="layui-icon">&#xe640;</i>
											</a></td>
											<td><a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="groupDimByLux('${pageContext.request.contextPath }/groupDimByLuxFormServlet',${wifiGroup.groupid},${userid })">调光</a>
											</td>
										</tr>
									</c:forEach>
									 --%>
								</tbody>
							</table>
						</div>
						<div id="oneGroupTableDiv3" style="display: none">
							<table class="layui-table">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>节点mac地址</th>
										<th>节点名称</th>
										<th>网络状态</th>
<!-- 										<th>开关状态</th> -->
										<th>调光参数</th>
 										<th>单灯控制</th>
										<th>删除</th>
									</tr>
								</thead>
								<tbody id="wifiGroupsTbody">
									<!-- 分组内的节点表格数据通过ajax获取 -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/groupFrom.js"></script>
		
	<script type="text/javascript">	
		var groupId = ""; //全局变量，分组id,用于刷新分组下的节点信息页面
		var groupType = "";//全局变量，分组类型,默认为1；用于刷新分组下的节点信息页面；根据分组类型选择相应的刷新节点信息函数
		var userId = document.getElementById("useridDiv").value; //全局变量用户id
		layui.use(['element','slider','form'], function(){
			  var element = layui.element;
			  var slider = layui.slider;
			  var form = layui.form;
			  //1.监听Tab选项卡
			  var layid = location.hash.replace(/^#TabBrief=/, ''); //.获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
			  element.tabChange('TabBrief', layid); //.切换到lay-id对应的tab选项
			  element.on('tab(TabBrief)', function(){  //.监听Tab切换，以改变地址hash值
				var layid = this.getAttribute('lay-id');
				location.hash = 'TabBrief='+ layid;
				//切换tab,给groupType赋相应的值，用于相应tab区域分组表格的刷新
			    if(layid == "wifiGroup"){
			   		groupType = 3;
			   	}else if(layid == "ledDriverGroup"){
			   		groupType = 2;
			   	} else {
			   		groupType = 1;
			   	}
			   	//由于分组的表格是通过ajax动态添加的，故切换tab选项时分组表格需动态再次添加
			    GroupRefreshAJAXRequest();
			  });
			  
			  //2.调色滑块的使用
			  slider.render({
			    elem: '#ledDriverSlide'
			  });
			  
			  //3.镇流器select监听
			  form.on('select(select1)',function(data){
				  groupType = 1; //分组类型，镇流器分组类型为1;
				  if(data.value == "allGroup"){ //返回所有分组的页面；异步ajax刷新分组表格
					  document.getElementById("oneGroupTableDiv1").style.display = "none";
					  document.getElementById("allGroupTableDiv1").style.display = "block";
					  groupId = "";
					  GroupRefreshAJAXRequest();
				  }else{//进入单个分组内的节点页面，异步ajax刷新单个分组内的节点表格
					  document.getElementById("oneGroupTableDiv1").style.display = "block";
					  document.getElementById("allGroupTableDiv1").style.display = "none";
					  groupId = data.value;
					  IntoBallastGroupNodeTable(groupId);
				  }
			  });
			  
			  //4.LED select监听
			  form.on('select(select2)',function(data){
				  groupType = 2; //分组类型，led分组类型为2;
				  if(data.value == "allGroup"){ //返回所有分组的页面；异步ajax刷新分组表格
					  document.getElementById("oneGroupTableDiv2").style.display = "none";
					  document.getElementById("allGroupTableDiv2").style.display = "block";
					  groupId = "";
					  GroupRefreshAJAXRequest();
				  }else{//进入单个分组内的节点页面，异步ajax刷新单个分组内的节点表格
					  document.getElementById("oneGroupTableDiv2").style.display = "block";
					  document.getElementById("allGroupTableDiv2").style.display = "none";
					  groupId = data.value;
					  IntoLedGroupNodeTable(groupId);
				  }
			  });
			  
			  //3.WIFI select监听
			  form.on('select(select3)',function(data){
				  groupType = 3; //分组类型，wifi分组类型为3;
				  if(data.value == "allGroup"){ //返回所有分组的页面；异步ajax刷新分组表格
					  document.getElementById("oneGroupTableDiv3").style.display = "none";
					  document.getElementById("allGroupTableDiv3").style.display = "block";
					  groupId = "";
					  GroupRefreshAJAXRequest();
				  }else{//进入单个分组内的节点页面，异步ajax刷新单个分组内的节点表格
				  	  allGroupTableDiv3 = "none";
				  	  oneGroupTableDiv3 = "block";
					  document.getElementById("oneGroupTableDiv3").style.display = "block";
					  document.getElementById("allGroupTableDiv3").style.display = "none";
					  groupId = data.value;
					  IntoWifiGroupNodeTable(groupId);
				  }
			  });
			  
			});
		 //向单个镇流分组表格内插入镇流器分组下的节点数据
		 function IntoBallastGroupNodeTable(groupId){
			 layui.use('layer', function(){
				 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
			    ,layer = layui.layer;
					 $.ajax({
						  type:"post",
				          url:"${pageContext.request.contextPath}/getGroupNodesServlet",
				          data:{
				        	//参数
				        	groupid:groupId,
				          },
				          async : true,
				          datatype: "Json",
				          success:function(datasource, textStatus, jqXHR) {
				        	  var json = datasource; 
				        	  //alert(datasource);
				        	  var node = "";
				        	  inner = "";
				        	  for(var index=0; index < json.length; index++){
				        		  node = json[index];
				        		  inner = inner + "<tr><td>" + node.mac + "</td>\
			        		 		<td>" + node.nodeName + "</td>\
									<td>";
									if (node.online) {
										inner = inner + "在线";
									} else {
										inner = inner + "离线";
									}
									inner = inner + "</td>\
									<td>";
									if (node.switchState == 1) {
										inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoON.png'>";
										
									} else {
										inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoOFF.png'>";
									} 
									inner = inner + "</td>\
									<td>" +  node.precentage + "%</td>\
									<td>";
									if (node.lastOperateType == "open") {
										inner = inner +"<a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a>";
									} else if(node.lastOperateType == "close") {
										inner = inner +"<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a>";
									} else if(node.lastOperateType == "dim"){
										inner = inner +"<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a>";
									}else{
										inner = inner +"<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a>";
									}
									inner = inner + "</td>\
									<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromBallastGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet', "+groupId+"," + node.id + "," + node.userid + " )\"><i class='layui-icon'>&#xe640;</i></a></td>\
								</tr>";
			        		 
			        	  	}
				            document.getElementById("ballastGroupsTbody").innerHTML = inner;
				        	
				          },
				          error: function() {  
				          	  layer.msg("查询失败!");	
				          	}
				  		});		  
		  		});	
			
		 }
		 
		//向单个led分组表格内插入led分组下的节点数据
		 function IntoLedGroupNodeTable(groupId){
			 layui.use('layer', function(){
				 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
			    ,layer = layui.layer;
					 $.ajax({
						  type:"post",
				          url:"${pageContext.request.contextPath}/getGroupNodesServlet",
				          data:{
				        	//参数
				        	groupid:groupId,
				        	
				          },
				          async : true,
				          datatype: "Json",
				          success:function(datasource, textStatus, jqXHR) {
				        	  var json = datasource; 
				        	  var node = "";
				        	  inner = "";
				        	  for(var index=0; index < json.length; index++){
				        		  node = json[index];
				        		  inner = inner + "<tr><td>" + node.mac + "</td>\
			        		 		<td>" + node.nodeName + "</td>\
									<td>";
									if (node.online) {
										inner = inner + "在线";
									} else {
										inner = inner + "离线";
									}
									inner = inner + "</td>\
									<td>";
									if (node.switchState == 1) {
										inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoON.png'>";
									} else {
										inner = inner + "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/admin/img/dengpaoOFF.png'>";
									} 
									inner = inner + "</td>\
									<td>" + node.precentage + "%</td>\
									<td>红色" + node.colorPrecentage + "%</td>\
									<td>";
									if (node.lastOperateType == "open") {
										inner = inner + "<a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a>";
									} else if(node.lastOperateType == "close") {
										inner = inner + "<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a>";
									} else if(node.lastOperateType == "dim"){
										inner = inner + "<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a>";
									} else if(node.lastOperateType == "toning"){
										inner = inner + "<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a><a href='javascript:;' class='layui-btn layui-btn-danger layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a>";
									}else{
										inner = inner + "<a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOn('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">开灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeSwitchOff('${pageContext.request.contextPath }/nodeInGroupSwitchServlet', " + node.id + ")\">关灯</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodePwmDim('${pageContext.request.contextPath }/nodeInGroupPwmDimFromServlet', " + node.id + ")\">调光</a><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeToning('${pageContext.request.contextPath }/nodeInGroupToningFromServlet',"+ node.id +")\">调色</a>";
									}
									inner = inner + "</td>\
									<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromLedGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet',"+groupId+","+node.id+","+node.userid+")\"><i class='layui-icon'>&#xe640;</i></a></td>\
								</tr>";	 
					        	
				        	  }
				        	 document.getElementById("ledGroupsTbody").innerHTML = inner;
				        	
				        	 
				          },
				          error: function() {  
				          	  layer.msg("查询失败!");	
				          	}
				  		});		  
		  		});	
			
		 }
		
		 function IntoWifiGroupNodeTable(groupId){
			 layui.use('layer', function(){
				 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
			    ,layer = layui.layer;
					 $.ajax({
						  type:"post",
				          url:"${pageContext.request.contextPath}/getGroupNodesServlet",
				          data:{
				        	//参数
				        	groupid:groupId,
				        	
				          },
				          async : true,
				          datatype: "Json",
				          success:function(datasource, textStatus, jqXHR) {
				        	  var json = datasource; 
				        	  var node = "";
				        	  inner = "";
				        	  for(var index=0; index < json.length; index++){
				        		  node = json[index];
				        		  inner = inner + "<tr><td>" + node.mac + "</td>\
				        		  <td>" + node.nodeName + "</td>\
									<td>";
									if (node.online) {
										inner = inner + "在线";
									} else {
										inner = inner + "离线";
									}
									inner = inner + "</td>\
									<td>" +  node.lux + " Lux</td>\
									<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"nodeLuxDim('${pageContext.request.contextPath }/nodeInGroupLuxDimFromServlet',"+ node.id +")\">调光</a></td>\
									<td><a href='javascript:;' class='layui-btn layui-btn-xs' onclick=\"removeNodeFromWifiGroup('${pageContext.request.contextPath }/removeNodeFromGroupServlet',"+groupId+","+node.id+","+node.userid+")\"><i class='layui-icon'>&#xe640;</i></a></td>\
									</tr>";	 
				        	 	 }
				        	 	document.getElementById("wifiGroupsTbody").innerHTML = inner;
				        	 
				          },
				          error: function() {  
				          	  layer.msg("查询失败!");	
				          	}
				  		});		  
		  		});	
		 }
		 
		 /*
			*注意：
			*页面刷新，指定5分钟刷新一次；
			*由于页面操作时会重载数据；故此自动刷新函数主要是对节点的在线状态进行实时刷新；
			*故不需要刷新太频繁，在此将刷新时间设置为5分钟
			*/
		window.onload = function() {
			GroupRefreshAJAXRequest();
			setInterval(function(){
				pageRefresh();
				 
			},1000*60*5);  
			
		}
		//刷新页面函数
		function pageRefresh(){
			GroupRefreshAJAXRequest();
			if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
				IntoBallastGroupNodeTable(groupId);
			
			}else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
				IntoLedGroupNodeTable(groupId);
			
			}else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
				IntoWifiGroupNodeTable(groupId);
			
			}else{
				
				
			}
		}
		//判断浏览器是否对ajax进行响应
		function getXMLHttpRequest() {
			var xmlhttp;
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			return xmlhttp;
		}
		//ajax动态获取节点分组的信息
		function GroupRefreshAJAXRequest() {
			var req = getXMLHttpRequest();
			req.onreadystatechange = function() {
				if (req.readyState == 4) {// 请求成功
					if (req.status == 200) {// 服务器响应成功
						var GroupMap = JSON.parse(req.responseText);
						var ballastGS = GroupMap.ballastGroup;
						var ledGS = GroupMap.ledGroup;
						var wifiGS = GroupMap.wifiGroup;
						var inner1 = ""; //镇流器分组table动态插入对象
						var inner2 = ""; //led驱动器分组table动态插入对象
						var inner3 = ""; //wi无线调光器分组table动态插入对象
						var bgObj; //镇流器分组对象
						var lgObj; //led分组对象
						var wgObj; //wifi分组对象
						//alert("groupType:"+groupType+"镇流器分组大小："+ballastGS.length+"led分组大小："+ledGS.length+"wifi分组大小："+wifiGS.length);
						//1.动态插入镇流器分组表格
						for (var i = 0; i < ballastGS.length; i++) {
							bgObj =  ballastGS[i];
							inner1 = inner1 + "<tr>\
								<td><a href=\"javascript:;\"\
										onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + bgObj.groupid + ", " + bgObj.userid + ")\"><span><font color=\"#009688\"> " +bgObj.groupName + "</font></span></a></td>\
								<td>" + bgObj.nodeNum + "</td>\
								<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"addBallestToBallestGroup('${pageContext.request.contextPath }/addBallastToBallastGroupFromServlet', " + bgObj.groupid + ", " + bgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
								<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + bgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
								<td>";
									if (bgObj.lastOperateType == "open") {
										inner1 = inner1 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">开灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">关灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">调光</a>";
									} else if(bgObj.lastOperateType == "close") {
										inner1 = inner1 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">开灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
											onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">关灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">调光</a>";
									} else if(bgObj.lastOperateType == "dim"){
										inner1 = inner1 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">开灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">关灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
											onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">调光</a>";
									}else{
										inner1 = inner1 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">开灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">关灯</a>\
										<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
											onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + bgObj.groupid + ", " + bgObj.userid + ")\">调光</a>";
									}
									inner1 = inner1 + "</td>\
							</tr>";
						
						}
						//2.动态插入led分组表格
						for (var i = 0; i < ledGS.length; i++) {
							lgObj = ledGS[i];
							inner2 = inner2 + "<tr>\
								<td><a href=\"javascript:;\"\
										onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + lgObj.groupid + ", " + lgObj.userid + ")\"><span><font color=\"#009688\"> " +lgObj.groupName + "</font></span></a></td>\
								<td>" + lgObj.nodeNum + "</td>\
								<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"addLedToLedGroup('${pageContext.request.contextPath }/addLedToLedGroupFromServlet', " + lgObj.groupid + ", " + lgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
								<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + lgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
								<td>";
								if (lgObj.lastOperateType == "open") {
									inner2 = inner2 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a>";
								} else if(lgObj.lastOperateType == "close") {
									inner2 = inner2 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
										onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a>";
								} else if(lgObj.lastOperateType == "dim"){
									inner2 = inner2 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
										onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a>";
								}else if(lgObj.lastOperateType == "toning"){
									inner2 = inner2 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
									onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-danger layui-btn-xs\"\
										onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a>";
								}else{
									inner2 = inner2 + "<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOnNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">开灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupSwitchOffNode('${pageContext.request.contextPath }/groupSwitchServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">关灯</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupDimNode('${pageContext.request.contextPath }/groupDimFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调光</a>\
									<a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupToningNode('${pageContext.request.contextPath }/groupToningFromServlet'," + lgObj.groupid + ", " + lgObj.userid + ")\">调色</a>";
								}
								inner2 = inner2 + "</td>\
							</tr>";
						
						}
						//3.动态插入wifi分组表格
						for (var i = 0; i < wifiGS.length; i++) {
							wgObj = wifiGS[i];
							inner3 = inner3 + "<tr>\
								<td><a href=\"javascript:;\"\
										onclick=\"groupRename('${pageContext.request.contextPath }/groupRenameFormServlet', " + wgObj.groupid + ", " + wgObj.userid + ")\"><span><font color=\"#009688\"> " +wgObj.groupName + "</font></span></a></td>\
								<td>" + wgObj.nodeNum + "</td>\
								<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"addWifiToWifiGroup('${pageContext.request.contextPath }/addWifiToWifiGroupFromServlet', " + wgObj.groupid + ", " + wgObj.userid + ")\"><i class=\"layui-icon\">&#xe654;</i></a></td>\
								<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"deleteGroup('${pageContext.request.contextPath }/deleteGroupServlet', " + wgObj.groupid + ")\"><i class='layui-icon'>&#xe640;</i></a></td>\
								<td><a href=\"javascript:;\" class=\"layui-btn layui-btn-xs\"\
										onclick=\"groupDimByLux('${pageContext.request.contextPath }/groupDimByLuxFormServlet'," + wgObj.groupid + ", " + wgObj.userid + ")\">调光</a>\</td>\
							</tr>";
						}
						document.getElementById("ballastGroupTableTbody").innerHTML = inner1;
						document.getElementById("ledGroupTableTbody").innerHTML = inner2;
						document.getElementById("wifiGroupTableTbody").innerHTML = inner3;
						
					}
				}
			}
			// 发送请求， 建立一个链接
			req.open("post", "${pageContext.request.contextPath }/refreshGroupServlet", true);
			// POST方式需要自己设置http的请求头
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			// POST方式发送数据
			req.send("userid=" + userId);
		//	req.open("get","${pageContext.request.contextPath }/refreshGroupServlet?userid=${userid}");
		//	req.send(null);// 发送请求
		}
		
	</script>
</body>
</html>