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
		/*var datetimepickerstartfrom = $('#datetimepickerstartfrom').val();
		var datetimepickerstartto = $('#datetimepickerstartto').val();*/
		$('#content').load(
				'filter/thirdparty/cabinethire/home?page=0&code='
						+ code + '&cabinetdetailid=' + cabinetdetailid
						+ '&username=' + username + '&companyname='
						+ companyname + '&projectid=' + projectid
						);
	}

}
function resetRecord(hireId){
	var code = $('#code').val();
	var cabinetdetailid = $('#cabinetdetailid').val();
	var companyname = $('#companyname').val();
	var username = $('#username').val();
	var projectid = $('#projectid').val();
	var conf=confirm("重置前请确认储物柜中物品已清空");
	if(conf){
	$.ajax({
		url : 'filter/thirdparty/cabinethire/resetRecord',
		type : 'POST',
		data : {
			'hireId' : hireId
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data.message == "success") {
				alert("重置成功！");
				$('#content').load(
						'filter/thirdparty/cabinethire/home?page=0&code='
								+ code + '&cabinetdetailid=' + cabinetdetailid
								+ '&username=' + username + '&companyname='
								+ companyname + '&projectid=' + projectid
								);
			}
			}
	});
}
}