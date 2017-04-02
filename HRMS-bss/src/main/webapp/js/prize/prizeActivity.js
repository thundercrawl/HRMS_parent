$(function(){
	var adminId = 1;
	
	$('.reDatetimepicker').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	
	showValue = function(temp){
		if(temp==1){
			$("#statusDiv").show();
			$("#nameDiv").show();
			$("#timeStart").show();
			$("#timeEnd").show();
		}
		else{
			$("#statusDiv").hide();
			$("#nameDiv").hide();
			$("#timeStart").hide();
			$("#timeEnd").hide();
		}
	}
	
	
	$(".sureDelivery").on('click',function(){
		var prizeRecordId = $(this).attr("data-prizeRecordId");
		var activityId = $(this).attr("data-activityId");
		alert(activityId)
		alert(prizeRecordId)
		$("#content").load("filter/activity/sureDelivery?adminId="+adminId+"&prizeRecordId="+prizeRecordId+"&activityId="+activityId);
		
	})
	
	$('#backPage').on('click',function(){
		$('#content').load('filter/activity/showActivity');
	});
	
	
})