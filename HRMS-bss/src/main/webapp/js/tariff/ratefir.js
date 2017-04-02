/*--------------------------查询费率----------------------------------*/
$(function(){
	$("#query_rate").click(function(){
		//var rate_name=$.trim($("#rate_name").val());
	//	var rate_price=$.trim($("#rate_price").val());
		//var rate_unit=$.trim($("#rate_unit option:selected").val());
		//if(rate_name.length>0||rate_price.length>0||rate_unit.length>0){
			$('#projectable_ip').val($('#query_rate_fr').serialize());
			$('#projectable_rate').load("filter/tariff/traConQuery", $('#query_rate_fr').serialize(), function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
		/*}else{
			alert("请输入查询条件");
		}*/

	});
	/*--------------------------添加费率初始化数据----------------------------------*/
	$('#add_rate').on('click',function(){
		$('#span_name_add').hide();
		$('#span_unit_add').hide();
		//$('#span_ratePr_add').hide();span_ratePrecision_add
		$('#span_rateType_add').hide();
		$('#span_price_add').hide();
		$('#span_ratePrecision_add').hide();
		$('#rate_id_add').val("");
		$('#rate_code_add').val("");
		$('#rate_name_add').val("");
		$('#rate_price_add').val("");
		$('#rate_ratePrecision_add').val("");
		$('#rate_rateType_add').val("");
		$("#rate_unit_sec").val("");
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});


	});
	/*--------------------------批量删除，本js未用----------------------------------*/
	$("#pl_delete").click(function(){
		var chk_value =[]; 
		$('input[name="ratepldl"]:checked').each(function(){ 
			chk_value.push($(this).val()); 
			$.ajax({
				url:"filter/tariff/batch",
				dataType:"json",
				type:"POST",
				data:{
					"chk_value":chk_value
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						$('#content').load("filter/tariff/traConFir");
					}else{
					}
				},error : function(data) {
				}
			});

		}); 

	});
})
