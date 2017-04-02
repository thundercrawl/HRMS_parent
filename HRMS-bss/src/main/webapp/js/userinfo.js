	$(function(){
		var password;
		var pwdlen1;
		var pwdlen2;
		var pwdlen3;
		var pwdval2;
		var pwdval3;
		var mark;
		
		$("#user-info-btn").hide();	
		$(".btn-userc").show();			
		$(".header-title > li").click(function(){
			$(this).addClass("user-selected").siblings("li").removeClass("user-selected");
			$(".user-form").eq($(this).index()).show().siblings(".user-form").hide();
		});
		$(".btn-userc").click(function(){
			alert("e")
			$(".user-form > div > input").removeAttr("readonly");
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
			if($(this).is("#truename")){
				if(this.value ==""){
					$(this).siblings("span").show();
				}else{
					$(this).siblings("span").hide();
				}
			}
			if($(this).is("#telephone")){
				if(this.value ==""){
					$(this).siblings("span").show();
				}else if(this.value.length!=11){
					$(this).siblings("span").text("请输入11位的手机号码").show();
				}else{
					$(this).siblings("span").hide();
				}
			}
			if($(this).is("#idnum")){
				if(this.value.length !=18){
					$(this).siblings("span").show();
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
		//font
		
		//密码验证
		$(".user-form2 :input").blur(function(){
			if($(this).is("#password")){
				pwdlen1 = this.value;
			 if(pwdlen1==password&&pwdlen1!=""){
					$(this).siblings("span").text("对不起，密码错误").hide();
				}
				else if(pwdlen1==""){
					$(this).siblings("span").hide();
					$("#new-password").siblings("span").hide();
					$("#new-password1").siblings("span").hide();
				}
			}
			if($(this).is("#new-password")){
				pwdval2 = $("#new-password").val();
				pwdlen2 = this.value;
				if(pwdlen2.length>0&&$("#new-password1").val().length>0&&pwdlen2!=$("#new-password1").val()){
					$(this).siblings("span").text("前后密码不一致").show();
				}
				if(pwdlen2.length>0&&$("#new-password1").val().length>0&&pwdlen2==$("#new-password1").val()){
					$(this).siblings("span").text("前后密码不一致").hide();
					$("#new-password1").siblings("span").text("前后密码不一致").hide();
				}
				if(pwdlen2.length!=0&&pwdlen1.length==0){
					$(this).siblings("span").text("请输入原密码").show();
				}else if (pwdlen2.length==0&&pwdlen1.length==0){
					$(this).siblings("span").text("请输入原密码").hide();
				}else if(pwdlen1==password&&pwdlen2==""){
					$(this).siblings("span").text("对不起，请输入新密码").show();
				}else if(pwdlen1==password&&pwdlen2.length!=0){
					$(this).siblings("span").text("对不起，请输入新密码").hide();
				}else if(pwdlen2==""){
					$(this).siblings("span").text("对不起，请输入新密码").hide();
				}
			}
			if($(this).is("#new-password1")){
				pwdval3 = $("#new-password1").val();
				pwdlen3 = this.value;
				if(pwdval2!=pwdval3){
					$(this).siblings("span").text("前后密码不一致").show();
				}else if (pwdval2==pwdval3){
					$(this).siblings("span").text("前后密码不一致").hide();
					$("#new-password").siblings("span").text("前后密码不一致").hide();
				}else if(pwdval2==""||pwdval3==""){
					$(this).siblings("span").text("前后密码不一致").hide();
				}else if(pwdlen3==""){
					$(this).siblings("span").text("前后密码不一致").hide();
				}
			}
			
			$(this).siblings('span').css('display')=='block'?
			$(this).siblings('span').addClass('active2'):
			$(this).siblings('span').removeClass('active2');
			/*$(".user-form2 >div >span").hasClass('active2')?(
				$(".btn2-users").attr('readonly','readonly'),
				$(".btn2-users").css('cursor','not-allowed'),
				$('#btn-users2').css('background','#ccc')
				):(
				$(".btn2-users").removeAttr('readonly'),
				$(".btn2-users").css('cursor','pointer'),
				$('#btn-users2').css('background','#2aadff')
			);*/
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
				$(this).attr("src","img/open.png")
			):(
				Input.attr('type','text'),
				$(this).attr("src","img/close.png"),
				Input.addClass('active1')
			)
		})


		//查询到个人信息并显示到页面上
		function showInfo(){
			$.ajax({
				url :"filter/showUserInfo/showAllInfo",
				type : 'POST',
				dataType : 'json',
				success : function(data) {
					$("#username").val(data[0].loginName),
					password = (data[0].loginPwd),
					$("#truename").val(data[0].realName),
					$("#telephone").val(data[0].userTel),
					$("#idnum").val(data[0].userIdCard);
					$('.load').hide();//隐藏蒙版
					}
				}
			);
		}
		$("#btn-userg").click(function(){
			$("#truename").val("");
			$("#telephone").val("");
			$("#idnum").val("");
		});

		//修改个人信息，不修改
		$("#btn-users").click(function(){
			$.ajax({
				type : 'POST',
				url :"filter/showUserInfo/updateUserInfo",
				data : {
					loginName : $("#username").val(),
					truename : $("#truename").val(),
					telephone : $("#telephone").val(),
					idnum : $("#idnum").val()
				},
				dataType : 'json',
				success : function(data) {
					
				}
				});
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
//				$(".btn-users").attr('readonly','readonly'),
//				$(".btn-users").css('cursor','not-allowed'),
//				$('#btn-users2').css('background','#ccc');
				return;
			}
			if($(".user-form2 >div >span").hasClass('active2')) {
				return;
			}
			$.ajax({
				type : 'POST',
				url :"filter/showUserInfo/updateUserPwd",
				data : {
					loginPwd : $("#password").val(),
					newpassword : $("#new-password").val(),
					newpassword1 : $("#new-password1").val()
				},
				dataType : 'json',
				success : function(data) {
					if(data == 0) {
						$('#alertInfo').text('原密码不正确');
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
//						showInfo();
//						$(".header-title").find("li").eq(0).addClass("user-selected")
//						$(".header-title").find("li").eq(1).removeClass("user-selected")
//						$("#userId1").hide();
//						$("#userId").show();
					}
				}
				});
		});
		
		showInfo();
		$(".header-title").find("li").eq(1).click(function(){
			$("#btn-users2").addClass("btn-user");
		})
	})