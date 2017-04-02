$(function(){
	
$("#addActivity").on('click',function(){
		
		$("#addActivityDetail").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
			close:function(){
				$('#addActivityDetail').dialog('destroy');
			}});
		
		$("#sureActivityId").val(0);
		$("#activityName").val("");
		$("#activityDesc").val("");
		$("#strategyConfig").val("");
		
	})
	
	
	
	 $("#findActivity").on('click',function(){
	  var select = $("#info_status").val();
	  var activityName = $("#findInput").val();
	  var onLineTime = $("#onLineTime").val();
	  var offLineTime = $("#offLineTime").val();
	  if(select==0&&activityName==""&&onLineTime==""&&offLineTime==""){
		  $('#content').load("filter/activity/showActivity")
	  }
	  else{
		  $('#activitytable').load("filter/activity/assignActivity?status="+select+"&activityName="+activityName+"&onLineTime="+onLineTime+"&offLineTime="+offLineTime)
	  }
	 
  })
	
	
})