$("#deletecontracts").click(function(){
	var obj=document.getElementsByName('promotions');
//promotions是checkbox的name属性值
	var checkval=[];
	for(var  k in obj){
		if(obj[k].checked)
			checkval.push(obj[k].value);
	}
	var contracts=checkval.toString();
	if(checkval==null||checkval==""){
		alert("请勾选要删除的合同！");
	}else{
		if(window.confirm("确定删除所选合同？")){
		var page=document.getElementById("page").value;
		var url=document.getElementById("huan").value;
		$('#content').load("filter/sys/contract/deletecontract?"+url+"&page="+page+"&contracts="+contracts);
		}}
	});