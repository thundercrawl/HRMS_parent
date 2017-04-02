$(function() {
		
	$('#submitTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('#endTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});

function findSuggestions() {
	var userId=document.getElementById("userId").value;
	var companyId=document.getElementById("companyId").value;
	var submitTime=document.getElementById("submitTime").value;
	var endTime=document.getElementById("endTime").value;
	var complainType=document.getElementById("complainType").value;
	var complainTypeSub=document.getElementById("complainTypeSub").value;
	var status=document.getElementById("status").value;
	if(status==0&&complainType==0&&complainTypeSub==0){
		$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
				"&complainType="+""+"&complainTypeSub="+""+"&submitTime="+submitTime+
				"&endTime="+endTime+"&status="+"");	
	}else if(status==0&&complainType!=0&&complainTypeSub==0){
		$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
				"&complainType="+complainType+"&complainTypeSub="+""+"&submitTime="+submitTime+
				"&endTime="+endTime+"&status="+"");	
	}else if(status==0&&complainType==0&&complainTypeSub!=0){
		$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
				"&complainType="+""+"&complainTypeSub="+complainTypeSub+"&submitTime="+submitTime+
				"&endTime="+endTime+"&status="+"");	
	}else if(status!=0&&complainType==0&&complainTypeSub==0){
		$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
				"&complainType="+""+"&complainTypeSub="+""+"&submitTime="+submitTime+
				"&endTime="+endTime+"&status="+status);	
	}else if(status!=0&&complainType!=0&&complainTypeSub==0){
		$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
				"&complainType="+complainType+"&complainTypeSub="+""+"&submitTime="+submitTime+
				"&endTime="+endTime+"&status="+status);	
	}else if(status!=0&&complainType==0&&complainTypeSub!=0){
		$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
				"&complainType="+""+"&complainTypeSub="+complainTypeSub+"&submitTime="+submitTime+
				"&endTime="+endTime+"&status="+status);	
	}else if(status==0&&complainType!=0&&complainTypeSub!=0){
		$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
				"&complainType="+complainType+"&complainTypeSub="+complainTypeSub+"&submitTime="+submitTime+
				"&endTime="+endTime+"&status="+"");	
	}
	else{
	$('#content').load("filter/complaintAndSuggestions/home?userId="+userId+"&companyId="+companyId+
			"&complainType="+complainType+"&complainTypeSub="+complainTypeSub+"&submitTime="+submitTime+
			"&endTime="+endTime+"&status="+status);	
	}
}

function updateSuggestions(sugid){
	var flag = window.confirm("确认更改为处理中？");
	if(flag){
	var complainId = sugid;	
	$.ajax({
		type : 'POST',
		url :"filter/complaintAndSuggestions/updateSuggestions",
		data : {
			complainId : sugid
		},
		dataType : 'json',
		async : false,
		success : function(data) {
			$("#a"+sugid).text("2");
			$("#c"+sugid).html("<a href='javaScript:void(0);' class='btn btn-info btn-xs edit updatePro' name='"+sugid+"' id='"+sugid+"' value='处理中'  onclick='updateSuggestions2(this.id);'>处理中</a>");
		},
		error : function(){
			alert("cuotu");
		}
		});
	}
}

function updateSuggestions2(sugid2){
	var flag = window.confirm("确认更改为已处理？");
	if(flag){
	$.ajax({
		type : 'POST',
		url :"filter/complaintAndSuggestions/updateSuggestions2",
		data : {
			complainId : sugid2
		},
		dataType : 'json',
		async : false,
		success : function(data) {
			$("#a"+sugid2).text("3");
			$("#b1"+sugid2).remove();
			$("#botton2").remove();
			$("#c"+sugid2).text("已处理");
		},
		error : function(){
			alert("cuotu");
		}
		});
	}
}
