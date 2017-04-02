$('.edit').on('click', function() {
	$("#addMdialog").dialog({
		modal : true,
		autoOpen : true,
		height : 'auto',
		width : 344,
		resizable : false,
		close : function() {
			$('#addMdialog').dialog('destroy');
		}
	});
	$('#name').val($(this).attr('data-name'));
	$('#phone').val($(this).attr('data-phone'));
	$('#idCard').val($(this).attr('data-idCard'));
	$('#sex').val($(this).attr('data-sex'));
	$('#age').val($(this).attr('data-age'));
	$('#email').val($(this).attr('data-mail'));
	$('#namailmespan').html('');
	$('#phonespan').html('');
	$('#idCardspan').html('');
	$('#sexspan').html('');
	$('#agespan').html('');
	$('#mailscspan').html('');
});
$('#return').on('click', function() {
	$('#addMdialog').dialog('destroy');
});
var flag=1;
var flag2=1;
var flag3=1;
$("#name").blur(function() {
	var name = $('#name').val();
	var regname = /^[\u0391-\uFFE5]+$/;
	if (!regname.test(name)) {
		$('#namespan').html("<font color=\"#FF6A6A\" size=\"2\">X</font>");
		flag=1;
	} else {
		$('#namespan').html("<font color=\"green\" size=\"2\">√</font>");
		flag=0;
	}alert(flag)
});
$("#phone").blur(function() {
	var phone = $('#phone').val();
	var regphone = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
	if (!regphone.test(phone)) {
		$('#phonespan').html("<font color=\"#FF6A6A\" size=\"2\">X</font>");
		flag2=1;
	} else {
		$('#phonespan').html("<font color=\"green\" size=\"2\">√</font>");
		flag2=0;
	}alert(flag2)
});
$("#idCard").blur(function() {
					var idCard = $('#idCard').val();
					var regidCard = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
					if (!regidCard.test(idCard)) {
						$('#idCardspan').html(
								"<font color=\"#FF6A6A\" size=\"2\">X</font>");
						flag3=1;
					} else {
						$('#idCardspan').html(
								"<font color=\"green\" size=\"2\">√</font>");
						flag3=0;
					}alert(flag)
				});
$("#sex").blur(function() {
	var sex = $('#sex').val();
	var regsex = /^['男'|'女']$/;
	if (sex == "") {
		$('#sexspan').html("<font color=\"green\" size=\"2\">√</font>");
	} else {
		if (!regsex.test(sex)) {
			$('#sexspan').html("<font color=\"#FF6A6A\" size=\"2\">X</font>");
		} else {
			$('#sexspan').html("<font color=\"green\" size=\"2\">√</font>");
		}
	}
});
$("#age").blur(function() {
	var age = $('#age').val();
	var regage = /^([0-9]|[0-9]{2}|100)$/;
	if (age == "") {
		$('#agespan').html("<font color=\"green\" size=\"2\">√</font>");
	} else {
		if (!regage.test(age)) {
			$('#agespan').html("<font color=\"#FF6A6A\" size=\"2\">X</font>");
		} else {
			$('#agespan').html("<font color=\"green\" size=\"2\">√</font>");
		}
	}
});
$("#email").blur(
		function() {
			var email = $('#email').val();
			var regemail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
			if (email == "") {
				$('#emailspan').html(
						"<font color=\"green\" size=\"2\">√</font>");
			} else {
				if (!regemail.test(email)) {
					$('#emailspan').html(
							"<font color=\"#FF6A6A\" size=\"2\">X</font>");
				} else {
					$('#emailspan').html(
							"<font color=\"green\" size=\"2\">√</font>");
				}
			}
		});
$('#formcheck').on('click',function() {
			var name = $('#name').val();
			var phone = $('#phone').val();
			var idCard = $('#idCard').val();
			var sex = $('#sex').val();
			var age = $('#age').val();
			var email = $('#email').val();
			if(flag==0&&flag2==0&&flag3==0){
			$('#page-body').load(
					"filter/personal/updateInfo?name=" + name + "&phone="
							+ phone + "&idCard=" + idCard + "&sex=" + sex
							+ "&age=" + age + "&email=" + email);
			$('#addMdialog').dialog('destroy');
			}
			else {
				alert("请输入正确信息！");
			}})