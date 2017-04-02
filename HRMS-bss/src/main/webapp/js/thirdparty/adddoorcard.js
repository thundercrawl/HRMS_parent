/*------------------------查询------------------------*/
function findordermessage() {
	var orderid = $('#orderid').val();
	var exp = /^\d+$/;
	if (orderid == null || orderid == '') {
		alert("请输入订单编号");
	} else if (!exp.test(orderid)) {
		alert("请输入正确的订单编号");
	} else {
		$('#content').load(
				'filter/thirdparty/adddoorcard/home?orderid=' + orderid);
	}
}
/*------------------------添加授权------------------------*/
function adddoorcard(orderId, orderDetailId, projectId, projectName, floorMsg,
		doorId, doorNumber, rentStartTime, rentEndTime, companyName, companyId) {
	$('#addspan').html("");
	$('#surepasswordspan').html("");
	$('#addpasswordspan').html("");
	$('#addorderId').val(orderId);
	$('#addorderDetailId').val(orderDetailId);
	$('#addprojectId').val(projectId);
	$('#addprojectName').val(projectName);
	$('#addfloorMsg').val(floorMsg);
	$('#adddoorId').val(doorId);
	$('#adddoorNumber').val(doorNumber);
	$('#addrentStartTime').val(rentStartTime);
	$('#addrentEndTime').val(rentEndTime);
	$('#addcompanyName').val(companyName);
	$('#addcompanyId').val(companyId);
	$('#addcardnumber').val("");
	$('#addpassword').val("");
	$('#surepassword').val("");
	$('#addcardnumberspan').html("");
	$.ajax({
		url : 'filter/thirdparty/adddoorcard/showuser',
		type : 'POST',
		data : {
			'companyid' : companyId
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			$('#adduserId').html("");
			$.each(data.rows, function(index, item) {
				if (item.userName == null || item.userName == '') {
					$('#adduserId').html(
							$('#adduserId').html() + '<option value="'
									+ item.userId + '">' + item.userPhone
									+ '</option>');
				} else {
					$('#adduserId').html(
							$('#adduserId').html() + '<option value="'
									+ item.userId + '">' + item.userName
									+ '</option>');
				}
			});
		}
	});
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
}
/*------------------------关闭弹窗------------------------*/
function cancledoorcard() {
	$('#alert').dialog('destroy');
}
/*------------------------确认授权------------------------*/
function suredoorcard() {
	var exp = /^(\w){6}$/;
	var s = $('#addpassword').val();
	var s1 = $('#surepassword').val();
	if (s == null || s == '') {
		$('#addpasswordspan').html("请输入密码");
	} else if (!exp.test(s1)) {
		$('#surepasswordspan').html("请输入6位密码");
	} else if (s1 != s) {
		$('#surepasswordspan').html("两次密码输入不相符");
	} else {
		$('#surepasswordspan').html("");
		$('#addpasswordspan').html("");
		var orderId = $('#addorderId').val();
		var orderDetailId = $('#addorderDetailId').val();
		var projectId = $('#addprojectId').val();
		var doorId = $('#adddoorId').val();
		var rentStartTime = $('#addrentStartTime').val();
		var rentEndTime = $('#addrentEndTime').val();
		var companyId = $('#addcompanyId').val();
		var cardnumber = $('#addcardnumber').val();
		var userId = $('#adduserId').val();
		var s = $('#addpassword').val();
		var password = $('#surepassword').val();
		var exp = /^(\w){8}$/;
		var re = /^(\w){6}$/;
		if (s == null || !re.test(password) || !re.test(s) || s != password
				|| !exp.test(cardnumber) || userId == null || userId == '') {
			$('#addspan').html("请正确填写信息");
		} else {
			$.ajax({
				url : 'filter/thirdparty/adddoorcard/grantdoorcard',
				type : 'POST',
				data : {
					'orderid' : orderId,
					'password' : password,
					'userId' : userId,
					'cardnumber' : cardnumber,
					'companyId' : companyId,
					'rentEndTime' : rentEndTime,
					'rentStartTime' : rentStartTime,
					'doorId' : doorId,
					'projectId' : projectId,
					'orderDetailId' : orderDetailId
				},
				cache : false,
				async : false,
				dataType : 'json',
				success : function(data) {
					if (data.message == "1") {
						$('#alert').dialog('destroy');
						$('#content').load(
								'filter/thirdparty/adddoorcard/home/?orderid='
										+ orderId);
					} else if (data.message == "2") {
						$('#addspan').html("该卡已被他人使用");
					} else if (data.message == "3") {
						$('#addspan').html("授权失败");
					}
				}
			});
		}
	}
}
/*------------------------密码验证------------------------*/
$('#addpassword').blur(function() {
	var s = $('#addpassword').val();
	var exp = /^(\w){6}$/;
	if (!exp.test(s)) {
		$('#addpasswordspan').html("请输入6位密码");
	} else {
		$('#addpasswordspan').html("");
	}
});
/*------------------------门卡验证------------------------*/
$('#addcardnumber').blur(function() {
	var cardnumber = $('#addcardnumber').val();
	var exp = /^(\w){8}$/;
	if (!exp.test(cardnumber)) {
		$('#addcardnumberspan').html("卡号必须为8位");
	} else {
		$('#addcardnumberspan').html("");

	}
});