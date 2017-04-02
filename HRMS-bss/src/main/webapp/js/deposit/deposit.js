$(function() {
$('#orderStartTime').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
$('#orderEndTime').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
finddeposit=function() {
	var userName = $('#userName').val().trim();
	userName = userName.replace(" ","+");
	var userPhone = $('#userPhone').val().trim();
	var companyName = $('#companyName').val().trim();
	var orderNo = $('#orderNo').val();
	var salerName = $('#salerName').val();
	var orderStartTime = $('#orderStartTime').val().trim();
	orderStartTime = orderStartTime.replace(" ","+");
	var orderEndTime = $('#orderEndTime').val().trim();
	orderEndTime = orderEndTime.replace(" ","+");
	var status = $('#status').val();
		$('#content').load(
				'filter/deposit/home?userName=' + userName
						+ '&orderStartTime='+ encodeURI(orderStartTime) + '&orderEndTime='
						+ encodeURI(orderEndTime)+ '&userPhone='+ userPhone 
						+'&companyName='+companyName+'&orderNo='+orderNo
						+'&salerName='+salerName+'&status='+status);
}
})