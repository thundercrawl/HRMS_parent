$(function() {
	
	if($('#logoDiv').length != 0) {
		$('.login-head').remove();
		$('.login-main').css('margin-top','20px');
	}
	
	document.onkeydown = function(e){
        if(!e) e = window.event;//火狐中是 window.event
        if((e.keyCode || e.which) == 13){
            document.getElementById("submit").click();
        }
    }
	/*
	 * 添加submit()事件，完成表单校验
	 */
	$("#submit").click(function() {
		var bool = true;
		$("input").each(function() {
			var inputName = $(this).attr("name");
			if(inputName!="organizeId")
			if (!invokeValidateFunction(inputName)) {
				bool = false;
			}
		});
		if (bool) {
			var organizeId=$('#organizeId').val();
			$.ajax({
				type : 'POST',
				url :"login/login",
				data : {
                    userPhone : $("#loginname").val(),
                    userPasswd :$('#loginpass').val()
				},
				dataType : 'json',
				async : false,
				success : function(msg) {
					if (msg == '1') {
						window.location.href = "filter/home";
						//window.location.href = "filter/offlineReserve/toOfflineReserve";
					} else {
						$("#loginnameError").css("display", "");
						if(msg == '5024'){
							$("#loginnameError").text("你的账号已经被锁定，请联系管理员!");
						}else{
							$("#loginnameError").text("用户名或密码不对!");
						}
						//$("#kaptchaImage").src='filter/user/getKaptchaImage?e='+new Date();
						//window.location.reload(true);
						$("#kaptchaImage").attr('src','login/getKaptchaImage?e='+new Date()); 
					}
				}
			});
		}

		 //return bool;
	});

	/*
	 * 输入框得到焦点时隐藏错误信息
	 */
	$("input").focus(function() {
		var inputName = $(this).attr("name");
		$("#" + inputName + "Error").css("display", "none");
	});

	/*
	 * 输入框推动焦点时进行校验
	 */
	$("input").blur(function() {
		var inputName = $(this).attr("name");
		invokeValidateFunction(inputName);
	})
	
	$('#verifyCode').focus(function(){
		$('#kaptchaImage').show();
	})
});

function invokeValidateFunction(inputName) {
	inputName = inputName.substring(0, 1).toUpperCase()
			+ inputName.substring(1);
	var functionName = "validate" + inputName;
	return eval(functionName + "()");
}

function validateLoginname() {
    var bool = true;
    $("#loginnameError").css("display", "none");
    var value = $("#loginname").val();
    if (!value) {// 非空校验
        $("#loginnameError").css("display", "");
        $("#loginnameError").text("用户名不能为空！");
        bool = false;
    }
    return bool;
}

function validatePhone() {
    var bool = true;
    $("#loginnameError").css("display", "none");
    var value = $("#loginname").val();
    if (!value) {// 非空校验
        $("#loginnameError").css("display", "");
        $("#loginnameError").text("手机号码不能为空！");
        bool = false;
    }
    if(value.length != 11 && value.length != 13){
        $("#loginnameError").css("display", "");
        $("#loginnameError").text("手机号码格式错误！");
        bool = false;
	}
    return bool;
}

function validateLoginpass() {
	var bool = true;
	$("#loginpassError").css("display", "none");
	var value = $("#loginpass").val();
	if (!value) {// 非空校验
		$("#loginpassError").css("display", "");
		$("#loginpassError").text("密码不能为空！");
		bool = false;
	} else if (value.length < 3) {// 长度校验
		$("#loginpassError").css("display", "");
		$("#loginpassError").text("密码长度必须在3 ~ 20之间！");
		bool = false;
	}
	return bool;
}



function validateVerifyCode() {
	var bool = true;
	$("#verifyCodeError").css("display", "none");
	var value = $("#verifyCode").val();
	if (!value) {// 非空校验
		$("#verifyCodeError").css("display", "");
		$("#verifyCodeError").text("验证码不能为空！");
		bool = false;
	} else if (value.length != 4) {// 长度不为4就是错误的
		$("#verifyCodeError").css("display", "");
		$("#verifyCodeError").text("错误的验证码！");
		bool = false;
	} else {// 验证码是否正确
		$.ajax({
			cache : false,
			async : false,
			type : "POST",
			dataType : "json",
			data : {
				verifyCode : value
			},
			url : "login/ajaxValidateVerifyCode",
			success : function(flag) {
				if (!flag) {
					$("#verifyCodeError").css("display", "");
					$("#verifyCodeError").text("错误的验证码！");
					$("#kaptchaImage").attr('src','login/getKaptchaImage?e='+new Date()); 
					bool = false;
				}
			},
			error : function() {
			}
		});
	}
	return bool;
}
