var toningValue = 0;
layui.use(['element','slider','form','layer'], function(){
	  var element = layui.element;
	  var slider = layui.slider;
	  var form = layui.form;
	  var layer = layui.layer;
	  //1.调色滑块的使用
	  slider.render({
	    elem: '#colorControlSlide'
	    ,setTips: function(value){ //自定义提示文本
	    	return "红色"+value+"%";
	    	//if(value >=0 && value <=50){
	    	//	return value+"(红色)";
	    	//}else if(value > 50 && value <= 100){
	    	//	return value+"(蓝色)";
	    //	}
	    		
	     }
	    ,change: function(value){
	    	//监听滑块改变的数值，并存入全局变量toningValue中，为调色函数提供调色参数
  	    	toningValue = value;
	     }
	  });
	  
	  //2.监听led全选复选框
	  form.on('checkbox(allChoose)', function(data) {
		  	ckAll();
			//有些表单元素动态插入,这时 form 模块 的自动化渲染是会对其失效的,需要更新渲染，很重要
			form.render();
		}); 
	  
});

/**
 * 全选/取消全选
 * @returns
 */
function ckAll(){
	var checked = document.getElementById("allCheckbox").checked;
	var ledChoose = document.getElementsByName("ledChoose");
	if(checked){
		for(var i=0; i< ledChoose.length; i++){
			ledChoose[i].checked=true;
		}
	}else{
		for(var i=0; i< ledChoose.length; i++){
			ledChoose[i].checked=false;
		}
	}
}

/**
 * led驱动器调色
 * @param value
 * @returns
 */
function submitToning(url){
	var nodesId = [];
	var checkedObj = document.getElementsByName("ledChoose");
	//1.获取选中的复选框value,得到nodeMac数组
	for(var i = 0 ; i < checkedObj.length; i++){
		if(checkedObj[i].checked){
			nodesId.push(checkedObj[i].value);
		}
	}
	//2.获取调色的占空比
	if(toningValue != "0"){
		var tonPercentage = toningValue.substring(0,(toningValue.length)-4);
	}else{
		var tonPercentage = toningValue;
	}
	//3.携带参数至servlet
	if(nodesId.length > 0){
		location.href = url + '?nodesId=' + nodesId + '&tonPercentage=' + tonPercentage;
	}else{
		layer.msg("未选择操作对象！");
	}
	
}