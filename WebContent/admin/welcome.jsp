<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta http-equiv="refresh" content="10"> -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/jsp/jquery.min.js"></script>
<title>Insert title here</title>
<style>
  .pagenation { width: 100%; position: relative; bottom: -20px;}
</style> 
</head>
<body>
	<div class="layui-tab layui-tab-brief" lay-filter="TabBrief">
		<ul class="layui-tab-title">
			<li class="layui-this" lay-id="zhenliuqi">镇流器</li>
			<li lay-id="ledDriver">led驱动器</li>
			<li lay-id="wifi">wifi无线调光器</li>
		</ul>
		<div class="layui-tab-content">
<!-- 			1.Tab镇流器区域 -->
			<div class="layui-tab-item layui-show" id="zhenliuqi_table">
				<form method="post" action="">
					<table class="layui-table">
						<colgroup>
							<col width="130">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th>节点mac地址</th>
								<th>节点名称</th>
								<th>网络状态</th>
								<th>开关状态</th>
								<th>调光参数</th>
								<th><a href="javascript:;"
										onclick="BroadcastControl('${pageContext.request.contextPath }/broadcastControlFormServlet', ${userid}, 'ballastBC')"><span><font color="#009688">广播控制</font></span></a></th>
							</tr>
						</thead>
						<tbody id="nodes-list">
						 	<c:forEach items="${result.ballast }" var="ballast">
								<tr>
									<td>${ballast.mac }</td>
									<td><a href="javascript:;"
										onclick="nodeRename('${pageContext.request.contextPath }/nodeRenameFromServlet', ${ballast.id})"><span><font color="#009688">${ballast.nodeName }</font></span></a></td>
									<td>${ballast.online == true ? "在线" : "离线" }</td>
<%-- 									<td>${ballast.switchState == 0 ? "关灯" : "开灯"}</td> --%>
									<td>${ballast.switchState == 0 ? "<img style='width:25px;height:25px' src='admin/img/dengpaoOFF.png'>" : "<img style='width:25px;height:25px' src='admin/img/dengpaoON.png'>"}</td>
									<td>${ballast.precentage }%</td>
									<td>
										<c:set var="lastOperateType" scope="session" value="${ballast.lastOperateType}"/>
										<c:if test="${ lastOperateType == 'open'}">
  											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${ballast.id })">调光</a>
										</c:if>
										<c:if test="${ lastOperateType == 'close'}">
  											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${ballast.id })">调光</a>
										</c:if>
										<c:if test="${ lastOperateType == 'dim'}">
  											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${ballast.id })">调光</a>
										</c:if>
										<c:if test="${ lastOperateType == null}">
  											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${ballast.id })">调光</a>
										</c:if>
									</td>
								</tr>
							</c:forEach> 
						</tbody>
					</table>
				</form>
			</div>
<!-- 			2.Tab驱动器区域 -->
			<div class="layui-tab-item" id="ledDriver_table">
				<form method="post" action="">
					<table class="layui-table">
						<colgroup>
							<col width="110">
							<col width="110">
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
								<th><a href="javascript:;"
										onclick="BroadcastControl('${pageContext.request.contextPath }/broadcastControlFormServlet', ${userid}, 'ledBC')"><span><font color="#009688">广播控制</font></span></a></th>
							</tr>
						</thead>
						<tbody id="nodes-list1">
					        <c:forEach items="${result.led }" var="led">
								<tr>
									<td>${led.mac }</td>
									<td><a href="javascript:;"
										onclick="nodeRename('${pageContext.request.contextPath }/nodeRenameFromServlet', ${led.id})"><span><font color="#009688">${led.nodeName }</font></span></a></td>
									<td>${led.online == true ? "在线" : "离线" }</td>
<%-- 									<td>${led.switchState == 0 ? "关灯" : "开灯"}</td> --%>
									<td>${led.switchState == 0 ? "<img style='width:25px;height:25px' src='admin/img/dengpaoOFF.png'>" : "<img style='width:25px;height:25px' src='admin/img/dengpaoON.png'"}</td>
									<td>${led.precentage }%</td>
									<td>红色${led.colorPrecentage }%</td>
									<td>
										<c:set var="lastOperateType" scope="session" value="${led.lastOperateType}"/>
										<c:if test="${ lastOperateType == 'open'}">
  											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">调光</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">调色</a>
										</c:if>
										<c:if test="${ lastOperateType == 'close'}">
  											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">调光</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">调色</a>
										</c:if>
										<c:if test="${ lastOperateType == 'dim'}">
  											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">调光</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">调色</a>
										</c:if>
										<c:if test="${ lastOperateType == 'toning'}">
  											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">调光</a>
											<a href="javascript:;" class="layui-btn layui-btn-danger layui-btn-xs" onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">调色</a>
										</c:if>
										<c:if test="${ lastOperateType == null}">
  											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">开灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">调光</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">调色</a>
										</c:if>
<%-- 											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">开灯</a> 
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">关灯</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">调光</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">调色</a>
											--%>
									</td>
								</tr>
							</c:forEach>  
						</tbody>
					</table>
				</form>
			</div>
			
			<%--wifi无线调光器Tab选项区域 --%>
			<div class="layui-tab-item">
				<form method="post" action="">
					<table class="layui-table">
						<colgroup>
							<col width="130">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th>节点mac地址</th>
								<th>节点名称</th>
								<th>网络状态</th>
								<th>调光参数</th>
								<th><a href="javascript:;"
										onclick="BroadcastControl('${pageContext.request.contextPath }/broadcastControlFormServlet', ${userid}, 'wifiBC')"><span><font color="#009688">广播控制</font></span></a></th>
							</tr>
						</thead>
						<tbody id="nodes-list1">
					        <c:forEach items="${result.wifi}" var="wifi">
								<tr>
									<td>${wifi.mac }</td>
									<td><a href="javascript:;"
										onclick="nodeRename('${pageContext.request.contextPath }/nodeRenameFromServlet', ${wifi.id})"><span><font color="#009688">${wifi.nodeName }</font></span></a></td>
									<td>${wifi.online == true ? "在线" : "离线" }</td>
									<td>${wifi.lux } Lux</td>
									<td>
										<a href="javascript:;" class="layui-btn layui-btn-xs" onclick="luxDimNode('${pageContext.request.contextPath }/nodeDimLuxFromServlet', ${wifi.id})">调光</a></td>
								</tr>
							</c:forEach>  
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>	
	 			
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/welcome.js"></script>
	<script type="text/javascript">
		layui.use(['element','slider','layer'], function(){
			  var element = layui.element;
			  var slider = layui.slider;
			  var layer = layui.layer;
			  //1.监听Tab选项卡
			  var layid = location.hash.replace(/^#TabBrief=/, ''); //.获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
			  element.tabChange('TabBrief', layid); //.切换到lay-id对应的tab选项
			  element.on('tab(TabBrief)', function(){  //.监听Tab切换，以改变地址hash值
			    location.hash = 'TabBrief='+ this.getAttribute('lay-id');
			  });
			  //2.调色滑块的使用
			  slider.render({
			    elem: '#ledDriverSlide'
			  });
			
			});
		
		/*
		*注意：
		*页面刷新，指定2分钟刷新一次；
		*由于welcome页面操作时会刷新数据；故此自动刷新函数主要是对节点的在线状态进行实时刷新；
		*故不需要刷新太频繁，在此将刷新时间设置为2分钟
		*/
		window.onload = function() {
			setTimeout(function(){
				location.reload()
				},1000*60*2);  
		}
		
		
		
	</script>
</body>
</html>