/*------------------------日期------------------------*/
$('#datetimepickerfrom').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
$('#datetimepickerto').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d H:i:s',
	formatDate: 'Y-m-d H:i:s',
});
$('#datetimepickercreate').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
/*------------------------查询------------------------*/
function finddoorcard() {
	var orderid = orderid = $('#orderid').val();
	var cardnumber = $('#cardnumber').val();
	var doorid = $('#doorid').val();
	var datetimepickerfrom = $('#datetimepickerfrom').val();
	var datetimepickerto = $('#datetimepickerto').val();
	var datetimepickercreate = $('#datetimepickercreate').val();
	var companyid = $('#companyid').val();
	var status = $('#status').val();
	var exp = /^\d+$/;
	if (orderid != null && orderid != '' && !exp.test(orderid)) {
		alert("请输入正确订单编号");
	} else {
		$('#content').load(
				'filter/thirdparty/doorcard/home?page=0&orderid=' + orderid
						+ '&cardnumber=' + cardnumber + '&doorid=' + doorid
						+ '&datetimepickerfrom='
						+ encodeURI(datetimepickerfrom) + '&datetimepickerto='
						+ encodeURI(datetimepickerto)
						+ '&datetimepickercreate='
						+ encodeURI(datetimepickercreate) + '&companyid='
						+ companyid + '&status=' + status);
	}
}
/*------------------------挂失------------------------*/
function editlose(doorCardId) {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	$('#content').load(
			'filter/thirdparty/doorcard/editlose?' + url + '&page=' + page
					+ '&doorCardId=' + doorCardId);
}
/*------------------------销户------------------------*/
function editdestroy(doorCardId) {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	if (window.confirm("确定销户吗？")) {
		$('#content').load(
				'filter/thirdparty/doorcard/editdestroy?' + url + '&page='
						+ page + '&doorCardId=' + doorCardId);
	}
}
/*------------------------授权------------------------*/
function editpermission(doorCardId) {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	$.ajax({
		url : 'filter/thirdparty/doorcard/editpermission',
		type : 'POST',
		data : {
			'doorCardId' : doorCardId
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data.message == "1") {
				$('#content').load(
						'filter/thirdparty/doorcard/home?' + url + '&page='
								+ page);
			} else if (data.message == "2") {
				alert("授权人数已满");
			} else if (data.message == "3") {
				alert("授权失败");
			}
		}
	});
}
