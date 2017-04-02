/*------------------------日期------------------------*/
$('#datetimepickerstartto').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
$('#datetimepickerstartfrom').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
/*------------------------查询------------------------*/
function findcabinetshire() {
	var code = $('#code').val();
	var cabinetdetailid = $('#cabinetdetailid').val();
	var companyname = $('#companyname').val();
	var username = $('#username').val();
	var projectid = $('#projectid').val();
	var exp = /^\d+$/;
	 if (cabinetdetailid != null && cabinetdetailid != ''
			&& !exp.test(cabinetdetailid)) {
		alert("小储物柜编号必须为数字");
	} else {
		var datetimepickerstartfrom = $('#datetimepickerstartfrom').val();
		var datetimepickerstartto = $('#datetimepickerstartto').val();
		$('#content').load(
				'filter/thirdparty/cabinethirehis/home?page=0&code='
						+ code + '&cabinetdetailid=' + cabinetdetailid
						+ '&username=' + username + '&companyname='
						+ companyname + '&projectid=' + projectid
						+ '&fromstarttime='
						+ encodeURI(datetimepickerstartfrom) + '&tostarttime='
						+ encodeURI(datetimepickerstartto));
	}

}