
$(function(){
	/*--------------------------删除费率----------------------------------*/
	$(".deleterate").click(function(){
		var rate_id=$(this).attr('data-rate-id');
		var page=$.trim($("#curPage").val());
		$.ajax({
			url:"filter/tariff/deteleRate",
			dataType:"json",
			type:"POST",
			data:{
				"rateId":rate_id
			},cache:false,
			success:function(data){	
				if(data.message=="true"){
					//$('#content').load("filter/tariff/traConFir");
					$('#projectable_ip').val($('#query_rate_fr').serialize());
					$('#projectable_rate').load("filter/tariff/traiffconfigure?page="+page, $('#query_rate_fr').serialize(), function(){
						$('.pagination>li>a').on('click', pageFunc);
					});
				}else{
				}
			},error : function(data) {
			}
		});
	});
	/*--------------------------修改费率，初始化表单----------------------------------*/
	$(".updaterate").click(function(){
		$('#span_name_add').hide();
		$('#span_unit_add').hide();
	//	$('#span_ratePr_add').hide();
		$('#span_rateType_add').hide();
		$('#span_price_add').hide();
		$('#span_ratePrecision_add').hide();
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});
		$('#rate_id_add').val($(this).attr('data-rateid'));
		$('#rate_code_add').val($(this).attr('data-ratecode'));
		$('#rate_name_add').val($(this).attr('data-ratename'));
		$('#rate_price_add').val($(this).attr('data-rateprice'));
		$('#rate_unit_sec').val($(this).attr('data-rateunit'));
		//$('#rate_ratePrecision_add').val($(this).attr('data-rateprecision'));
		$('.ratePrecision').val($(this).attr('data-rateprecision'));
		$('#rate_rateType_add').val($(this).attr('data-ratetype'));
	});

	$('#return_rate').on('click',function(){
		$('#addPdialog').dialog('destroy');
	});
	/*--------------------------提交费率表单，修改或者增加----------------------------------*/
	$("#formcheck_rate").on('click',function(){
//			$('#span_name_add').hide();
//			$('#span_unit_add').hide();
//			//$('#span_ratePr_add').hide();
//			$('#span_rateType_add').hide();
//			$('#span_price_add').hide();rate_ratePrecision_add
//			$('#span_ratePrecision_add').hide();
		var rate_id_add=$.trim($("#rate_id_add").val());
		var rate_code_add=$.trim($('#rate_code_add').val());
		var rate_name_add=$.trim($("#rate_name_add").val());
		var rate_price_add=$.trim($("#rate_price_add").val());
		var rate_unit_add=$.trim($("#rate_unit_sec option:selected").val());
		var rate_ratePr_add=$.trim(1);
		var rate_rateType_add=$.trim(1);
		var re=/^[-+]?[0-9]\d*(\.\d+)?$/;
		var bo_name_add=rate_name_add.length>0&&rate_name_add.length<=20;
		var bo_price_add=re.test(rate_price_add);
		var bo_unit_add=rate_unit_add.length>0;
		var bo_ratePr_add=rate_ratePr_add.length>0;
		var bo_rateType_add=rate_rateType_add.length>0;
		if(!bo_name_add){
			$('#span_name_add').show();
		}
		if(!bo_unit_add){
			$('#span_unit_add').show();
		}
		if(!bo_ratePr_add){
			$('#span_ratePrecision_add').show();
		}
		if(!bo_rateType_add){
			$('#span_rateType_add').show();
		}
		if(!bo_price_add){
			$('#span_price_add').show();
		}
//		if(!bo_ratePr_add){
//			$('#span_ratePrecision_add').show();
//		}
		var page=$.trim($("#curPage").val());
		if(bo_name_add&&bo_price_add&&bo_unit_add&&bo_rateType_add&&bo_ratePr_add){
			$.ajax({
				url:"filter/tariff/addBssRate",
				dataType:"json",
				type:"POST",
				data:{"code":rate_code_add,
					"rateId":rate_id_add,
					"rateName":rate_name_add,
					"ratePriceFee":rate_price_add,
					"ratePrecision":rate_ratePr_add,
					"unit":rate_unit_add,
					"rateType":rate_rateType_add
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						$('#addPdialog').dialog('destroy');
						//$('#content').load("filter/Tariff/traConFir?page="+page+"&code="+rate_code_add+"&rateName="+encodeURI(rate_name)+"&ratePriceFee="+rate_price+"&unit="+rate_unit);
						$('#projectable_ip').val($('#query_rate_fr').serialize());
						$('#projectable_rate').load("filter/tariff/traiffconfigure?page="+page, $('#query_rate_fr').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						$('#addPdialog').dialog('destroy');
					}
				},error : function(data) {
					$('#addPdialog').dialog('destroy');
				}
			});
			}
	});
});	
