$(function(){
	$('.updateScene').click(function(){
		$("#addSdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:355,resizable:false,
			close:function(){
				$('#addSdialog').dialog('destroy');
			}});
		$('#imgspan').hide();
		$('#sceneName').val($(this).attr('sname'));
		$('#sceneid').val($(this).attr('data-id'));
	});
	
	
	
	
});