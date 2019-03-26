layui.use('form', function(){
	var form = layui.form;
	form.on('checkbox(allChoose)', function(data) {
			ckAll();
			//有些表单元素动态插入,这时 form 模块 的自动化渲染是会对其失效的,需要更新渲染，很重要
			form.render();
	});
});

function ckAll(){
	var checked = document.getElementById("allCheckbox").checked;
	var oneCheck = document.getElementsByClassName("check");
	var span = document.getElementById("chooseOrCancel");
	if(checked){
		for(var i=0; i< oneCheck.length; i++){
			oneCheck[i].checked=true;
		}
		span.innerHTML="取消全选";
	}else{
		for(var i=0; i< oneCheck.length; i++){
			oneCheck[i].checked=false;
		}
		span.innerHTML="全选";
	}
}
