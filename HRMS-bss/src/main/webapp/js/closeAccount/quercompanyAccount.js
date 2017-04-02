$(function(){
	
	//debugger;
	for(var i=0;i<$('#billListInfo > tr').length;i++){
		if($('#billListInfo > tr').eq(i).find('td').eq(1).find('a').text().length>7){
			var text=$('#billListInfo > tr').eq(i).find('td').eq(1).find('a').text();
			$('#billListInfo > tr').eq(i).find('td').eq(1).find('a').html(text.substring(0,7)+"-首付款");
		}
	}
	$("#queryonecomap").on('click',function(){
		var companyId=$("#companyId option:selected").val();
		$("#hiddencompa").val(companyId);
		$("#companyname").val($("#companyId option:selected").html());
		$('#selectcomp').dialog('destroy');
		$('#fourm_table').load("filter/account/queryCompanyAccountfir?companyId="+companyId, function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});
	
	
	$("#escquerycomp").on('click',function(){
		$('#selectcomp').dialog('destroy');
	});	
	//点击月份跳转到账单详情页面
	$('.showBill').on('click',function(){
		debugger;
		var billMonth = $(this).attr('id');
		billMonth = billMonth.replace(" ","$")
		var companyId=$("#hiddencompa").val();;
		$('#content').load("filter/account/closeCompanyAccount?companyId="+companyId+"&billMonth="+billMonth); ;  
	});
	
	$("#queryclose").on('click',function(){
		var companyId=$("#companyIdclose option:selected").val();
			$.ajax({
				url:"filter/account/CompanyAllCheckout",
				dataType:"json",
				type:"POST",
				data:{
					"companyId":companyId
				},cache:false,
				success:function(data){
					if(data.message=="true"){
						$("#hiddencompaid").val(data.errorMsg);
						$('#selectclosecom').dialog('destroy');
						var departmentList4 = Handlebars.compile($("#companycheckselect").html());
						$('#showcompanycheck').html(departmentList4(data.rows));
						$("#surecompanycheck").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
							close:function(){
								$('#surecompanycheck').dialog('destroy');
							}});
					}else{
						$('#selectclosecom').dialog('destroy');
						alert("结账失败");
					}
				},error : function(data) {
					
				}
			});
			
	});
	$("#escqueryclose").on('click',function(){
		$('#selectclosecom').dialog('destroy');
		
	});
	/*querycheck escquerycheck*/
	$("#escquerycheck").on('click',function(){
		$('#surecompanycheck').dialog('destroy');
		
	});
	$("#querycheck").on('click',function(){
	var hiddencompaid=$("#hiddencompaid").val();
	var unsettlementFee=$("#check_1").val();
	var unsettlementMPkg=$("#check_2").val();
	var unsettlementRPkg=$("#check_3").val();
	$.ajax({
		url:"filter/account/CompanySureCheckout",
		dataType:"json",
		type:"POST",
		data:{
			"companyId":hiddencompaid,
			"unsettlementFee":unsettlementFee,
			"unsettlementMPkg":unsettlementMPkg,
			"unsettlementRPkg":unsettlementRPkg
		},cache:false,
		success:function(data){
			$('#surecompanycheck').dialog('destroy');
			if(data.message=="true"){
				alert("结账成功");
			}else{
				alert(data.errorMsg);
			}
		},error : function(data) {
			alert("结账失败");
		}
	});
		
	});
});