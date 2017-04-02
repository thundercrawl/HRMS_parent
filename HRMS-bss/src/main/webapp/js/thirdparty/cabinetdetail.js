var codestring;
var cabinetNamestr;
/*------------------------添加小储物柜弹窗------------------------*/
$('#addcabinetsdetail').on('click', function() {
	$("#alertdetail").dialog({
		modal : true,
		autoOpen : true,
		height : 'auto',
		width : 360,
		resizable : false,
		close : function() {
			$('#alertdetail').dialog('destroy');
		}
	});
});
/*------------------------全选/全不选------------------------*/
function checkAlldetail(obj) {
	var curCheckBox = document.getElementsByName("promotions");
	for (var i = 0; i < curCheckBox.length; i++) {
		curCheckBox.item(i).checked = obj.checked;
	}
}
/*------------------------关闭添加弹窗------------------------*/
function cancledetail() {
	$('#alertdetail').dialog('destroy');
}
/*------------------------关闭修改弹窗------------------------*/
function cancleeditdetail() {
	$('#alertedit').dialog('destroy');
}
/*------------------------返回大储物柜页面------------------------*/
function returncabinetdetail() {
	$('#content').load('filter/thirdparty/cabinet/home?page=0');
}
/*------------------------关闭修改弹窗------------------------*/
function cancleeditdetail() {
	$('#alerteditdetail').dialog('destroy');
}
/*------------------------删除小储物柜------------------------*/
function deletecabinetsdetail(code,cabinetName) {
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
		if (window.confirm("确定删除所选的小储物柜吗？")) {console.log(document.getElementById("curpage").value)
			var page =$("#curpage").val() - 1;
			var url = document.getElementById("url").value;
			$('#content').load(
					"filter/thirdparty/cabinetdetail/deletecabinets?" + url
							+ "&page=" + page + "&cabinets=" + cabinets+"&code="+code+"&cabinetName="+cabinetName);
		}
	}
}
/*------------------------确认添加小储物柜------------------------*/
function surecabinetsdetail(code,cabinetName) {
	var cabinetdetailid = $('#addcabinetdetailid').val();
	var cabinetid = $('#cabinetid').val();
	var status = $('#addstatus').val();
	var type = $('#addtype').val();
	var url = document.getElementById("url").value;
	var page = $('#curpage').val() - 1;
	var exp = /^\d+$/;
	if (cabinetdetailid == '' || cabinetdetailid == null) {
		$('#addsmallspan').html("请输入完整信息");
	} else if (!exp.test(cabinetdetailid)) {
		$('#addsmallspan').html("小储物柜编号必须为数字");
	} else {
		$.ajax({
			url : 'filter/thirdparty/cabinetdetail/addcabinetdetail',
			type : 'POST',
			data : {
				'addcabinetdetailid' : cabinetdetailid,
				'cabinetid' : cabinetid,
				'addstatus' : status,
				'addtype' : type
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == "1") {
					$('#alertdetail').dialog('destroy');
					$('#content').load(
							'filter/thirdparty/cabinetdetail/home?' + url
									+ '&page=' + page+"&code="+code+"&cabinetName="+cabinetName);
				} else if (data.message == "2") {
					$('#addsmallspan').html("该储物柜已存在");
				} else if (data.message == "3") {
					$('#addsmallspan').html("操作失败");
				}
			}
		});
	}
}
/*-----------------------------修改小储物柜----------------------------------*/
function editcabinetdetail(code,cabinetName,cabinetDetailid, status, statusString, type,
		typestring) {
	codestr=code;
	cabinetNamestr=cabinetName;
	$('#editcabinetdetailid').val(cabinetDetailid);
	$('#showstatus').val(status);
	$('#showtype').val(type);
	$('#showstatus').html(statusString);
	$('#showtype').html(typestring);
	$("#alerteditdetail").dialog({
		modal : true,
		autoOpen : true,
		height : 'auto',
		width : 360,
		resizable : false,
		close : function() {
			$('#alerteditdetail').dialog('destroy');
		}
	});
}
/*--------------------------------确认修改-----------------------------------------*/
function sureeditcabinetsdetail() {
	var url = document.getElementById("url").value;
	var page = $('#curpage').val() - 1;
	var status = $('#editstatus').val();
	var type = $('#edittype').val();
	var editcabinetdetailid = $('#editcabinetdetailid').val();
	$('#alerteditdetail').dialog('destroy');
	$('#content').load(
			'filter/thirdparty/cabinetdetail/editcabinetdetail?' + url
					+ '&page=' + page + '&editstatus=' + status
					+ '&editcabinetdetailid=' + editcabinetdetailid
					+ '&edittype=' + type+"&code="+codestr
					+"&cabinetName="+cabinetNamestr);
}
/*---------------------------------查询------------------------*/
function findcabinetsdetail(code,cabinetName) {
	var cabinetdetailid = $('#cabinetdetailid').val();
	var status = $('#status').val();
	var cabinetid = $('#cabinetid').val();
	var exp = /^\d+$/;
	if (cabinetdetailid != null && cabinetdetailid != ''
			&& !exp.test(cabinetdetailid)) {
		alert("小储物柜编号必须为数字");
	} else {
		$('#content').load(
				'filter/thirdparty/cabinetdetail/home?page=0&cabinetdetailid='
						+ cabinetdetailid + '&status=' + status + '&cabinetid='
						+ cabinetid+'&code='+code+'&cabinetName='+cabinetName);
	}

}