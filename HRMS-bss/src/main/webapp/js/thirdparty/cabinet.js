/*------------------------弹框------------------------*/
$('#addcabinets').on('click', function() {
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
/*------------------------全选/全不选------------------------*/
function checkAll(obj) {
	var curCheckBox = document.getElementsByName("promotions");
	for (var i = 0; i < curCheckBox.length; i++) {
		curCheckBox.item(i).checked = obj.checked;
	}
}
/*------------------------确认添加------------------------*/
function surecabinets() {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	var count = $('#addcount').val();
	var status = $('#addstatus').val();
	var cabinetlevel = $('#addcabinetlevel').val();
	var areainfo = $('#addareainfo').val();
	var floor = $('#addfloor').val();
	var projectid = $('#addprojectid').val();
	var cabinetname = $('#addcabinetname').val();
	var codeNum = $('#codeNum').val();
	var exp = /^\d+$/;
	if (projectid == null || projectid == '' || cabinetname == null
			|| cabinetname == '' || count == null || count == ''
			|| floor == null || floor == ''||code=='') {
		$('#addspan').html('请输入完整信息');
	} else if (exp.test(count) && exp.test(floor)) {
		if (areainfo == null) {
			areainfo = '无';
		}
		$('#alert').dialog('destroy');
		$('#addcount').val('');
		$('#addareainfo').val('');
		$('#addfloor').val('');
		$('#addcabinetname').val('');
		$('#addprojectid').val('');
		$('#content').load(
				'filter/thirdparty/cabinet/addcabinets?' + url + '&page='
						+ page + '&addcount=' + count + '&addstatus=' + status
						+ '&addcabinetlevel=' + cabinetlevel + '&addareainfo='
						+ areainfo + '&addfloor=' + floor + '&addprojectid='
						+ projectid + '&addcabinetname=' + cabinetname+'&addcode='+codeNum);
	} else {
		if (!exp.test(count)) {
			$('#addspan').html("数量请输入数字");
		}
		if (!exp.test(floor)) {
			$('#addspan').html("楼层请输入数字");
		}
	}

}
/*------------------------确认修改------------------------*/
function sureeditcabinets() {
	var url = $('#url').val();
	var page = $('#curpage').val() - 1;
	var count = $('#editcount').val();
	var cabinetid = $('#editcabinetid').val();
	var status = $('#editstatus').val();
	var cabinetlevel = $('#editcabinetlevel').val();
	var areainfo = $('#editareainfo').val();
	var floor = $('#editfloor').val();
	var projectid = $('#editprojectid').val();
	var cabinetname = $('#editcabinetname').val();
	var code=$('#editcode').val();
	var exp = /^\d+$/;
	if (projectid == null || projectid == '' || cabinetname == null
			|| cabinetname == '' || count == null || count == ''
			|| floor == null || floor == ''||code=='') {
		$('#editspan').html('请输入完整信息');
	} else if (exp.test(count) && exp.test(floor)) {
		if (areainfo == null) {
			areainfo = '无';
		}
		$('#alertedit').dialog('destroy');
		$('#content').load(
				'filter/thirdparty/cabinet/editcabinets?&page='
						+ page + '&editcount=' + count + '&editstatus='
						+ status + '&editcabinetlevel=' + cabinetlevel
						+ '&editareainfo=' + areainfo + '&editfloor=' + floor
						+ '&editprojectid=' + projectid + '&editcabinetname='
						+ cabinetname + '&editcabinetid=' + cabinetid+'&editcode='+code);
	} else {
		if (!exp.test(count)) {
			$('#editspan').html("数量请输入数字");
		}
		if (!exp.test(floor)) {
			$('#editspan').html("楼层请输入数字");
		}
	}
}
/*------------------------关闭弹窗------------------------*/
function cancle() {
	$('#alert').dialog('destroy');
}
/*------------------------查询------------------------*/
function findcabinets() {
	//var code = document.getElementById("code").value;
	//var cabinetid = document.getElementById("cabinetid").value;
	var exp = /^\d+$/;
/*	if (code != null && code != '' && !exp.test(code)) {
		alert("大储物柜编号必须为数字");
	} else {*/
	    var cabinetcode = document.getElementById("code").value;
		var cabinetname = document.getElementById("cabinetname").value;
		var projectname = document.getElementById("projectname").value;
		var cabinetstatus = document.getElementById("cabinetstatus").value;
		$('#content').load(
				'filter/thirdparty/cabinet/home?page=0&cabinetname=' + cabinetname + '&projectname='
						+ projectname + '&cabinetstatus=' + cabinetstatus+'&code='+cabinetcode);

}
/*------------------------删除储物柜------------------------*/
function deletecabinets() {
	var obj = document.getElementsByName('promotions');
	var checkval = [];
	for ( var k in obj) {
		if (obj[k].checked)
			checkval.push(obj[k].value);
	}
	var cabinets = checkval.toString();
	if (checkval == null || checkval == "") {
		alert("请勾选");
	} else {
		if (window.confirm("确定删除所选大储物柜下的所有小储物柜吗？")) {
			var page = document.getElementById("curpage").value - 1;
			var url = document.getElementById("url").value;
			$('#content').load(
					"filter/thirdparty/cabinet/deletecabinets?" + url
							+ "&page=" + page + "&cabinets=" + cabinets);
		}
	}
}
/*------------------------查看储物柜详情------------------------*/
function showcabinetdetail(cabinetid,code,cabinetName) {
	$('#content').load(
			'filter/thirdparty/cabinetdetail/home?page=0&status=3&cabinetid='
					+ cabinetid+'&code='+code+'&cabinetName='+cabinetName);
}
/*------------------------修改储物柜------------------------*/
function editcabinet(cabinetId, cabinetName, projectId, projectName, floor,
		areaInfo, status, statusname, rank, rankname, cabinetCount,code) {
	$('#editcabinetname').val(cabinetName);
	$('#editcabinetid').val(cabinetId);
	$('#editcount').val(cabinetCount);
	$('#showprojectid').val(projectId);
	$('#showprojectid').html(projectName);
	$('#editfloor').val(floor);
	$('#editareainfo').val(areaInfo);
	$('#showstatus').val(status);
	$('#showstatus').html(statusname);
	$('#showcabinetlevel').val(rank);
	$('#showcabinetlevel').html(rankname);
	$('#editcode').val(code);
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
/*------------------------关闭修改弹窗------------------------*/
function cancleedit() {
	$('#alertedit').dialog('destroy');
}