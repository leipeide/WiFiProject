layui.use('form', function(){
	var form = layui.form;
	form.on('checkbox(allChoose)', function(data) {
			checkOrCancelAll();
			//有些表单元素动态插入,这时 form 模块 的自动化渲染是会对其失效的,需要更新渲染，很重要
			form.render();
			//return false;
	});
});

function checkOrCancelAll(){	
			//1.获取checkbox的元素对象
			var chElt=document.getElementById("chElt");
			//2.获取选中状态
			var checkedElt=chElt.checked;
			//3.若checked=true,将所有的复选框选中,checked=false,将所有的复选框取消
			var allCheck=document.getElementsByClassName("check");
			//4.循环遍历取出每一个复选框中的元素
			var mySpan=document.getElementById("mySpan");
			if(checkedElt){//全选
				for(var i=0;i<allCheck.length;i++) {//设置复选框的选中状态
					allCheck[i].checked=true;
				}
				mySpan.innerHTML="取消全选";
			}else{
				//取消全选
				for(var i=0;i<allCheck.length;i++){
					allCheck[i].checked=false;
				}
				mySpan.innerHTML="全选";
			}
}
