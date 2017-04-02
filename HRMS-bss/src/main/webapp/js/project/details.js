$(function(){
	
var oldFloorMsg = "";
	
$('#backPage').on('click',function(){
	$('#content').load('filter/project/projectPlace');
});

$('#return').on('click',function(){
	$('#addDetaildialog').dialog('destroy');
});

$('#addDetail').on('click',function(){
	$("#addDetaildialog").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
		close:function(){
			$('#addDetaildialog').dialog('destroy');
		}});
	$('#floorMsg').val("");
	$('#floorDescribe').val("");
})



$('#detailConfirm').on('click',function(){
	var projectId = $("#projectId").val();
	var page = $("#page").val();
	var floorMsg = $('#floorMsg').val().replace(/\s/g, "");
	var floorDescribe = $('#floorDescribe').val().replace(/\s/g, "");
	var floorlag = 1;
	if(floorMsg==""){
		$('#floorMsgErr').style = "18px";
		$('#floorMsgErr').html('X');
		$('#floorMsgErr').css("color","red");
		floorlag = 1;
	}else{
		$('#pronamespan').style = "18px";
		$('#pronamespan').html('√');
		$('#pronamespan').css("color","green");
		floorlag = 0;
	}
	var floorDflag = 1;
	if(floorDescribe==""){
		$('#floorDescribeErr').style = "18px";
		$('#floorDescribeErr').html('X');
		$('#floorDescribeErr').css("color","red");
		floorDflag = 1
	}else{
		$('#citynamespan').style = "18px";
		$('#citynamespan').html('√');
		$('#citynamespan').css("color","green");
		floorDflag = 0;
	}
	if(floorlag==0&&floorDflag==0){
		if(oldFloorMsg==""){
			$('#content').load("filter/project/saveOfcProjectFloor?projectId="+projectId+"&floorMsg="+floorMsg+"&floorDescribe="+floorDescribe+"&page="+page);
			$('#addDetaildialog').dialog('destroy');
		}
		else{
			$('#content').load("filter/project/updateOfcProjectFloor?projectId="+projectId+"&floorMsg="+floorMsg+"&floorDescribe="+floorDescribe+"&page="+page+"&oldFloorMsg="+oldFloorMsg)
			oldFloorMsg = "";
			$('#addDetaildialog').dialog('destroy');
		}
	}else{
		alert("请输入合法的数据，感谢您的配合！");
	}
})

$('.updateDetail').on('click',function(){
		$("#addDetaildialog").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
			close:function(){
				$('#addDetaildialog').dialog('destroy');
			}});
		$('#floorMsg').val($(this).attr('data-floorMsg'));
		$('#floorDescribe').val($(this).attr('data-floorDescribe'));
		oldFloorMsg = $(this).attr('data-floorMsg');
	});


$(".deleteDetail").on('click',function(){
	 $('#content').load("filter/project/deleteOfcProjectFloor?projectId="+
			  $(this).attr('data-projectId')+"&floorMsg="+$(this).attr('data-floorMsg')+"&page="+$(this).attr('data-page'));
})


$("#findDetail").on('click',function(){
	var projectId = $("#projectId").val();
	var floorCode = $("#floorCode").val().replace(/\s/g, "");
	if(floorCode=="项目编号"||floorCode==""){
		$('#textspan').show();
	}else{
		$('#content').load('filter/project/showFloor?floorCode='+floorCode+"&page=0&projectId="+projectId);
		$('#textspan').hide();
	}
	
})
})