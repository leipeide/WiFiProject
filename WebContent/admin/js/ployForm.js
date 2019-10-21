/**
 * 新建led策略弹窗
 * led、镇流器、wifi弹窗函数不一样，公用一个jsp、servlet
 * @param url
 * @param userid
 * @returns
 */
function newLedPloy(url,userid){
	var groupType = 2;
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '350px', '300px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&groupType=" + groupType,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				// 右上角关闭回调
				location.reload();
			}
		});
	});
}

/**
 * 策略重命名
 * @param url
 * @param userid
 * @param ployid
 * @returns
 */
function ployRename(url,userid,ployid){
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			area : [ '300px', '200px' ],
			offset:['0px','350px'],
			btnAlign : 'c',
			resize : false,
			content : url + "?userid=" + userid + "&ployid=" + ployid,
			closeBtn : 1,
			type : 2,
			cancel : function() {
				// 右上角关闭回调
				location.reload();
			}
		});
	});
}
/**
 * 添加策略操作弹窗
 * @param url
 * @param userid
 * @param ployid
 * @returns
 */
function addOperate(url,userid,ployid,runState){
	layui.use('layer', function() {
		var layer = layui.layer;
		if(runState == 1){
			layer.alert("策略正在执行，无法执行!",{
				offset:['0px','400px']
			});//策略执行过程中添加策略操作，避免websocket执行定时操作时出错
		}else if(runState == 0){
			layer.open({
				area : [ '400px', '350px' ],
				offset:['0px','300px'],
				btnAlign : 'c',
				resize : false,
				content : url + "?userid=" + userid + "&ployid=" + ployid,
				closeBtn : 1,
				type : 2,
				cancel : function() {
					// 右上角关闭回调
				}
			});
		}
	
	});
}
/**
 * 查看策略绑定分组的信息
 * @param url
 * @param userid
 * @param groupid
 * @returns
 */
function groupMessage(url,userid,groupid){
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 //1.ajax获取group对象
		 $.ajax({
				  type:"post",
		          url:url,
		          data:{
		        	userid:userid,
		            groupid:groupid
		          },
		          async : true,
		          datatype: "json",
		          success:function(datasource, textStatus, jqXHR) {
		        	  //2.弹窗显示group信息
		              var group = datasource;
		        	  if(group != null){
		        		  var message = "<div style='margin-top:10px;margin-left:25px;padding-buttom:10px'>"+"用户id:" + group.userid + "</br>"+ "分组id："+ group.groupid + "</br>"+ "分组名称：" + group.groupName + "</br>" +"节点数量：" + group.nodeNum  + "</br></div>";
		        		  layer.open({
		        				 area : [ '300px', '200px' ],
		        				 offset:['0px','400px'],
		        				 btnAlign : 'l',
		        				 resize : false,
		        				 closeBtn : 1,
		        				 type : 1,
		        				 content : message,
		        				 cancel : function(){
		        				 }
		        			 });
		        		  
		        	  }else{
		        		  layer.msg("未查询到信息!");	
		        	  }
		        	  
		          },
		          error: function() {  
		          	  layer.msg("查询出错了!");	
		          	}
		  		});	
		});
}
/**
 * 删除策略
 * @param url
 * @param userid
 * @param ployid
 * @returns
 */
function deletePloy(url,userid,ployid,runState){
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 if(runState == 1){
			 layer.alert("策略正在执行，无法进行删除!",{
				 offset:['0px','400px']
			 });//策略执行过程中删除策略，避免websocket执行定时操作时出错
		 }else{
			 //ajax发送删除指令
			 $.ajax({
				  type:"post",
		          url:url,
		          data:{
		        	userid:userid,
		            ployid:ployid
		          },
		          async : true,
		          datatype: "String",
		          success:function(datasource, textStatus, jqXHR) {
		        	  //返回删除提示
		        	  layer.msg(datasource,function(){
		        		  location.reload();
		        	  });	
		          },
		          error: function() {  
		          	  layer.msg("提交失败!");	
		          	}
		  		});	
		 }
	});
	
}
/**
 * led更改策略的绑定分组；
 * @param url
 * @param ployid
 * @param groupid
 * @returns
 */
function ledPloyChangeGroup(url,userid,ployid,groupid,runState){
	var groupType = 2;
	layui.use('layer', function() {
		var layer = layui.layer;
		if(runState == 1){
			  layer.msg("策略正在执行，请先停止执行!");	
		}else{
			layer.open({
				area : [ '400px', '350px' ],
				offset:['0px','300px'],
				btnAlign : 'c',
				resize : false,
				title: ['策略更改绑定的分组'],
				content : url + "?userid=" + userid + "&ployid=" + ployid + "&groupid=" + groupid +"&groupType=" + groupType,
			//	content : url + "?groupid=" + groupid + "&groupType=" + groupType + "&userid=" + userid + "&ployid=" + ployid,
				closeBtn : 1,
				type : 2,
				cancel : function() {
					// 右上角关闭回调
					 location.reload();
				}
			});
		}
	});
 
}
/**
 * 执行策略
 * @param url
 * @param ployid
 * @param userid
 * @returns
 */
function runPloy(url,ployid,userid){
	//采用ajax
	var runState = 1; //状态为1，正在执行
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		$.ajax({
			  type:"post",
			  url:url,
			  data:{
				  userid:userid,
				  ployid:ployid,
				  runState:runState
			  },
			  async : true,
			  datatype: "String",
			  success:function(datasource, textStatus, jqXHR) {
				  //返回删除提示
				  layer.msg(datasource,function(){
					   location.reload();
				  });	
			  },
			  error: function() {  
	        	  layer.msg("提交失败!");	
	        	}
			});	
	});
}

function stopPloy(url,ployid,userid){
	//采用ajax
	var runState = 0; //状态为0，未执行
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		$.ajax({
			  type:"post",
			  url:url,
			  data:{
				  userid:userid,
				  ployid:ployid,
				  runState:runState
			  },
			  async : true,
			  datatype: "String",
			  success:function(datasource, textStatus, jqXHR) {
				  //返回删除提示
				  layer.msg(datasource,function(){
					   location.reload();
				  });	
			  },
			  error: function() {  
	      	  layer.msg("提交失败!");	
	      	}
		});	
	});	
}

function deletePloyOperate(url,ployid,ployOperateId){
	layui.use('layer', function(){ 
		 var $ = layui.$ //由于layer弹层依赖jQuery，所以可以直接得到
	    ,layer = layui.layer;
		 layer.confirm("确定删除该定时操作吗？"
		  	   ,{ 
		  		offset:['0px','350px'],
		      	btn: ['确定','取消'],
	        	btn1: function(){
	        		$.ajax({
	      			  type:"post",
	      			  url:url,
	      			  data:{
	      				  operateId:ployOperateId
	      			  },
	      			  async : true,
	      			  datatype: "String",
	      			  success:function(datasource, textStatus, jqXHR) {
	      				  //返回删除提示
	      				  layer.msg(datasource,function(){
	      					//删除操作后重新获取策略内定时操作信息，重新操作显示数据到表格上
	      					IntoPloyOperateTable(ployid);
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