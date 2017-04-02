$(function() {
$('#startTime').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
$('#endTime').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
findbluetooth=function() {
	var orderNo =  $('#orderNo').val();
	var doorNumber = $('#doorNumber').val();
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var startTime = $('#startTime').val();
	var endTime = $('#endTime').val();
	var type = $('#type').val();
		$('#content').load(
				'filter/thirdparty/bluetooth/home?page=0&orderNo=' + orderNo
						+ '&doorNumber=' + doorNumber + '&userName=' + userName
						+ '&startTime='
						+ encodeURI(startTime) + '&endTime='
						+ encodeURI(endTime)
					    + '&userPhone='+ userPhone + '&type=' 
					    + type+'&companyName='+companyName);
}
prohibition = function(bid,status) {
	if($('.prohibition-'+bid).val()=="禁用"){
		status=1;
	}else if($('.prohibition-'+bid).val()=="解禁"){
		status=0;
	}
	$.ajax({
		url : 'filter/thirdparty/bluetooth/prohibition',
		type : 'POST',
		data : {
			bid : bid,
			status:status
		},
		cache : false,
		dataType : 'json',
		success : function(data) {
			if(data.message=="解禁"){
				$('.prohibition-'+bid).val("禁用");
				$('.status-'+bid).html("正常");
			}else if(data.message=="禁用"){
				$('.prohibition-'+bid).val("解禁");
				$('.status-'+bid).html("禁用");
			}
		},
		error : function(data) {
		}
	});
}
del = function(bid) {
	var orderNo=$("#orderNo").val();
	var doorNumber=$("#doorNumber").val();
	var userName=$("#userName").val();
	var startTime=$("#startTime").val();
	var endTime=$("#endTime").val();
	var userPhone=$("#userPhone").val();
	var type=$("#type").val();
	var companyName=$("#companyName").val();
	$.ajax({
		url : 'filter/thirdparty/bluetooth/deleteuser',
		type : 'POST',
		data : {
			bid : bid
		},
		cache : false,
		dataType : 'json',
		success : function(data) {alert(data.message)
			if(data.message=="success"){
				alert("删除成功！");
				$('#content').load("filter/thirdparty/bluetooth/home?page=0&orderNo=" + orderNo
						+ '&doorNumber=' + doorNumber + '&userName=' + userName
						+ '&startTime='
						+ encodeURI(startTime) + '&endTime='
						+ encodeURI(endTime)
					    + '&userPhone='+ userPhone + '&type=' 
					    + type+'&companyName='+companyName);
			}
		},
		error : function(data) {
		}
	});
}
})