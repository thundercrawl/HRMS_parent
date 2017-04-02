$(function() {
	$(".modifymember").on("click",function(){
		$("#mod_username").val('');
		$("#userId").val('');
//		$("#mod_userPhone").val('');
		$("#mod_username").val($(this).attr("data-username"));
		$("#mod_userId").val($(this).attr("data-userID"));
//		$("#mod_userPhone").val($(this).attr("data-userPhone"));
		$("#spmod_username").hide();
//		$("#spmod_userPhone").hide();
		$("#modify_member").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#modify_member').dialog('destroy');
			}});
	});
	$("#modify_sure").on("click",function(){
		$("#spmod_username").hide();
	//	$("#spmod_userPhone").hide();
    var userId=$("#mod_userId").val();
    var userName=$.trim($("#mod_username").val());
    var userPhone=$("#mod_userPhone").val();
    var re= /^(1[0-9]{10})$/;
    var boo1=userName.length<=15&&userName.length>0;
    if(boo1){
    	$('#modify_member').dialog('destroy');
    	$('#tid').load("filter/member/modifymember?userId="+userId+"&userName="+encodeURI(userName),function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
    }else{
    	if(!boo1){
    		$("#spmod_username").show();
    		return ;
    	}
    }
	});
	$("#modify_esc").on("click",function(){
		$('#modify_member').dialog('destroy');
	});
	$(".removemember").on("click",function(){
		var userid=$(this).attr("data-userID");
		var companyid=$(this).attr("data-companyid");
		var userId=$("#userId").val();
		var companyId=$("#nomalCompanyId").val();
		var userName=$.trim($("#userName").val());
		var userPhone=$("#userPhone").val();
		if(companyId!=""){
			companyid = companyId;
		}
		 var sure=confirm("是否确认移除该成员");
		   if(sure){
			   $.ajax({
					url : 'filter/member/removeuser',
					type : 'POST',
					data : {
					"userId":userid,
					"companyId":companyid
					},
					cache : false,
					dataType : 'json',
					success : function(data) {
						if(data.message=="success"){
							alert("删除成功");
							if(companyId!=""){
								$('#content').load("filter/member/memberShow1?nomalCompanyId="+
										companyId+"&userId="+userId+"&userName="+userName+"&userPhone="+userPhone);
							}else{
								
								$('#content').load("filter/member/memberShow?nomalCompanyId="+
										companyId+"&userId="+userId+"&userName="+userName+"&userPhone="+userPhone);
							}
							
						}else if(data.message=="admin"){
							alert("请转让公司超级管理员的权限，才可以退出公司");
						}else if(data.message=="error"){
							alert("删除失败");
						}
					},
					error:function(data){
						alert("网络异常");
					}
				});
		   }
	});
	
	$(".resetPwd").on("click",function(){
		
		var userId= $(this).attr("data-userID");
		 var sure=confirm("是否确认重置密码");
		   if(sure){
			   $.ajax({
					url : 'filter/member/resetPwd',
					type : 'POST',
					data : {
					"userId":userId
					},
					cache : false,
					dataType : 'json',
					success : function(data) {
						if(data.message=="success"){
							alert("重置密码成功");
							$('#content').load("filter/member/memberShow?nomalCompanyId="+
									companyId+"&userId="+userId+"&userName="+userName+"&userPhone="+userPhone);
						}else if(data.message=="error"){
							alert("重置密码失败");
						}
					},
					error:function(data){
						alert("网络异常");
					}
				});
		   }
	})
	$(".superadmin").on("click",function(){
		var userid=$(this).attr("data-userID");
		var companyid=$(this).attr("data-companyid");
		var userId=$("#userId").val();
		var companyId=$("#nomalCompanyId").val();
		var userName=$.trim($("#userName").val());
		var userPhone=$("#userPhone").val();
		
		 var sure=confirm("是否确认设为超管(原先的超管将为普通成员)");
	   if(sure){
		   $.ajax({
				url : 'filter/member/userAccountByAdmin/transferSuperPermit',
				type : 'POST',
				data : {
				"newAdminId":userid,
				"companyId":companyId
				},
				cache : false,
				dataType : 'json',
				success : function(data) {
					if(data.message=="success"){
						alert("设置成功");
						$('#content').load("filter/member/memberShow1?nomalCompanyId="+
								companyId+"&userId="+userId+"&userName="+userName+"&userPhone="+userPhone);
					}else if(data.message=="error"){
						alert("设置失败");
					}
				},
				error:function(data){
					alert("网络异常");
				}
			});
	   }
	});
	
	$(".admin").on("click",function(){
		var userid=$(this).attr("data-userID");
		var companyid=$(this).attr("data-companyid");
		var userId=$("#userId").val();
		var companyId=$("#nomalCompanyId").val();
		var userName=$.trim($("#userName").val());
		var userPhone=$("#userPhone").val();
		alert("comId="+companyId);
		alert("userid="+userid);
		 var sure=confirm("是否确认设为管理员");
		   if(sure){
			   $.ajax({
					url : 'filter/member/userAccountByAdmin/assignAdminRoleBss',
					type : 'POST',
					data : {
					"newAdminId":userid,
					"companyId":companyId
					},
					cache : false,
					dataType : 'json',
					success : function(data) {
						if(data.message=="success"){
							alert("设置成功");
							$('#content').load("filter/member/memberShow1?nomalCompanyId="+
									companyId+"&userId="+userId+"&userName="+userName+"&userPhone="+userPhone);
						}else if(data.message=="error"){
							alert("设置失败");
						}
					},
					error:function(data){
						alert("网络异常");
					}
				});
		   }
	});
	$(".removeadmin").on("click",function(){
		var userid=$(this).attr("data-userID");
		var companyid=$(this).attr("data-companyid");
		var userId=$("#userId").val();
		var companyId=$("#nomalCompanyId").val();
		var userName=$.trim($("#userName").val());
		var userPhone=$("#userPhone").val();
		 var sure=confirm("是否确认回收管理员权限");
		   if(sure){
			   $.ajax({
					url : 'filter/member/userAccountByAdmin/deleteRevokeAdminRoleBss',
					type : 'POST',
					data : {
						"newAdminId":userid,
						"companyId":companyId
					},
					cache : false,
					dataType : 'json',
					success : function(data) {
						if(data.message=="success"){
							alert("回收成功");
							$('#content').load("filter/member/memberShow1?nomalCompanyId="+
									companyId+"&userId="+userId+"&userName="+userName+"&userPhone="+userPhone);
						}else if(data.message=="error"){
							alert("回收失败");
						}
					},
					error:function(data){
						alert("网络异常");
					}
				});
		   }
	});
	
});