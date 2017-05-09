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
		$(".header-title > li").click(function(){
			$(this).addClass("user-selected").siblings("li").removeClass("user-selected");
			$(".user-form").eq($(this).index()).show().siblings(".user-form").hide();
		});
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
			/*重置数据*/
            $('#truename').val(rnameOld);
            $('#telephone').val(phoneOld);
            $('#sex').val(sexOld);
            $('#dataOfBirth').val(dataOfBirthOld);
            $('#userEamil').val(userEamilOld);
            $('#password').val("");
            $('#new-password').val("");
            $('#new-password1').val("");

            $(".user-form1 >div >input").attr("readonly","readonly");
            $("#user-info-btn").hide();
            $(".user-form >div >span").hide();
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
		//密码验证
		$(".user-form2 :input").blur(function(){
			if($(this).is("#password")){
				pwdval1 = $("#password").val();
				  if(pwdval1==""){
					$(this).siblings("span").text("密码不能为空").show();
				}else{
					if(pwdval2==pwdval1){
						$('#span2').text("新密码不能与原密码相同").show();
					}
					$(this).siblings("span").hide();
				}
			}
			if($(this).is("#new-password")){
				pwdval2 = $("#new-password").val();
				pwdlen2 = $("#new-password").val().length;
				var reg=/(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$).{6,}/;//修改提示错误
				if(pwdval2==pwdval1){
					$(this).siblings("span").text("新密码不能与原密码相同").show();
				}else{
					if(pwdlen2<6){
						$(this).siblings("span").text("密码过短").show();	
					}else{
						if(pwdlen2>18){
							$(this).siblings("span").text("密码过长").show();
						}else{
							if(!reg.test(this.value)){
								$(this).siblings("span").text("密码格式不对").show();
							}else{
								$(this).siblings("span").hide();
							}
						}
					}
				}
			}
			if($(this).is("#new-password1")){
				pwdval3 = $("#new-password1").val();
				pwdlen3 = $("#new-password1").val().length;
				if(pwdval3!=pwdval2){
					$(this).siblings("span").text("和原密码输入不一致").show();
				}else{
					if(pwdlen3<6||pwdlen3>18){
						$(this).siblings("span").text("输入错误").show();
					}else{
						$(this).siblings("span").hide();
					}
				}
			}
			$(this).siblings('span').css('display')=='block'?
			$(this).siblings('span').addClass('active2'):
			$(this).siblings('span').removeClass('active2');
		}).keyup(function(){
           $(this).triggerHandler("blur");
        }).focus(function(){
             $(this).triggerHandler("blur");
        });
		
		//密码是否显示
		$(".user-passwd >p >img").click(function(){
			var Input = $(this).parent().siblings("input");
			Input.hasClass('active1')?(
				Input.attr('type','password'),
				Input.removeClass('active1'),
				$(this).attr("src","img/userinfo/open.png")
			):(
				Input.attr('type','text'),
				$(this).attr("src","img/userinfo/close.png"),
				Input.addClass('active1')
			)
		})


		
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
		
		//只修改密码！
		$(".save-succ").hide();		
		var timeoutName;
		$("#btn-users2").click(function(){
			if($(this).find('input').attr('readonly') != undefined) {
				console.log('readonly');
				return;
			}
			$(".user-form2 :input").triggerHandler("blur");
			if($("#password").val().length==0){
				$('#span1').show();
			}
			if($("#new-password").val().length==0){
				$('#span2').show();
			}
			if($("#new-password1").val().length==0){
				$('#span3').show();
				return;
			}
			debugger
			if($("#password").val().length==0||$("#new-password").val().length==0||$("#new-password1").val().length==0){
				return;
			}
			if($(".user-form2 >div >span").hasClass('active2')) {
				return;
			}
			$.ajax({
				type : 'POST',
				url :"filter/personal/updatePwd",
				data : {
					oldPsw : $("#password").val(),
					newpassword : $("#new-password").val(),
				},
				dataType : 'json',
				success : function(data) {
					if(data.code != "0000") {
						$('#alertInfo').text(data.message);
						$('#alertInfo').css('background','red');
						$(".save-succ").show();	
						clearTimeout(timeoutName);
						timeoutName = setTimeout(function(){
							$(".save-succ").hide();
						},3000);
					} else {
						$('#alertInfo').css('background','#98D1F5');
						$('#alertInfo').text('密码保存成功');
						$(".save-succ").show();	
						if(timeoutName != undefined) {
							clearTimeout(timeoutName);
						}
						timeoutName = setTimeout(function(){
							$(".save-succ").hide();
						},3000);
						$("#password").val("");
						$("#new-password").val("");
						$("#new-password1").val("");
					}
				}
				});
		});
		
		$(".header-title").find("li").eq(1).click(function(){
			$("#btn-users2").addClass("btn-user");
		})
        $("#alterPwd").on('click',function () {
            $('.user-form2').show();
            $('.user-form1').hide();
            $("#personMessage").removeAttr("class");
            $("#alterPwd").addClass("user-selected");
        })
        $("#personMessage").on('click',function () {
            $('.user-form1').show();
            $('.user-form2').hide();
            $("#alterPwd").removeAttr("class");
            $("#personMessage").addClass("user-selected");
        })
	})