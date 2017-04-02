
$(function(){
	/*--------------------------查询科目----------------------------------*/
	$("#query_item").click(function(){
		var item_name=$.trim($("#item_name").val());
		var item_type=$.trim($("#item_type_find option:selected").val());
		$('#query_item_ip').val($('#query_item_fr').serialize());
//		if(item_name.length>0||item_type.length>0){
			$('#projectable_item').load("filter/tariff/query",$('#query_item_fr').serialize(), function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
//		}else{
//			alert("请输入查询条件");
//		}
	});
	/*--------------------------添加科目，清空原来的信息----------------------------------*/
	$("#add_Project").click(function(){
		$('#item_code_add').val('');
		$('#item_name_add').val('');
		$('#Item_type_add').val('');
		$('#contentdesc').val('');
		$('#parent_sec').val('');
		$('#Item_status').val('');
		$('#span_name').hide();
		$('#span_type').hide();
		$('#contentspan').hide();
		$('#span_status').hide();
		
		$("#add_Pdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#add_Pdialog').dialog('destroy');
			}});

	});
});	
