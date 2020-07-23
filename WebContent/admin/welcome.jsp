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
/* 重要： layui-layout-body的overflow属性layui框架自带的是hidden; 
   当页面内容超出页面时，内容被修剪，故自己设置overflow属性为auto  */
.layui-layout-body{ 
	 overflow:auto; 
  }
</style> 
</head>
<body class="layui-layout-body">
	<!-- 作为隐藏标签,用于储存语言类型,在项目中传递 -->
	<input type="hidden" id="hiddenLan" value=${i18nLanguage }>
	<div class="layui-tab layui-tab-brief" lay-filter="TabBrief">
		<ul class="layui-tab-title">
			<li class="layui-this" name="LB" lay-id="zhenliuqi"></li>
			<li class="i18n" name="LLD" lay-id="ledDriver"></li>
			<li class="i18n" name="LWWD" lay-id="wifi"></li>
		</ul>
		<div class="layui-tab-content">
			<!-- 1.Tab镇流器区域 -->
			<div class="layui-tab-item layui-show" id="zhenliuqi_table">
				<!-- 为美观，表格风格设置为sm -->
				<table class="layui-table" lay-size="sm">
					<thead>
						<tr>
							<th class="i18n" name="NodeMacAddr"></th>
							<th class="i18n" name="NodeName"></th>
							<th class="i18n" name="NetworkState"></th>
							<th class="i18n" name="SwitchLightStatus"></th>
							<th class="i18n" name="DimPara"></th>
							<th><a href="javascript:;"
								onclick="BroadcastControl('${pageContext.request.contextPath }/broadcastControlFormServlet', ${userid}, 'ballastBC')">
									<font color="#009688" class="i18n" name="BroadcastControl"></font>
							</a></th>
						</tr>
					</thead>
					<tbody id="nodes-list">
						<c:forEach items="${result.ballast }" var="ballast">
							<tr>
								<td>${ballast.mac }</td>
								<td><a href="javascript:;"
									onclick="nodeRename('${pageContext.request.contextPath }/nodeRenameFromServlet', ${ballast.id})">
										<font color="#009688">${ballast.nodeName }</font>
								</a></td>
								<td>${ballast.online == true ? "<font color='#009688'>online</font>" :  "offline" }</td>
								<%-- <td>${ballast.switchState == 0 ? "关灯" : "开灯"}</td> --%>
								<td>${ballast.switchState == 0 ? "<img style='width:25px;height:25px' src='admin/img/dengpaoOFF.png'>" : "<img style='width:25px;height:25px' src='admin/img/dengpaoON.png'>"}</td>
								<td>${ballast.precentage }%</td>
								<td><c:set var="lastOperateType" scope="session" value="${ballast.lastOperateType}" /> 
									<c:if test="${ lastOperateType == 'open'}">
										<div class="layui-btn-container">
											<a href="javascript:;"
												class="layui-btn layui-btn-danger layui-btn-xs"
												onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">
												<span class="i18n" name="Switch-ON"></span>
											</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">
												<span class="i18n" name="Switch-OFF"></span>
											</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${ballast.id })">
												<span class="i18n" name="LDim"></span>
											</a>
										</div>
									</c:if> 
									<c:if test="${ lastOperateType == 'close'}">
										<div class="layui-btn-container">
											<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">
												<span class="i18n" name="Switch-ON"></span>
											</a>
											<a href="javascript:;"
												class="layui-btn layui-btn-danger layui-btn-xs"
												onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">
												<span class="i18n" name="Switch-OFF"></span>
											</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${ballast.id })">
												<span class="i18n" name="LDim"></span>
											</a>
										</div>
									</c:if> 
									<c:if test="${ lastOperateType == null }">
										<div class="layui-btn-container">
											<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">
												<span class="i18n" name="Switch-ON"></span>
											</a>
											<a href="javascript:;" class="layui-btn layui-btn-xs"
												onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${ballast.id })">
												<span class="i18n" name="Switch-OFF"></span>
											</a>
											<a href="javascript:;"
												class="layui-btn layui-btn-xs"
												onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${ballast.id })">
												<span class="i18n" name="LDim"></span>
											</a>
										</div>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 2.led驱动器区域 -->
			<div class="layui-tab-item" id="ledDriver_table">
				<!-- 为美观，表格风格设置为sm -->
				<table class="layui-table" lay-size="sm">
					<thead>
						<tr>
							<th class="i18n" name="NodeMacAddr"></th>
							<th class="i18n" name="NodeName"></th>
							<th class="i18n" name="NetworkState"></th>
							<th class="i18n" name="SwitchLightStatus"></th>
							<th class="i18n" name="DimPara"></th>
							<th class="i18n" name="TonPara"></th>
							<th><a href="javascript:;"
								onclick="BroadcastControl('${pageContext.request.contextPath }/broadcastControlFormServlet', ${userid}, 'ledBC')">
									<font class="i18n" name="BroadcastControl" color="#009688"></font>
							</a></th>
						</tr>
					</thead>
					<tbody id="nodes-list1">
						<c:forEach items="${result.led }" var="led">
							<tr>
								<td>${led.mac }</td>
								<td><a href="javascript:;"
									onclick="nodeRename('${pageContext.request.contextPath }/nodeRenameFromServlet', ${led.id})">
										<font color="#009688">${led.nodeName }</font>
								</a></td>
								<td>${led.online == true ? "<font color='#009688'>online</font>" : "offline" }</td>
								<%-- <td>${led.switchState == 0 ? "关灯" : "开灯"}</td> --%>
								<td>${led.switchState == 0 ? "<img style='width:25px;height:25px' src='admin/img/dengpaoOFF.png'>" : "<img style='width:25px;height:25px' src='admin/img/dengpaoON.png'"}</td>
								<td>${led.precentage }%</td>
								<td>
									<font class="i18n" name="color-red"></font>${led.colorPrecentage }%;
									<font class="i18n" name="color-blue"></font>${100-led.colorPrecentage}%
								</td>
								<td><c:set var="lastOperateType" scope="session" value="${led.lastOperateType}" /> 
									<c:if test="${ lastOperateType == 'open'}">
									<div class="layui-btn-container">
										<a href="javascript:;"
											class="layui-btn layui-btn-danger layui-btn-xs"
											onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">
											<span class="i18n" name="Switch-ON"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">
											<span class="i18n" name="Switch-OFF"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">
											<span class="i18n" name="LDim"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">
											<span class="i18n" name="LToning"></span>
										</a>
										</div>
									</c:if> 
									<c:if test="${ lastOperateType == 'close'}">
									<div class="layui-btn-container">
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">
											<span class="i18n" name="Switch-ON"></span>
										</a>
										<a href="javascript:;"
											class="layui-btn layui-btn-danger layui-btn-xs"
											onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">
											<span class="i18n" name="Switch-OFF"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">
											<span class="i18n" name="LDim"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">
											<span class="i18n" name="LToning"></span>
										</a>
										</div>
									</c:if> 
									<c:if test="${ lastOperateType == null}">
									<div class="layui-btn-container">
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="switchOnNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">
											<span class="i18n" name="Switch-ON"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="switchOffNode('${pageContext.request.contextPath }/switchNodeServlet', ${led.id })">
											<span class="i18n" name="Switch-OFF"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="dimNode('${pageContext.request.contextPath }/dimNodeFromServlet', ${led.id })">
											<span class="i18n" name="LDim"></span>
										</a>
										<a href="javascript:;" class="layui-btn layui-btn-xs"
											onclick="toningNode('${pageContext.request.contextPath }/toningNodeFromServlet', ${led.id })">
											<span class="i18n" name="LToning"></span>
										</a>
										</div>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<%--wifi无线调光器Tab选项区域 --%>
			<div class="layui-tab-item">
				<!-- 为美观，表格风格设置为sm -->
				<table class="layui-table" lay-size="sm">
					<thead>
						<tr>
							<th class="i18n" name="NodeMacAddr"></th>
							<th class="i18n" name="NodeName"></th>
							<th class="i18n" name="NetworkState"></th>
							<th class="i18n" name="DimPara"></th>
							<th class="i18n" name="LightSensorPara"></th>
							<th><a href="javascript:;"
								onclick="BroadcastControl('${pageContext.request.contextPath }/broadcastControlFormServlet', ${userid}, 'wifiBC')">
									<font class="i18n" name="BroadcastControl" color="#009688"></font>
								</a>
							</th>
						</tr>
					</thead>
					<tbody id="nodes-list1">
						<c:forEach items="${result.wifi}" var="wifi">
							<tr>
								<td>${wifi.mac }</td>
								<td><a href="javascript:;"
									onclick="nodeRename('${pageContext.request.contextPath }/nodeRenameFromServlet', ${wifi.id})">
										<font color="#009688">${wifi.nodeName }</font>
								</a></td>
								<td>${wifi.online == true ?  "<font color='#009688'>online</font>" : "offline" }</td>
								<td>${wifi.precentage }%</td>
								<td>${wifi.lux } lux</td>
								<td><div class="layui-btn-group">
									<a href="javascript:;" class="layui-btn layui-btn-xs"
										onclick="luxDimNode('${pageContext.request.contextPath }/nodeDimLuxFromServlet', ${wifi.id})">
										<span class="i18n" name="LDim"></span>
									</a></div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- jquery.min.js与	jquery.i18n.properties.js是i18n国际化需要的插件 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/admin/js/jquery.i18n.properties.js"></script>
	<script type="text/javascript">
		//1.获取id为hiddenLan的value值，i18nLanguage为全局变量，是当前系统的语言环境
		var i18nLanguage = jQuery("#hiddenLan").val(); 
	
		//2.加载layui模块
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
	
		//3.重要：这里需要进行i18n的翻译；进入相应语言环境的语言库，翻译页面
		jQuery.i18n.properties({
		  	 name : 'common', //资源文件名称,本页面只用到common.properties
		  	 path : 'admin/i18n/', //资源文件路径
		  	 mode : 'both', //用Map的方式使用资源文件中的值
		     language : i18nLanguage,
		     callback : function() {//加载成功后设置显示内容
		             // 第一类：layui的i18n
		             var insertEle = jQuery(".i18n"); // 获得所有class为i18n的元素
		             insertEle.each(function() {  // 遍历，根据i18n元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		             // 第二类：layui-this
		             var tabEle = jQuery(".layui-this"); // 获得所有class为layui-this的元素
		             tabEle.each(function() {  // 遍历，根据layui-this元素的 name 获取语言库对应的内容写入
		            	 jQuery(this).html(jQuery.i18n.prop(jQuery(this).attr('name')));
		              });
		     	}
		  });
		
		/*
		*4.注意：
		*页面刷新，指定2分钟刷新一次；
		*由于welcome页面操作时会刷新数据；故此自动刷新函数主要是对节点的在线状态进行实时刷新；
		*故不需要刷新太频繁，在此将刷新时间设置为2分钟
		*/
		window.onload = function() {
			setTimeout(function(){
				location.reload();
				},1000*60*2);  
		}
		
		
		/**
		 * 节点广播控制；三种类型共用一个广播控制函数
		 * @param url
		 * @param userid
		 * @param param:类型参数字符串（ballastBC、ledBC、wifiBC）；
		 * 由于三种节点类型共用一个广播控制函数，为区别是哪一类型进行广播控制，用param字符串进行区分
		 * @returns
		 */
		function BroadcastControl(url,userid,param){
				layer.open({
					area : [ '400px', '300px' ],
					btnAlign : 'c',
					resize : false,
					content : url + "?userid=" + userid + "&typeParam=" + param + "&i18nLanguage=" + i18nLanguage,
					closeBtn : 1,
					type : 2,
					title:jQuery.i18n.prop('CmdToAllNode'),
					cancel : function() {
						// 右上角关闭回调
						location.reload();
					}
				});
		}
		/**
		 * 节点重命名
		 * @param url
		 * @param nodeid
		 * @returns
		 */
		function nodeRename(url, nodeid) {
			layer.open({
				area : [ '300px', '200px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?nodeid=" + nodeid + "&i18nLanguage=" + i18nLanguage,
				closeBtn : 1,
				type : 2,
				title:jQuery.i18n.prop('EnterNewName'),
				cancel : function() {
					// 右上角关闭回调
					location.reload();
				}
			});
		}

		/**
		 * 节点开、关、调光、调色控制
		 * @param url
		 * @param nodeid
		 * @returns
		 */
		function switchOnNode(url,nodeid){
			var switcher = "on";
			jQuery.ajax({
				  type:"post",
		          url:url,
		          data:{
		            nodeid:nodeid,
		            switcher:switcher,
		 
		          },
		          async : true,
		          datatype: "json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  if(datasource == '指令发送成功'){
		        		  layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
			        		  location.reload();
			        	  });
		        	  }else if(datasource == '指令发送失败请检查设备是否已离线'){
		        		  layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){
			        		  location.reload();
			        	  });
		        	  }else if(datasource == '提交失败'){
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

		function switchOffNode(url,nodeid){
			var switcher = "off";
			jQuery.ajax({
				  type:"post",
		          url:url,
		          data:{
		            nodeid:nodeid,
		            switcher:switcher,
		          },
		          async : true,
		          datatype: "json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  if(datasource == '指令发送成功'){
		        		  layer.msg(jQuery.i18n.prop('cmdSendSuccess'),function(){
			        		  location.reload();
			        	  });
		        	  }else if(datasource == '指令发送失败请检查设备是否已离线'){
		        		  layer.msg(jQuery.i18n.prop('TipDevOffline'),function(){
			        		  location.reload();
			        	  });
		        	  }else if(datasource == '提交失败'){
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

		function dimNode(url,nodeid){
			layer.open({
				area : [ '350px', '250px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?nodeid=" + nodeid + "&i18nLanguage=" + i18nLanguage,
				closeBtn : 1,
				type : 2,
				title:jQuery.i18n.prop('SetWindowTitle'),
				cancel : function() {
					// 右上角关闭回调
					location.reload();
				}
			});
		}
		function toningNode(url,nodeid){
			layer.open({
				area : [ '350px', '300px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?nodeid=" + nodeid + "&i18nLanguage=" + i18nLanguage,
				closeBtn : 1,
				type : 2,
				title:jQuery.i18n.prop('SetWindowTitle'),
				cancel : function() {
					// 右上角关闭回调
					location.reload();
					// return false 开启该代码可禁止点击该按钮关闭
				}
			});
		}
		/**
		 * wifi勒克斯调光
		 * @param url
		 * @param nodeid
		 * @returns
		 */
		function luxDimNode(url,nodeid){
			layer.open({
				area : [ '400px', '280px' ],
				btnAlign : 'c',
				resize : false,
				content : url + "?nodeid=" + nodeid + "&i18nLanguage=" + i18nLanguage,
				closeBtn : 1,
				type : 2,
				title:jQuery.i18n.prop('SetWindowTitle'),
				cancel : function() {
					//1.右上角关闭回调
					location.reload();
				}
			});
		}
	
		/**
		 * 注意：页面的分页功能暂时没有
		 *下一页按钮禁用、开启使用
		 * @param currPage
		 * @param totalPage
		 * @returns
		 */
/*		function  nextPage(currPage,totalPage){
			if(totalPage == 0 || totalPage == currPage){
				document.getElementById("pageBt").disabled=true;
			}else{
				document.getElementById("pageBt").disabled=false;
			}
		}
*/
	</script>
</body>
</html>