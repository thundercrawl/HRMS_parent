$(function(){
	var ai = 0;
	
	$('.reDatetimepicker').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	var adminId = 1;
	
	
	$(".offLine").on('click',function(){
		 var page = $("#page").val();
		 var activityId = $(this).attr('data-activityId');
		 $('#content').load("filter/activity/offLine?page="+page+"&activityId="+activityId)
	})
	
	
	$(".onLine").on('click',function(){
		var num = 0;
		
		var page = $("#page").val();
		var activityId = $(this).attr('data-activityId');
		$.ajax({
			url : "filter/activity/checkStatus",
			type : "POST",
			dataType : "json",
			data : {
				"status" : 2
			},
			async : false,
			success : function(data){
				if(data.status==2){
					num = 1;
					ai = data.activityId;
				}
			}
			
		})
		if(num==0){
		    $('#content').load("filter/activity/onLine?page="+page+"&activityId="+activityId)
		}else{
			$("#open-win").show();
			$("#windowId").val(activityId);
		}
		
	})
	
	
	$(".btn-imsure").on('click',function(){
		var page = $("#page").val();
		var windowId = $("#windowId").val();
		
		$('#content').load("filter/activity/offLine?page="+page+"&activityId="+ai)
	    $('#content').load("filter/activity/onLine?page="+page+"&activityId="+windowId)
	    $("#open-win").hide();
	})
	
	$(".btn-imcancer").on('click',function(){
		$("#open-win").hide();
	})
	
	
	$("#return").on('click',function(){
		$('#addActivityDetail').dialog('destroy');
	})
	
	
	$('#formcheck').on('click',function(){
		var activityId = $("#sureActivityId").val();
		var activityName = $("#activityName").val();
		var activityDesc = $("#activityDesc").val();
		var strategyType = $("#strategyType").val();
		var strategyConfig = $("#strategyConfig").val();
		var page = $("#page").val();
		var nameflag = 1;
		if(activityName==""){
			$('#activityNameErr').style = "18px";
			$('#activityNameErr').html('X');
			$('#activityNameErr').css("color","red");
			nameflag = 1;
		}else{
			$('#activityNameErr').style = "18px";
			$('#activityNameErr').html('√');
			$('#activityNameErr').css("color","green");
			nameflag = 0;
		}
		var descflag = 0;
		if(activityDesc==""){
			$('#activityDescErr').style = "18px";
			$('#activityDescErr').html('X');
			$('#activityDescErr').css("color","red");
			descflag = 1
		}else{
			$('#activityDescErr').style = "18px";
			$('#activityDescErr').html('√');
			$('#activityDescErr').css("color","green");
			descflag = 0;
		}
		var configflag = 0;
		if(strategyConfig==""){
			$('#strategyConfigErr').style = "18px";
			$('#strategyConfigErr').html('X');
			$('#strategyConfigErr').css("color","red");
			configflag = 1;
		}else{
			$('#strategyConfigErr').style = "18px";
			$('#strategyConfigErr').html('√');
			$('#strategyConfigErr').css("color","green");
			configflag = 0 ;
		}
		if(nameflag==0&&descflag==0&&configflag==0&&activityId==0){
			$('#content').load("filter/activity/addActivity?page="+page+"&activityName="+activityName+"&activityDesc="+activityDesc+"&strategyType="+strategyType+"&strategyConfig="+strategyConfig+"&adminId="+adminId)
			$('#addActivityDetail').dialog('destroy');
		}
		else if(nameflag==0&&descflag==0&&configflag==0&&activityId!=0){
			$('#content').load("filter/activity/updateActivity?page="+page+"&activityId="+activityId+"&activityName="+activityName+"&activityDesc="+activityDesc+"&strategyType="+strategyType+"&strategyConfig="+strategyConfig+"&adminId="+adminId)
			$('#addActivityDetail').dialog('destroy');
		}
		else{
			alert("请输入合法的数据，感谢您的配合！");
		}
	})
	
	$(".deleteAct").on('click',function(){
		 var page = $("#page").val();
		 var activityId = $(this).attr('data-activityId');
		 $('#content').load("filter/activity/deleteActivity?page="+page+"&activityId="+activityId)
	})
	
	$(".updateAct").on('click',function(){
		var activityId = $(this).attr('data-activityId');
		var activityName = $(this).attr('data-activityName');
		var activityDesc = $(this).attr('data-activityDesc');
		var strategyConfig = $(this).attr('data-strategyConfig');
		$("#sureActivityId").val(activityId);
		$("#activityName").val(activityName);
		$("#activityDesc").val(activityDesc);
		$("#strategyConfig").val(strategyConfig);
		$("#addActivityDetail").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
			close:function(){
				$('#addActivityDetail').dialog('destroy');
			}});
	})
	
	$(".details").on('click',function(){
		
		var activityId = $(this).attr('data-activityId');
		$("#content").load("filter/activity/showSignInfo?activityId="+activityId)
	})
	
	
})