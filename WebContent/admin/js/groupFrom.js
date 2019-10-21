/**
 * 添加镇流器分组
 * @param url
 * @param userid
 * @returns
 */
function addBalletGroup(url,userid){
			layui.use('layer', function() {
				var layer = layui.layer;
				layer.open({
					area : [ '300px', '200px' ],
					offset:['0px','400px'],
					btnAlign : 'c',
					resize : false,
					content : url + "?userid=" + userid,
					closeBtn : 1,
					type : 2,
					cancel : function() {
						location.reload();
					}
				});
			});
		}

/**
 * 添加led分组
 * @param url
 * @param userid
 * @returns
 */

function addLedGroup(url,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','400px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				location.reload();
				
			}
		});
	});
}
/**
 * 添加wifi无线调光器分组
 * @param url
 * @param userid
 * @returns
 */
function addWifiGroup(url,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','400px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				location.reload();
			}
		});
	});
}

/**
 *添加镇流器到镇流器分组
 * @param url
 * @param groupid
 * @returns
 */
function addBallestToBallestGroup(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '300px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				location.reload();
			}
		});
	});
}

/**
 * 添加led节点至到led分组
 * @param groupid
 * @param userid
 * @returns
 */
function addLedToLedGroup(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '300px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				location.reload();
			}
		});
	});
}
/**
 * 添加wifi节点至wifi分组
 * @param groupid
 * @param userid
 * @returns
 */
function addWifiToWifiGroup(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '400px', '300px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				location.reload();
			}
		});
	});
}
/**
 * 删除分组
 * @param url
 * @param groupid
 * @returns
 */
function deleteGroup(url,groupid){
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 $.ajax({
				  type:"post",
		          url:url,
		          data:{
		            groupid:groupid
		          },
		          async : true,
		          datatype: "String",
		          success:function(datasource, textStatus, jqXHR) {
		        	  layer.msg(datasource,function(){
		        		  location.reload();
		        	  });
		          },
		          error: function() {  
		          	  layer.msg("删除失败!");	
		          	}
		  		});	
		});
}

/**
 * 分组重命名
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupRename(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				location.reload();
			}
		});
	});
}
/**
 * 分组广播控制：开、关、调光
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupSwitchOnNode(url,groupid,userid){
	var switcher = "on";
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 $.ajax({
				  type:"post",
		          url:url,
		          data:{
		        	  userid:userid,
			          groupid:groupid,
			          switcher:switcher
		          },
		          async : true,
		          datatype: "String",
		          success:function(datasource, textStatus, jqXHR) {
		        	  layer.msg(datasource,function(){
		        		//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
		        		  location.reload();
			        	});	
		          },
		          error: function() {  
		          	layer.msg("提交失败!");	
		          	}
		  		});	
		});
}
function groupSwitchOffNode(url,groupid,userid){
	var switcher = "off";
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 $.ajax({
				  type:"post",
		          url:url,
		          data:{
		            userid:userid,
		            groupid:groupid,
		            switcher:switcher
		          },
		          async : true,
		          datatype: "String",
		          success:function(datasource, textStatus, jqXHR) {
		        	layer.msg(datasource,function(){
		        		
		        	});	
		        	//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
		        	  location.reload();
		          },
		          error: function() {  
		          	layer.msg("提交失败!");	
		          	}
		  		});	
		});
}

function groupDimNode(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
	        	location.reload();
			}
		});
	});
}
/**
 * led分组广播调色
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupToningNode(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '250px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
	        	location.reload();
			}
		});
	});
}

/**
 * 分组控制通过lux调光
 * @param url
 * @param groupid
 * @param userid
 * @returns
 */
function groupDimByLux(url,groupid,userid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '250px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?groupid=" + groupid + "&userid=" + userid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				//注意：由于对在分组内进行分组的广播控制，节点的参数变化并没有在分组表格内显示，故在此处不进行重载刷新
	        	location.reload();
			}
		});
	});
}


/****************************************分组内节点表格的函数***************************/

/**
 * 将节点从镇流器分组内移除
 * @param url
 * @param nodeName
 * @param nodeid
 * @param userid
 * @returns
 */
function removeNodeFromBallastGroup(url,groupid,nodeid,userid){
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 layer.confirm("确定将节点从分组内移除？"
		  	   ,{ 
		  		offset:['0px','350px'],
		      	btn: ['确定','取消'],
	        	btn1: function(){
	        		$.ajax({
	      			  type:"post",
	      			  url:url, //注意：三种类型的节点从分组内删除节点都是同一个servlet
	      			  data:{
	      				  nodeid:nodeid,
	      				  userid:userid,
	      				  groupid:groupid
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回删除提示
	      				  layer.msg(datasource,function(){
	      					 //删除后刷新
		      				  IntoBallastGroupNodeTable(groupId);
	      				  });	
	      				 
	      			  },
	      			  error: function() {  
	      				  layer.msg("提交失败!");	
	      	      		}
	        		});	
	        	
	        	}
		  	  ,btn2: function(){
		  		   //取消按钮取消删除操作
         }
 	 });
	});
}

/**
 * 将节点led分组内移除
 * @param url
 * @param nodeName
 * @param nodeid
 * @param userid
 * @returns
 */
