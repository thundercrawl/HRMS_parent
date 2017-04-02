var userid=0;
$(function() {
	var page=0;
	$('#formParam').val($('#forid').serialize());
	$("#transfer-alert").hide();
	$("#transfer-alert2").hide();
	
	$('#memberCreate').on('click', function() {
	//创建 	
		debugger;
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
		});
		$("#addUserName").val("");
	    $("#userPw").val("");
		$("#addUserPhone").val("");
		$("#userMail").val("");
		$("#namespan").hide();
		$("#passwordspan").hide();
		$("#phonespan").hide();
		});
	
	$('#memCreQuit').on('click', function() {
			$('#addPdialog').dialog('destroy');
	});
	var imgURL="";
	$('#userId1').on('submit', function() {
		$(this).ajaxSubmit({
			type: 'post', 
			url: 'filter/member/memberGetUrl',
			dataType:'json',
			async:false,
			data : {},
			success : function(data) {
				imgURL=data.assureMoney;
				console.log("imgURL="+imgURL)
				creSure();
			},
			error : function(data) {
				alert("上传文件失败");
			}
		});
	
	return false; // 阻止表单自动提交事件
	});
	
	creSure = function(){
		var addUserName=$("#addUserName").val();
		var userPw=$("#userPw").val();
		var addUserPhone=$("#addUserPhone").val();
		var userMail=$("#userMail").val();
		$.ajax({
			url : 'filter/member/memberSave',
			type : 'POST',
			data : {
				addUserName:addUserName,
				userPw:userPw,
				addUserPhone:addUserPhone,
				userMail:userMail,
				memberImg:imgURL
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				$('#addPdialog').dialog('destroy');
				if(data.message=="手机已被注册"){
					alert("对不起，该手机已被注册！");
				}else if(data.message=="成功"){
					alert("添加成功");
					$('#content').load("filter/member/memberShow");
				}else{
					alert("添加失败");
				}
			},
			error : function(data) {
				alert(data);
			}
		});
	}
	
	$('#memCreSure').on('click', function() {
		$('#userId1').submit();	
	});
	
	function showFileName(){
		var length = document.getElementById("file").files.length;
		for(var i=0;i<length;i++){
			var file = document.getElementById("file").files[i];
			console.log("file-img-name="+file.name);
			$("#memberImg").val(file.name);
		}
	}	
	$('#file').on('change', showFileName);
	prohibition = function(uid,status) {
		if($('.prohibition-'+uid).val()=="禁用"){
			status=1;
		}else if($('.prohibition-'+uid).val()=="解禁"){
			status=-1;
		}
		$.ajax({
			url : 'filter/member/prohibition',
			type : 'POST',
			data : {
				uid : uid,
				status:status
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				//$('#content').load("member/memberShow");
				if(data.message=="解禁"){
					$('.prohibition-'+uid).val("禁用");
					$('.status-'+uid).html("可使用");
				}else if(data.message=="禁用"){
					$('.prohibition-'+uid).val("解禁");
					$('.status-'+uid).html("禁用");
				}
			},
			error : function(data) {
				alert(data);
			}
		});
	}
	memberDel = function(uid) {
		$.ajax({
			url : 'filter/member/memberDel',
			type : 'POST',
			data : {
				uid : uid
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				$('#content').load("filter/member/memberShow");
			},
			error : function(data) {
				alert(data);
			}
		});
	}
	$('#forMemSearch').on('click',function(){
		
		$('#formParam').val($('#forid').serialize());
		$('#tid').load("filter/member/getQuerry",$('#forid').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});
	
	$('#export').on('click',function(){
		var userId=$("#userId").val();
		var userName=$("#userName").val();
		var companyId=$("#nomalCompanyId").val();
		var userPhone=$("#userPhone").val();
		window.open("filter/exportUserInfo/exportUserInfos?userId="+userId+"&userName="+userName+"&companyId="+companyId+"&userPhone="+userPhone);

//		$.ajax({
//			url : 'filter/exprot/exportUserInfo',
//			type : 'POST',
//			data : {
//				"userId" : userId,
//				"userName" : userName,
//				"companyId" : companyId,
//				"userPhone" : userPhone
//			},
//			cache : false,
//			dataType : 'text',
//			success : function(data) {
//				alert("导出成功！");
//			},
//			error : function(data) {
//				alert("导出失败！");
//			}
//		});
//		$('#formParam').val($('#forid').serialize());
//		$('#content').load("filter/export/exportUserInfo",$('#forid').serialize(), function(){
//			$('.pagination>li>a').on('click', pageFunc);
//		});
	});
	
	$("#addUserName").blur(function(){debugger
			var regname = /^[\u4E00-\u9FA5]{1,10}$/;
			var regname1=/^[a-zA-Z ]{1,20}$/;
			if($(this).is("#addUserName")){
				if(!regname.test(this.value)&&!regname1.test(this.value)){
					$(this).siblings("span").show();
				}else{
					$(this).siblings("span").hide();
				}
			}
	});
	$("#addUserPhone").blur(function(){
		var regphone = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
		if($(this).is("#addUserPhone")){
			if(!regphone.test(this.value)){
				$(this).siblings("span").show();
			}else{
				$(this).siblings("span").hide();
			}
		}
	}
	);
	$("#userPw").blur(function(){
		var reg=/(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$).{6,}/;
		if($(this).is("#userPw")){
			if(this.value.length<6||this.value.length>18||!reg.test(this.value)){
				$(this).siblings("span").show();
					}else{
						$(this).siblings("span").hide();
					}
		}
	}
	);
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
	memCompany = function(userPhone) {		
		$('#content').load("filter/member/companyShow?userPhone="+userPhone);
	}
	//查询公司
	joinCompany = function(uid) {
		userid=uid;
		$("#joinPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
		});
		$.ajax({
			url : 'filter/member/searchCompany',
			type : 'POST',
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					var template = Handlebars.compile($("#companyoption").html());
					$('#companyId').html(template(data.rows));
					companyid=$('#companyId').val();
					$("#companyId").change(function(){
						companyid=$(this).val();
					});
				}
			},
			error : function(data) {
			}
		});
	}
	$("#joinQuit").on("click",function(){
		$('#joinPdialog').dialog('destroy');
	});
	//加入公司
	$("#joinSure").unbind( "click" );
	$("body").delegate("#joinSure","click",function(){
	var companyId=$('#companyId').val();
	var nomalCompanyId=$('#nomalCompanyId').val();
	var userId=$('#userId').val();
	var userName=$('#userName').val();
	var userPhone=$('#userPhone').val();
		$.ajax({
			url : 'filter/member/joinCompany',
			type : 'POST',
			cache : false,
			data:{
				companyId:companyId,
				userId:userid
			},
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					$('#joinPdialog').dialog('destroy');
					alert("操作成功")
					$('#content').load("filter/member/memberShow?nomalCompanyId="+nomalCompanyId+"&userId="+userId+"&userName="+userName+"&userPhone="+userPhone);
				}else  if (data.message == 'fail') {
					$('#joinPdialog').dialog('destroy');
					alert("操作失败")
				}
			},
			error : function(data) {
			}
		});
	})
});