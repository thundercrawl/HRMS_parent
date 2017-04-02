
$(function(){
	$("#selected_result").change(function(){ //下拉框改变时取得值
		alert($(this).val());

	});
	/*--------------------------增加科目，提交表单----------------------------------*/
	$("#formcheck_sure").on('click',function(){
		var re=/^[0-9]*[0-9][0-9]*$/;
		$('#span_name').hide();
		$('#span_type').hide();
		$('#contentspan').hide();
		var item_code_add=$.trim($("#item_code_add").val());
		var item_name_add=$.trim($("#item_name_add").val());
		var item_type_add=$.trim($("#Item_type_add option:selected").val());
		var parent_sec=1;
		var content=$("#contentdesc").val();
		var status=$("#Item_status option:selected").val();
		
		var boo_status=re.test(status);
		var boo_name=item_name_add.length<=20&&item_name_add.length>0;
		var boo_type=item_type_add.length<=4&&item_type_add.length>0;
		var boo_content=content.length<=512&&content.length>0;
		if(!boo_name){
			$('#span_name').show();
		}
		if(!boo_type){
			$('#span_type').show();
		}
		if(!boo_content){
			$('#contentspan').show();

		}
		if(!boo_status){
			$('#span_status').show();
		}
		if(boo_name&&boo_type&&boo_status&&boo_content){
			var page=$.trim($("#curPage").val());
			$.ajax({
				url:"filter/tariff/item",
				dataType:"json",
				type:"POST",
				data:{
					"code":item_code_add,
					"name":item_name_add,
					"type":item_type_add,
					"content":content,
					"parentCodeId":parent_sec,
					"status":status
				},cache:false,
				success:function(data){	
					if(data.message=="3"){
						alert(data.errorMsg);
						//$('#add_Pdialog').dialog('destroy');
					}else if(data.message=="2"){
						alert("系统异常！请稍后再试！");
						$('#add_Pdialog').dialog('destroy');
						
					}else if(data.message=="1"){
						alert("添加成功！");
						$('#add_Pdialog').dialog('destroy');
						$('#projectable_item').load("filter/tariff/findItemCurPage?page="+page,$('#query_item_fr').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}

				},error : function(data) {
					$('#add_Pdialog').dialog('destroy');
				}
			});}else{
				return ;
			}

	});
	$("#return_esc").on('click',function(){

		$('#add_Pdialog').dialog('destroy');

	});
	/*删除科目*/
	$(".deleteitem").click(function(){
		if(confirm("确认删除？")){
			var page=$(this).attr('data-page');
			var itemcode=$(this).attr('data-itemcode');
//			var item_name=$.trim($("#item_name").val());
//			var item_type=$.trim($("#item_type_find option:selected").val());
			$.ajax({
				url:"filter/tariff/deleteItem",
				dataType:"json",
				type:"POST",
				data:{
					"code":itemcode
				},cache:false,
				success:function(data){	
					if(data.message=="2"){
						alert(data.errorMsg);
					}else if(data.message=="1"){
						$('#projectable_item').load("filter/tariff/findItemCurPage?page="+page,$('#query_item_fr').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}
				},error : function(data) {
				}
			});
		}
		
	});
	/*--------------------------修改表单，初始化表单中的数据----------------------------------*/
	$(".updateitem").click(function(){
		$('#span_name').hide();
		$('#span_type').hide();
		$('#contentspan').hide();
		$('#span_status').hide();
		$('#item_code_add').val($(this).attr('data-itemcode'));
		$('#item_name_add').val($(this).attr('data-itemname'));
		$('#Item_type_add').val($(this).attr('data-itemclass'));
		
		$('#contentdesc').val($(this).attr('data-itemdesc'));
		$(".Item_status").val($(this).attr('data-status'));
		//$("#Item_status option:selected").val($(this).attr('data-status'));
		$("#add_Pdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#add_Pdialog').dialog('destroy');
			}});
	});



});	
