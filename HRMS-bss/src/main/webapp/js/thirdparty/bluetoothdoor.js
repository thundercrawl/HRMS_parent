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

	var doorName = $('#doorName').val().trim();
	var userName = $('#userName').val().trim();
	userName = userName.replace(" ","+");
	var userPhone = $('#userPhone').val().trim();
	var companyName = $('#companyName').val().trim();
	var startTime = $('#startTime').val().trim();
	startTime = startTime.replace(" ","+");
	var endTime = $('#endTime').val().trim();
	endTime = endTime.replace(" ","+");
	var projectId = $('#project').val();
		$('#content').load(
				'filter/thirdparty/bluetoothdoor/home?page=0&doorName=' + doorName
				        + '&userName=' + userName
						+ '&startTime='
						+ encodeURI(startTime) + '&endTime='
						+ encodeURI(endTime)
					    + '&userPhone='+ userPhone + '&projectId=' 
					    + projectId+'&companyName='+companyName);
}
})