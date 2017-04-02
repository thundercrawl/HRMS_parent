
function findAccounts(){
	var companyname=$.trim($("#companyname").val());//公司名
	var userPhone=$("#userPhone").val();//用户名
	if($.trim(companyname).length>0||$.trim(userPhone).length>0){
		$.ajax({
			url:"filter/account/queryCompany",
			dataType:"json",
			type:"POST",
			data:{
				"companyName":companyname,
				"userPhone":userPhone
			},cache:false,
			success:function(data){	
				if(data.message=="true"||data.message=="1"){
					var departmentList4 = Handlebars.compile($("#companyselect").html());
					$('#companyId').html(departmentList4(data.lists));
					(function ($) {
						$("#selectcomp").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
							close:function(){
								$('#selectcomp').dialog('destroy');
							}});
					})(jQuery);
				 
				}else{
					if(data.message=="0"){
						alert("对不起，没有查到任何信息！")
					};
				}
			
//				if(data.message=="1"){
//					$("#hiddencompa").val(data.lists[0].companyId);
//					$('#fourm_table').load("filter/account/queryCompanyAccountfir?&companyId="+data.lists[0].companyId, function(){
//						$('.pagination>li>a').on('click', pageFunc);
//					});
//				}else{}
			},error : function(data) {
			}
		});
	}else{
		if($.trim(companyname).length==0){
			alert("请输入公司名");
		}else{
			alert("请输入手机号");
		}
	}
//	$('#content').load("filter/account/showCompanyAccount?&companyName="+encodeURI(companyname));
	
	
	
};


function closeCompanyAccount(){	
	var companyname=$("#companyname").val();//公司名
	var userPhone=$("#userPhone").val();//用户名
	if($.trim(companyname).length>0||$.trim(userPhone).length>0){
		$.ajax({
			url:"filter/account/queryCompany",
			dataType:"json",
			type:"POST",
			data:{
				"companyName":companyname,
				"userPhone":userPhone
			},cache:false,
			success:function(data){	
				if(data.message=="1"){
					var departmentList4 = Handlebars.compile($("#companycloseselect").html());
					$('#companyIdclose').html(departmentList4(data.lists));
					$("#selectclosecom").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
						close:function(){
							$('#selectclosecom').dialog('destroy');
						}});
					
					
				}else{
					if(data.message=="true"){
						var departmentList4 = Handlebars.compile($("#companycloseselect").html());
						$('#companyIdclose').html(departmentList4(data.lists));
						$("#selectclosecom").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
							close:function(){
								$('#selectclosecom').dialog('destroy');
							}});
					 
					}else{
						if(data.message=="0"){
							$('#companyIdclose').html("");
							alert("对不起，没有查到任何信息！")
						};
					}
				}
			},error : function(data) {
			}
		});
	}else{
		if($.trim(companyname).length==0){
			alert("请输入公司名");
		}else{
			alert("请输入手机号");
		}
	}
	
	
//	var companyname=$("#companyname").val();//输入的公司名
//	var companyName=$("#company").val();//查询出的公司名
//	var companyId=$("#hiddencompa").val();
//	if(companyName!=null&&companyName!=""){
//		$('#content').load("filter/account/closeCompanyAccount?companyId="+companyId+"&billMonth=");
//	}else if(companyname!=null&&companyname!=""){
//		$('#content').load("filter/account/closeCompanyAccount?companyId="+companyId+"&billMonth=");
//	}else {
//		alert("请输入要结账的公司名！");
//	}
}


