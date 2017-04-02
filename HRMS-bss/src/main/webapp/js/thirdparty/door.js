/*------------------------添加门弹窗------------------------*/
$('#adddoor').on('click', function() {
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
/*-----------------------确认添加-------------------------*/
function suredoor() {debugger
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	var doornumber = $('#adddoornumber').val();
	var devicesysid = $('#adddevicesysid').val();
	var doorname = $('#adddoorname').val();
	var projectid = $('#addprojectid').val();
	var floor = $('#addfloor').val();
	var bluetooth = $('#addbluetooth').val();
	var exp = /^\d+$/;
	if (doornumber == null || doornumber == '' || devicesysid == null
			|| devicesysid == '' || doorname == null || doorname == ""
			|| projectid == null || projectid == "" || floor == null
			|| floor == "" || bluetooth == null || bluetooth == "") {
		$('#addspan').html("请输入完整信息");
	} else if (!exp.test(floor) || !exp.test(devicesysid)) {
		$('#addspan').html("请输入正确信息");
	} else {
		$('#alert').dialog('destroy');
		$('#adddoornumber').val("");
		$('#adddevicesysid').val("");
		$('#adddoorname').val("");
		$('#addfloor').val("");
		$('#addbluetooth').val("");
		$('#content').load(
				'filter/thirdparty/door/adddoor?' + url + '&page=' + page
						+ '&adddoornumber=' + doornumber + '&adddevicesysid='
						+ devicesysid + '&adddoorname=' + doorname
						+ '&addprojectid=' + projectid + "&addfloor=" + floor
						+ "&addbluetooth=" + bluetooth);
	}

}
/*------------------------关闭弹窗------------------------*/
function cancledoor() {
	$('#alert').dialog('destroy');
}
/*------------------------修改弹窗------------------------*/
function editdoor(doorId, doorNumber, doorName,  projectId, projectName, floorInfo, bluetoothCode) {
	$('#editdoornumber').val(doorNumber);
	$('#editdoorid').val(doorId);
	/*$('#showdevicesysid').val(deviceSysId);
	$('#showdevicesysid').html(stationName);*/
	$('#editdoorname').val(doorName);
	$('#showprojectid').val(projectId);
	$('#showprojectid').html(projectName);
	$('#editfloor').val(floorInfo);
	$('#editbluetooth').val(bluetoothCode);
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
/*--------------------------确认修改-----------------------*/
function suredooredit() {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	var doornumber = $('#editdoornumber').val();
	var doorid = $('#editdoorid').val();
	//var devicesysid = $('#editdevicesysid').val();
	var doorname = $('#editdoorname').val();
	var projectid = $('#editprojectid').val();
	var floor = $('#editfloor').val();
	var bluetooth = $('#editbluetooth').val();
	var exp = /^\d+$/;
	if ( doornumber == null || doorname == null
			|| floor == null || bluetooth == null 
			|| doornumber == '' || doorname == '' || floor == ''
			|| bluetooth == '') {
		$('#editspan').html("请输入完整信息");
	} else if (!exp.test(floor)) {
		$('#editspan').html("请输入正确信息");
	} else {
		$('#alertedit').dialog('destroy');
		$('#content').load(
				'filter/thirdparty/door/editdoor?' + url + '&page=' + page
						+ '&editdoornumber=' + doornumber + '&editdoorid='
						+ doorid 
						+ '&editdoorname=' + doorname + "&editprojectid="
						+ projectid + "&editfloor=" + floor + "&editbluetooth="
						+ bluetooth);
	}
}
/*------------------------取消修改------------------------*/
function cancledooredit() {
	$('#alertedit').dialog('destroy');
}
/*------------------------查询------------------------*/
function finddoor() {
	debugger
	var doornumber = $('#doornumber').val();
	//var devicesysid = $('#devicesysid').val();
	var projectid = $('#projectid').val();
	$('#content')
			.load(
					'filter/thirdparty/door/home?page=0&doornumber='
							+ doornumber + '&projectid=' + projectid);
}