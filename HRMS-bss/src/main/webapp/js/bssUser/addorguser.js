$(function(){
	$('#backorg').click(function(){
		$('#content').load('filter/bssuser/backorgan?page='+$(this).attr('orgpage')+"&orgname=");
	})
	
	$('#findOrguser').click(function(){
		var username = $('#orguserName').val();
		if(username==""||username=="用户名称"){
			$('#textspan').show();
		}else{
			$('#textspan').hide();
			$('#orgusertable').load('filter/bssuser/findorguser?orgid='+orgid+"&username="+username+"&page=0")
		}
	})
	
	$('#orguserName').focus(function(){
		$('#textspan').hide();
	})
	
	$('#addOrguser').click(function(){
		$("#adduserdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:329,resizable:false,
			close:function(){
				$('#adduserdialog').dialog('destroy');
			}});
		var curCheckBox = document.getElementsByName("usercheck");
		var addidlist = [] ;
		for(var i = 0; i < curCheckBox.length; i++){
			if(curCheckBox.item(i).checked==true){
				addidlist+=curCheckBox.item(i).value+";";
			}
		}
		if(addidlist.length==0){
			alert("请选择成员!")
		}else{
			$('#content').load('filter/bssuser/addorguser?userid='+addidlist+'&orgid='+orgid+'&page='+$('#page').val());
		}
	})
	
	$('#return').click(function(){
		$('#adduserdialog').dialog('destroy');
	})
	
	$('#deleteOrguser').click(function(){
		var curCheckBox = document.getElementsByName("check");
		var idlist = [] ;
		for(var i = 0; i < curCheckBox.length; i++){
			if(curCheckBox.item(i).checked==true){
				idlist+=curCheckBox.item(i).value+";";
			}
		}
		if(idlist.length==0){
			alert("请选择需要删除的成员")
		}else{
			var form = confirm("你确定要删除这些成员!")
			if(form==true){
				$('#content').load('filter/bssuser/deleteorguser?userid='+idlist+'&orgid='+orgid+'&page='+$('#page').val());
			}
		}
	})
})
function check(temp){
	var curCheckBox = document.getElementsByName("check");
	for(var i = 0; i < curCheckBox.length; i++){
		curCheckBox.item(i).checked = temp.checked;
	}
}