function removeNodeFromLedGroup(url,groupid,nodeid,userid){
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 layer.confirm("确定将节点从分组内移除？"
		  	   ,{ 
		  		offset:['0px','350px'],
		      	btn: ['确定','取消'],
	        	btn1: function(){
	        		$.ajax({
	      			  type:"post",
	      			  url:url, //注意：三种类型的节点从分组内删除节点都是同一个servlet
	      			  data:{
	      				  nodeid:nodeid,
	      				  userid:userid,
	      				  groupid:groupid,
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回删除提示
	      				  layer.msg(datasource,function(){
	      					  IntoLedGroupNodeTable(groupId);//刷新
	      				  });	
	      			  },
	      			  error: function() {  
	      				  layer.msg("提交失败!");	
	      	      		}
	        		});	
	        	
	        	}
		  	  ,btn2: function(){
		  		   //取消按钮取消删除操作
         }
 	 });
	});
}

/**
 * 将节点wifi分组内移除
 * @param url
 * @param nodeName
 * @param nodeid
 * @param userid
 * @returns
 */
function removeNodeFromWifiGroup(url,groupid,nodeid,userid){
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 layer.confirm("确定将节点从分组内移除？"
		  	   ,{ 
		  		offset:['0px','350px'],
		      	btn: ['确定','取消'],
	        	btn1: function(){
	        		$.ajax({
	      			  type:"post",
	      			  url:url, //注意：三种类型的节点从分组内删除节点都是同一个servlet
	      			  data:{
	      				  nodeid:nodeid,
	      				  userid:userid,
	      				  groupid:groupid,
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回删除提示
	      				  layer.msg(datasource,function(){
	      					  IntoWifiGroupNodeTable(groupId); //刷新
	      				  });	
	      				  
	      			  },
	      			  error: function() {  
	      				  layer.msg("提交失败!");	
	      	      		}
	        		});	
	        	
	        	}
		  	  ,btn2: function(){
		  		   //取消按钮取消删除操作
         }
 	 });
	});
}

/**
 * 分组内节点开灯
 * @param url
 * @param nodeid
 * @returns
 */
function nodeSwitchOn(url,nodeid){
	var switchState = 1;
	layui.use('layer',function(){
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
		 ,layer = layui.layer;
		 $.ajax({
 			  type:"post",
 			  url:url, //注意：三种类型的节点开关灯都是同一个servlet
 			  data:{
 				  nodeid:nodeid,
 				  switchState:switchState,
 			  },
 			  async : true,
 			  datatype: "String",
 			  success:function(datasource, textStatus, jqXHR) {
 				  //返回提示；注意：此处需要刷新组内节点的最新信息
 				  layer.msg(datasource,function(){  		
	 				  if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
 				  });	
 			  },
 			  error: function() {  
 				  layer.msg("提交失败!");	
 	      		}
   		});	
	});
	
}

/**
 * 分组内节点关灯
 * @param url
 * @param nodeid
 * @returns
 */
function nodeSwitchOff(url,nodeid){
	var switchState = 0;
	layui.use('layer',function(){
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
		 ,layer = layui.layer;
		 $.ajax({
 			  type:"post",
 			  url:url, //注意：三种类型的节点开关灯都是同一个servlet
 			  data:{
 				  nodeid:nodeid,
 				  switchState:switchState,
 			  },
 			  async : true,
 			  datatype: "String",
 			  success:function(datasource, textStatus, jqXHR) {
 				  //返回提示；注意：此处需要刷新组内节点的最新信息
 				 layer.msg(datasource,function(){  		
	 				  if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
	 					  IntoBallastGroupNodeTable(groupId);
	 				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
	 					  IntoLedGroupNodeTable(groupId);
	 				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
	 					  IntoWifiGroupNodeTable(groupId);
	 				  }else{
	 					  GroupRefreshAJAXRequest();
	 				  }
				  });	
 				 
 			  },
 			  error: function() {  
 				  layer.msg("提交失败!");	
 	      		}
   		});	
	});
	
}

/**
 * 分组内节点pwm调光弹窗
 * @param url
 * @param nodeid
 * @returns
 */
function nodePwmDim(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '250px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				//注意：此时刷新，返回所有控制组页面	
				 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
					  IntoBallastGroupNodeTable(groupId);
				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
					  IntoLedGroupNodeTable(groupId);
				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
					  IntoWifiGroupNodeTable(groupId);
				  }else{
					  GroupRefreshAJAXRequest();
				  }
			}
		});
	});
}
/**
 * 分组内节点调色
 * @param url
 * @param nodeid
 * @returns
 */
function nodeToning(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '250px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				//注意：此时刷新，返回所有控制组页面	
				 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
					  IntoBallastGroupNodeTable(groupId);
				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
					  IntoLedGroupNodeTable(groupId);
				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
					  IntoWifiGroupNodeTable(groupId);
				  }else{
					  GroupRefreshAJAXRequest();
				  }
			}
		});
	});
}
/**
 * 分组内wifi节点lux调光
 * @param url
 * @param nodeid
 * @returns
 */
function nodeLuxDim(url,nodeid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '250px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?nodeid=" + nodeid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				 //返回提示；注意：此处需要刷新组内节点的最新信息	
				 if(groupType == 1 && groupId != ""){ //当前处于镇流器分组节点页面，刷新
					  IntoBallastGroupNodeTable(groupId);
				  }else if(groupType == 2 && groupId != ""){	//当前处于led分组节点页面，刷新
					  IntoLedGroupNodeTable(groupId);
				  }else if(groupType == 3 && groupId != ""){  //当前处于wifi分组节点页面，刷新
					  IntoWifiGroupNodeTable(groupId);
				  }else{
					  GroupRefreshAJAXRequest();
				  }
			}
		});
	});
}
