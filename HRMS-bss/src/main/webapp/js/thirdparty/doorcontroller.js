/*------------------------全选/全不选------------------------*/
function checkAll(obj) {
	var curCheckBox = document.getElementsByName("promotions");
	for (var i = 0; i < curCheckBox.length; i++) {
		curCheckBox.item(i).checked = obj.checked;
	}
}
/*------------------------添加弹窗------------------------*/
$('#adddoorcontroller').on('click', function() {
	$("#alert").dialog({
		modal : true,
		autoOpen : true,
		height : 'auto',
		width : 360,
		resizable : false,
		close : function() {
			$('#alert').dialog('destroy');
		}
	});
});
/*------------------------取消添加------------------------*/
function cancledoorcontroller() {
	$('#alert').dialog('destroy');
}
/*------------------------确认添加------------------------*/
function suredoorcontroller() {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	var doorcontrollername = $('#adddoorcontrollername').val();
	var ip = $('#addip').val();
	var type = $('#addtype').val();
	var status = $('#addstatus').val();
	var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if (doorcontrollername == null || doorcontrollername == '' || ip == null
			|| ip == '' || type == null || type == '' || status == null
			|| status == '') {
		$('#addspan').html("请输入完整信息");
	} else if (!re.test(ip)) {
		$('#addspan').html("请输入正确的IP地址");
	} else {
		$.ajax({
			url : 'filter/thirdparty/doorcontroller/adddoorcontroller',
			type : 'POST',
			data : {
				'adddoorcontrollername' : doorcontrollername,
				'addip' : ip,
				'addtype' : type,
				'addstatus' : status
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == "1") {
					$('#alert').dialog('destroy');
					$('#adddoorcontrollername').val('');
					$('#addip').val('');
					$('#content').load(
							'filter/thirdparty/doorcontroller/home?' + url
									+ '&page=' + page);
				} else if (data.message == "2") {
					$('#addspan').html("该IP地址已存在");
				} else if (data.message == "3")
					$('#addspan').html("操作失败");
			}
		});
	}
}
/*------------------------修改弹窗------------------------*/
function editdoorcontroller(deviceSysId, stationName, stationIp, appType,
		status) {
	$('#editspan').html("");
	$('#editdevicesysid').val(deviceSysId);
	$('#editdoorcontrollername').val(stationName);
	$('#editip').val(stationIp);
	$('#oldip').val(stationIp);
	$('#edittype').val(appType);
	$('#editstatus').val(status);
	$("#alertedit").dialog({
		modal : true,
		autoOpen : true,
		height : 'auto',
		width : 360,
		resizable : false,
		close : function() {
			$('#alertedit').dialog('destroy');
		}
	});

}
/*------------------------取消修改------------------------*/
function cancleeditdoorcontroller() {
	$('#alertedit').dialog('destroy');
}
function sureeditdoorcontroller() {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	var id = $('#editdevicesysid').val();
	var name = $('#editdoorcontrollername').val();
	var ip = $('#editip').val();
	var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if (name == null || name == '' || ip == null || ip == '') {
		$('#editspan').html("请输入完整信息");
	} else if (!re.test(ip)) {
		$('#editspan').html("请输入正确IP地址");
	} else {
		$.ajax({
			url : 'filter/thirdparty/doorcontroller/editdoorcontroller',
			type : 'POST',
			data : {
				'editdevicesysid' : id,
				'editdoorcontrollername' : name,
				'editip' : ip
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == "1") {
					$('#alertedit').dialog('destroy');
					$('#content').load(
							'filter/thirdparty/doorcontroller/home?' + url
									+ '&page=' + page);
				} else if (data.message == "2") {
					$('#editspan').html("该IP地址已存在");
				} else if (data.message == "3") {
					$('#editspan').html("操作失败");
				}
			}
		});
	}
}
/*------------------------查询------------------------*/
function finddoorcontroller() {
	var devicesysid = $('#devicesysid').val();
	var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	var ip = $('#ip').val();
	if (ip != null && ip != "") {
		if (!re.test(ip)) {
			alert("请输入正确的IP地址");
			return;
		}
	}
	$('#content').load(
			'filter/thirdparty/doorcontroller/home?page=0&devicesysid='
					+ devicesysid + '&ip=' + ip);

}