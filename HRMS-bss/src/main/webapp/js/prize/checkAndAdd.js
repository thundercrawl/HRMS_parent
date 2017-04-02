$(function(){
	

	$("#findActivity").on('click',function(){
		var personName = $("#personName").val();
		var prizeStatus = $("#prizeStatus").val();
		var sendStatus = $("#sendStatus").val();
		var sendName = $("#sendName").val();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		var sendStartTime = $("#sendStartTime").val();
		var sendEndTime = $("#sendEndTime").val();
		var activityId = $("#activityId").val();
		if(personName==""&&prizeStatus==0&&startTime==""&&endTime==""){
			  $('#content').load("filter/activity/showSignInfo?activityId="+activityId)
		  }
		  else if(prizeStatus==2){
			  sendStatus = 0;
			  sendName = "";
			  sendStartTime = "";
			  sendEndTime = "";
			  $('#persontable').load("filter/activity/assignPerson?personName="+personName+
			  		"&prizeStatus="+prizeStatus+"&sendStatus="+sendStatus+"&sendName="+sendName+
			  		"&startTime="+startTime+"&endTime="+endTime+"&sendStartTime="+sendStartTime+
			  		"&sendEndTime="+sendEndTime+"&activityId="+activityId)
		  }
		  else{
			  $('#persontable').load("filter/activity/assignPerson?personName="+personName+
				  		"&prizeStatus="+prizeStatus+"&sendStatus="+sendStatus+"&sendName="+sendName+
				  		"&startTime="+startTime+"&endTime="+endTime+"&sendStartTime="+sendStartTime+
				  		"&sendEndTime="+sendEndTime+"&activityId="+activityId)
		  }
		
		
	})
	
	
})