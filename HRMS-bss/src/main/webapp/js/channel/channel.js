$('.reDatetimepicker').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
$(function() {
	/*-------------------------查询渠道---------------------------------*/
	$("#query_my_channel").on("click",function(){
		$("#channelCurpage").val(0);
		$('#query_info_channel').val($('#query_my_channel').serialize());
		$('#channel_info_de').load("filter/channel/findMyChannel", $('#query_my_channel').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});

	/*------------------------新增前，清空原来的数据--------------------------------*/
	$("#add_channel_info").on('click',function(){
		$("#channel_Name").val('');
		$("#channel_phone").val('');
		$("#channel_Address").val('');
		$("#channel_Email").val('');
		$("#spanchannel_Name").hide();
		$("#spanchannel_Email").hide();
		$("#spanchannel_phone").hide();
		$("#add_Pdialog_pro").dialog({ modal:true,autoOpen: true,height:'auto', width:450,resizable:false
		});
	});
	$("#formcheck_product_sure").on('click',function(){
		var channel_Name=$.trim($("#channel_Name").val());
		var re=/^[0-9]*[0-9][0-9]*$/;
		var channel_phone=$.trim($("#channel_phone").val());
		var boo0=re.test(channel_phone);
		var channel_Type=$.trim($("#channel_Type option:selected").val());
		var channel_Email=$.trim($("#channel_Email").val());
		var boo_1=channel_Name.length>0&&channel_Name.indexOf(" ") == -1;
		var channel_Address=$.trim($("#channel_Address").val());
		var boo_2=channel_Email.length>0&&channel_Email.indexOf(" ") == -1;
		
		$("#spanchannel_Name").hide();
		$("#spanchannel_Email").hide();
		$("#spanchannel_phone").hide();
		if(!boo_1){
			$("#spanchannel_Name").show();
			$("#spanchannel_Name").html("渠道名称不能为空");
			return ;
		}
		if(!boo_2){
			$("#spanchannel_Email").show();
			$("#spanchannel_Email").html("邮箱不能为空");
			return ;
		}
		if(!boo0){
			$("#spanchannel_phone").show();
			$("#spanchannel_phone").html("渠道手机号格式错误");
			return ;
		}
		
		if(boo_1&&boo_2&&boo0){
			$.ajax({
				url:"filter/channel/saveNewchannel",
				dataType:"json",
				type:"POST",
				data:{"channelName":channel_Name,
					"channelPhone":channel_phone,
					"channelAddress":channel_Address,
					"channelEmail":channel_Email,
					"channelType":channel_Type
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						$('#add_Pdialog_pro').dialog('destroy');
						$('#channel_info_de').load("filter/channel/findMyChannel", $('#query_my_channel').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						alert(data.message);
						//$('#add_Pdialog_pro').dialog('destroy');
					}
				},error : function(data) {
					$('#add_Pdialog_pro').dialog('destroy');
				}});
		}
	});
	/*--------------------------关闭增加产品弹框----------------------------------*/
	$("#formcheck_product_esc").on("click",function(){
		$('#add_Pdialog_pro').dialog('destroy');
	});
	/*--------------------------关闭弹框----------------------------------*/
	$("#return_product_esc").on("click",function(){
		$('#add_Pdialog_pro').dialog('destroy');
	});
});


	

