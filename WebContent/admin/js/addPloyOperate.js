//3.控制调光范围
	function checkDim(obj){
		var val = document.getElementById("dimInput").value;
		//0-100的正则表达式
		var reg = new RegExp("^(\\d|[1-9]\\d|100)$");
		if(!reg.test(val)){
			layui.use(['layer'], function(){
				  var layer = layui.layer;
				  layer.msg("请输入0-100以内的整数");
			});
		}else if(val<0){
			obj.value = 0;
		}else if(val>100){
			obj.value = 100;
		}
	}
	
	  //4.提交按钮
	  function submitBtn(url,userid,ployid){
	 		  var hours = document.getElementById("hours").value; // 小时参数
	 		  var minutes = document.getElementById("minutes").value; // 分钟参数
	 		  var startDate = document.getElementById("startDate").value; // 开始时间范围
	 		  var endDate = document.getElementById("endDate").value; // 结束时间范围
	 		  var myselect = document.getElementById("selected"); //获取select DOM对象
	 		  var index = myselect.selectedIndex; //获取被选中的索引
	 		  var selected = myselect.options[index].value; //获取被选中的值
	 		  var functionStr = ""; //功能种类字符串：switch 、 dim、 toning;
	 		  var value = ""; // 功能对应的参数值
	 		  var regDate = new RegExp("^[1-9]\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[0-1])$");
	 		  
	 		  //把字符串格式转换为日期类,用于比较开始日期与结束日期的大小
	 		  var date= new Date();
	 		  var startTime = new Date(Date.parse(startDate));
	 		  var endTime = new Date(Date.parse(endDate));
	 		 
	 		  //判断时间格式
	 		  if(hours > 23 || hours < 0 || hours == ""){
	 			      layer.msg("HH输入框应遵循小时范围应：0-23");
	 			  	  return;
	 	
	 		  }else if(minutes > 59 || minutes < 0 || minutes == ""){
	 			  layer.msg("MM输入框应遵循分钟范围应：0-59");
			  	  return;
	 			  
	 		  }else if(regDate.test(startDate) && regDate.test(endDate) && startDate != "" && endDate != ""){
	 			  layer.msg("日期格式不正确，正确格式为：2019/01/01"); 
			  	  return;
	 			  
	 		  }else if(startTime > endTime){
	 			  layer.msg("日期格式不正确，开始时间范围大于结束时间范围"); 
			  	  return;
	 			  
	 		  }else{
	 			  //参数格式均正常，根据switch赋予功能参数和功能字符串
	 			  switch(selected){
	 		         case "switch":
	 		           //切换至开关灯功能
	 		           	functionStr = "switch";
	 		         	value = document.getElementById("checkInput").checked;
	 		         	//若开关选中了，dom.checked为true;反之为false；
	 		         	//value值为两种状态：true,false;
	 			        break;
	 			     case "dim":
	 		            //切换至调光功能
	 		            functionStr = "dim";
	 		            //value为0-100的整数
	 		         	value = document.getElementById("dimInput").value;
	 		         	if(value==""){
	 		         		layer.msg("未输入调光值!");
	 		         		return;
	 		         	}else{
	 			            break;
	 		         	}
	 			     case "toning":
	 		        	//切换至调色功能
	 		        	functionStr = "toning";
	 		        	//value为0-100的整数
	 		        	if(toningValue != "0"){
	 		        		value = toningValue.substring(0,(toningValue.length)-4);
	 		        	}else{
	 		        		value = toningValue;
	 		        	}
	 		        	break;      
	 		        }
	 			  
	 			  //ajax传参
	 			 layui.use(['layer'], function(){
	 				  var $ = layui.$;
	 				  var layer = layui.layer;
		 			  $.ajax({
		 				  type:"post",
		 		          url:url,
		 		          data:{
		 		        	//参数
		 		        	userid:userid,
		 		            ployid:ployid,
		 		            functionStr:functionStr,
		 		            paramValue:value,
		 		            hours:hours,
		 		            minutes:minutes,
		 		            startDate:startDate,
		 		            endDate:endDate
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
		
	  }  