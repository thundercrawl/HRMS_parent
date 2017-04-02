$('.reDatetimepicker').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
$("#exportProductInfo").on("click",function(){
	var projectId=$.trim($("#projectId option:selected").val());
	var productName=$.trim($("#info_productName").val());
	var productLevel=$.trim($("#info_productLevel option:selected").val());
	var productType=$.trim($("#productType option:selected").val());
	var validDate=$.trim($("#info_validDate").val());
	var expireDate=$.trim($("#info_expireDate").val());
	var status=$.trim($("info_status option:selected").val());
	
	window.location.href="filter/exprot/exportProductInfo?productName="+productName+"&projectId="+projectId
	+"&productLevel="+productLevel+"&productType="+productType+"&validDate="+validDate+"&expireDate="+expireDate
	+"&status="+status;

});
/*-------------------------产品查询---------------------------------*/
$("#query_info_productFir").on("click",function(){
	var info_productName=$.trim($("#info_productName").val());
	var info_productLevel=$.trim($("#info_productLevel option:selected"));
	var info_validDate=$.trim($("#info_validDate").val());
	var info_expireDate=$.trim($("#info_expireDate").val());
	var info_status=$.trim($("info_status option:selected").val());
	if(info_productName.length>0||info_productLevel.length>0||info_validDate.length>0||info_expireDate.length>0||info_status.length>0){
		$('#query_info_producthi').val($('#query_info_product').serialize());
		$('#product_info_de').load("filter/product/productquery", $('#query_info_product').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});

	}else{
		alert("请输入查询条件");
	}


});

/*------------------------添加产品前，清空原来的数据--------------------------------*/
$("#add_pro_info").on('click',function(){
	$("#capacity").val('');
	$("#project_Id").val('');
	$("#product_Name").val('');
	$("#product_Desc").val('');
	$("#product_validDate").val('');
	$("#product_productLevel").val('');
	$("#product_status").val('');
	$("#product_expireDate").val('');
	$("#bssrate_id").val('');
	$("#iteminfo").val('');
	$("#space_id").val('');
	$("#assert_id").val('');

	$("#add_Pdialog_pro").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
		close:function(){
			$('#add_Pdialog').dialog('destroy');
		}});
})

