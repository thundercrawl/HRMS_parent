$('.reDatetimepicker').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
/*-------------------------添加智慧包产品，弹出框---------------------------------*/
$(function(){
	$("#add_pro_wdm").on("click",function(){
		var info_projectid=$("#projectId option:selected").text();
		var info_productName=$("#info_productName").val();
		var info_productLevel=$("#info_productLevel option:selected").text();
		var info_validDate=$("#info_validDate").val();
		var info_expireDate=$("#info_expireDate").val();
		var info_status=$("#info_status option:selected").text();
		$('#content').load("filter/product/product_widsom");
/*	$('#content').load("filter/product/product_widsom?info_projectid="+info_projectid+"&info_productName="+info_productName+"&info_productLevel="+info_productLevel+"&info_validDate="+info_validDate+"&info_expireDate="+info_expireDate+"&info_status="+info_status);
*/	});
	/*-------------------------智慧包查询---------------------------------*/
	$("#query_info_productFir").on("click",function(){
		var info_projectid=$.trim($("#projectId option:selected").val(""));
		var info_productName=$.trim($("#info_productName").val());
		var info_productLevel=$.trim($("#info_productLevel option:selected"));
		var info_validDate=$.trim($("#info_validDate").val());
		var info_expireDate=$.trim($("#info_expireDate").val());
		var info_status=$.trim($("info_status option:selected").val());
		if(info_projectid.length>0||info_productName.length>0||info_productLevel.length>0
				||info_validDate.length>0||info_expireDate.length>0||info_status.length>0){
			$('#query_widsom_ip').val($('#query_info_product').serialize());
			$('#widsom_fy').load("filter/product/queryWdsom", $('#query_info_product').serialize(), function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
		}else{
			alert("请输入查询条件");
		}
	});
})