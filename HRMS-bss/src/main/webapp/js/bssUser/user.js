$(function(){
	showallorg()
	downMenu("#orgName","#project_ul");
	$('#formParam').val($('#usergroup').serialize());
	$('#addUser').on('click',function(){
		$("#addUserdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:344,resizable:false,
			close:function(){
				$('#addUserdialog').dialog('destroy');
			}});
		$('#username').val('');
		$('#gender').val('男');
		$('#age').val('');
		$('#phone').val('');
		$('#email').val('');
		$('#idNum').val('');
		$('#userid').val(0);
		
		$('#Lname').hide();
		$('#psw').hide();
		$('#uname').hide();
		$('#phonespan').hide();
		$('#agespan').hide();
		$('#emailspan').hide();
		$('#idNumspan').hide();
	})
	
	$('#return').on('click',function(){
		$('#addUserdialog').dialog('destroy');
	})
	$("body").delegate(".updatePro","click",function(){
		$("#updateUserdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:344,resizable:false,
			close:function(){
				$('#updateUserdialog').dialog('destroy');
			}});
		$('#UserName').val($(this).attr('data-username'));
		$('#Gender').val($(this).attr('data-gender'));
		$('#UserLname').val($(this).attr('userLname'));
		$('#Age').val($(this).attr('data-age'));
		$('#Phone').val($(this).attr('data-phone'));
		$('#Email').val($(this).attr('data-email'));
		$('#IdNum').val($(this).attr('data-idNum'));
		$('#Userid').val($(this).attr('data-userid'));
		$('#Password').val($(this).attr('password'));
	})
	$('#returnUser').on('click',function(){
		$('#updateUserdialog').dialog('destroy');
	})
	$('#formcheck').on('click',function(){debugger
		var username = $('#username').val();
	    username = username.replace(" ","+");
		var gender = $('#gender').val();
		var age = $('#age').val();
		var phone = $('#phone').val();
		var email = $('#email').val();
		var idNum = $('#idNum').val();
		var lname = $('#userLname').val();
		lname=lname.replace(" ","+");
		var password = $('#password').val();
		var page = $('#page').val();
		var userid = $('#userid').val();
		var name = 0;
		var ln = 0;
		if(lname==""){
			$('#Lname').show();
			ln = 0;
		}else{
			$('#Lname').hide();
			ln = 1;
		}
		var pass = 0;
		if(password==""||password.length<6||password.length>64){
			$('#psw').show();
			pass = 0;
		}else{
			$('#psw').hide();
			pass = 1;
		}
		if(uname==""){
			$('#uname').show();
			name = 0;
		}else{
			$('#uname').hide();
			name = 1;
		}
		var phflag = 0;
		var ph = /^(1[0-9]{10})$/;
		if(!ph.test(phone)){
			$('#phonespan').show();
			phflag = 0;
		}else{
			$('#phonespan').hide();
			phflag = 1;
		}
		var ageflag = 1;
		if(age.trim()!=""){
			var ages = /[1-9]{2}/;
			if(!ages.test(age)){
				$('#agespan').show();
				ageflag = 0;
			}else{
				$('#agespan').hide();
				ageflag = 1;
			}
		}
		var em = 1;
		if(email.trim()!=""){
			var emails = /\w@\w*\.\w/;
			if(!emails.test(email)){
				$('#emailspan').show();
				em = 0;
			}else{
				$('#emailspan').hide();
				em = 1;
			}
		}
		var idnum = 1;
		if(idNum.trim()!=""){
			var id = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
			if(!id.test(idNum)){
				$('#idNumspan').show();
				idnum = 0;
			}else{
				$('#idNumspan').hide();
				idnum = 1;
			}
		}
		if(phflag==1&&em==1&&idnum==1&&name==1&&pass==1){
			$('#content').load("filter/bssuser/saveOrupdateUser?username="+username+"&gender="+gender+
					"&age="+age+"&phone="+phone+"&email="+email+"&idNum="+idNum+"&page="+page+
					"&lname="+lname+"&password="+password+"&userid="+userid);
			$('#addUserdialog').dialog('destroy');
		}
	})
	$("body").delegate(".deleteUser","click",function(){
		$('#content').load('filter/bssuser/deleteuser?userid='+$(this).attr('data-userid')+"&page="+$(this).attr('data-page')+"&status="+
				$(this).attr('status'));
	})
	
	$('#findproject').click(function(){
		var username = $('#adminRname').val();
			$('#formParam').val($('#usergroup').serialize());
			$('#projectable').load("filter/bssuser/finduser",$('#usergroup').serialize(), function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
			$('#textspan').hide();
			downMenu("#orgName","#project_ul");
	}) 
	$('#userName').on('focus',function(){
		$('#textspan').hide();
	})
	
	$('#updateUser').on('click',function(){
		var username = $('#UserName').val();
		 username = username.replace(" ","+");
		var gender = $('#Gender').val();
		var age = $('#Age').val();
		var phone = $('#Phone').val();
		var email = $('#Email').val();
		var idNum = $('#IdNum').val();
		var lname = $('#UserLname').val();
		lname=lname.replace(" ","+");
		var page = $('#page').val();
		var userid = $('#Userid').val();
		var password = $('#Password').val();
		var name = 0;
		var ln = 0;
		var adminRname = $('#adminRname').val();
		var orgName = $('#orgName').val();
		if(lname.trim()==""){
			$('#Lname').show();
			ln = 0;
		}else{
			$('#Lname').hide();
			ln = 1;
		}
		if(username.trim()==""){
			$('#suname').show();
			name = 0;
		}else{
			$('#suname').hide();
			name = 1;
		}
		var phflag = 0;
		var ph = /^(1[0-9]{10})$/;
		if(!ph.test(phone)){
			$('#sphonespan').show();
			phflag = 0;
		}else{
			$('#sphonespan').hide();
			phflag = 1;
		}
		var ageflag = 1;
		if(age!=""){
			var ages = /[1-9]{2}/;
			if(!ages.test(age)){
				$('#sagespan').show();
				ageflag = 0;
			}else{
				$('#sagespan').hide();
				ageflag = 1;
			}
		}
		var em = 1;
		if(email.trim()!=""){
			var emails = /\w@\w*\.\w/;
			if(!emails.test(email)){
				$('#semailspan').show();
				em = 0;
			}else{
				$('#semailspan').hide();
				em = 1;
			}
		}
		var idnum = 1;
		if(idNum.trim()!=""){
			var id = /(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
			if(!id.test(idNum)){
				$('#sidNumspan').show();
				idnum = 0;
			}else{
				$('#sidNumspan').hide();
				idnum = 1;
			}
		}
		if(phflag==1&&em==1&&idnum==1&&name==1){
			$('#content').load('filter/bssuser/saveOrupdateUser?username='+username+"&gender="+gender+
					"&age="+age+"&phone="+phone+"&email="+email+"&idNum="+idNum+"&userid="+userid+"&page="+page+
					"&lname="+lname+"&password="+password+"&orgName="+orgName+"&adminRname="+adminRname);
			$('#updateUserdialog').dialog('destroy');
		}
	})
	$("body").delegate(".repassword","click",function(){
		var repassword = confirm("你确定要重置该用户的密码？");
		var userid = $(this).attr('data-userid');
		if (repassword==true){
			$.ajax({
				url :"filter/bssuser/repassword",
				type : "POST",
				dataType : 'json',
				data : {
					'userid' : userid,
				},
				success : function(data){
					if(data[0].password=="密码重置失败"){
						alert(data[0].password+"!");
					}else{
						alert("密码重置成功!\n"+"重置后的密码为:"+data[0].password);
					}
				}
			})
		}
	})
	$("body").delegate(".adduserorg","click",function(){
		$("#orgdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:344,resizable:false,
			close:function(){
				$('#orgdialog').dialog('destroy');
			}});
		$('#olderorgid').val($(this).attr('data-orgid'));
		$('#userorgid').val($(this).attr('data-userid'));
	})
	
	$('#returnUserorg').click(function(){
		$('#orgdialog').dialog('destroy');
	})
	showuser();
	$('#updateUserorg').click(function(){
		var orgid = $('input[name="org"]:checked').val();
		$('#orgdialog').dialog('destroy');
		$('#content').load('filter/bssuser/adduserorg?orgid='+orgid+'&userid='
				+$('#userorgid').val()+'&page='+$('#pages').val()+'&oldorgid='
				+$('#olderorgid').val());
	})
	$('#exportProject').click(function(){
		var orgName=$('#orgName').val();
		var adminRname=$('#adminRname').val();
		window.open("filter/exportUser/exportUserInfo?adminRname="+adminRname+"&orgName="+orgName);
	})
})
function showuser(){
	$.ajax({
		url :"filter/bssuser/showuserorg",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			for(var i=0;i<data.length;i++){
				str = " <tr>"+
                      "<td><input type=\"radio\" name=\"org\" value="+data[i].orgid+"></td>"+
                      "<td>"+data[i].orgname+"</td>"+
                      "</tr>";
				$('#userorgtable').append(str);
			}
			document.getElementsByName("org")[0].checked="checked";
		}
	})
}

function showallorg(){
	$.ajax({
		url :"filter/bssuser/showallOrgan",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			$('#project_ul').html(str);
			$('#project_ul').append("<li>全部</li>");
			for(var i=0;i<data.length;i++){
				str = "<li>"+data[i].orgname+"</li>";
				$('#project_ul').append(str);
			}
			$('.project_ul > li').click(function(){
				$('#orgName').val($(this).html());
			})
		}
	})
}
function downMenu(clickClass,dropMenu){
    $(clickClass).click(function(event){
        event=event||window.event;
        event.stopPropagation();
        $(dropMenu).toggle();
    });
    $(dropMenu).click(function(){
        $(dropMenu).toggle();
    });
    $(document).click(function(e){
        $(dropMenu).hide();
    });
  }
