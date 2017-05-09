	$(function(){
		var password;
		var pwdval1;
		var pwdval2;
		var pwdval3;
		var pwdlen2;
		var pwdlen3;
		var mark;


		var rnameOld = $('#truename').val();
		var phoneOld = $('#telephone').val();
		var sexOld = $('#sex').val();
		var dataOfBirthOld = $('#dataOfBirth').val();
		var userEamilOld = $('#userEamil').val();


		var flag = true;
		
		$("#user-info-btn").hide();	
		$(".btn-userc").show();			
		$(".btn-userc").click(function(){
			/*$(".user-form > div > input").removeAttr("readonly");*/
			$('#truename').removeAttr("readonly");
			$('#telephone').removeAttr("readonly");
			$('#sex').removeAttr("readonly");
			$('#dataOfBirth').removeAttr("readonly");
			$('#userEamil').removeAttr("readonly");
			$(".user-form >div >input:eq(0)").attr("readonly","readonly");
			$("#user-info-btn").show();
		})
		$(".user-info #btn-users").click(function(){
			$(".user-info >div >input").attr("readonly","readonly");
			$("#user-info-btn").hide();
		})
		$("#btn-userg").click(function(){
			$(".user-form1 >div >input").attr("readonly","readonly");
			$("#user-info-btn").hide();
			$(".user-form >div >span").hide();
			showInfo();
		})
		$(".user-form > div >span").hide();
		$(".user-form1 :input").blur(function(){
			var regname = /^([\u4e00-\u9fa5]+|([a-zA-Z]+\s?)+)$/;
			if($(this).is("#truename")){
				if(!regname.test(this.value)){
					$(this).siblings("span").show();
					$('#namespan').html("<font color=\"#FF6A6A\" size=\"2\">请输入正确的姓名</font>");
				}else{
					$(this).siblings("span").hide();
				}
			}
			var regphone = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
			if($(this).is("#telephone")){
				if(!regphone.test(this.value)){
					$(this).siblings("span").show();
					$('#phonespan').html("<font color=\"#FF6A6A\" size=\"2\">请输入正确格式的手机号码</font>");
				}else{
					$(this).siblings("span").hide();
				}
			}
			var regidCard = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
			if($(this).is("#idnum")){
				if(!regidCard.test(this.value)){
					$(this).siblings("span").show();
					$('#idCardspan').html(
					"<font color=\"#FF6A6A\" size=\"2\">请输入正确格式的身份证号码</font>");
				}else{
					$(this).siblings("span").hide();
				}
			}
			$(this).siblings('span').css('display')=='block'?
			$(this).siblings('span').addClass('active1'):
			$(this).siblings('span').removeClass('active1');
			$(".user-form >div >span").hasClass('active1')?(
				$(".btn1-users").attr('readonly','readonly'),
				$(".btn1-users").css('cursor','not-allowed'),
				$('#btn-users').css('background','#ccc')
				):(
				$(".btn1-users").removeAttr('readonly'),
				$(".btn1-users").css('cursor','pointer'),
				$('#btn-users').css('background','#2aadff')
			);
		}).keyup(function(){
           $(this).triggerHandler("blur");
        }).focus(function(){
             $(this).triggerHandler("blur");
        });

		
		$("#btn-userg").click(function(){
			$("#truename").val("");
			$("#telephone").val("");
			$("#idnum").val("");
		});
		var sexInput = 1;
        $('#sex').on("blur",function () {
            $('#sexspan').hide();
            var sexZh = $('#sex').val();
            if(sexZh == "男" ){
                sexInput = 1;
			}
			else if(sexZh == "女"){
            	sexInput = 2;
			}else{
				$('#sexspan').show();
                flag = false;
			}
        })

		//修改个人信息，不修改
		$("#btn-users").click(function(){
            if(flag) {
                $.ajax({
                    type: 'POST',
                    url: "filter/user/updateCurrent",
                    data: {
                        userName: $("#truename").val(),
                        userPhone: $("#telephone").val(),
                        userSex: sexInput,
                        birthOfDate: $("#birthOfDate").val(),
                        userEmail: $("#userEmail").val()
                    },
                    dataType: 'json',
                    success: function (data) {
                    }
                });

            }

		});
		
	})