$('.reDatetimepicker').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
$(function(){
	/*--------------------------修改智慧包产品----------------------------------*/
	$(".revise_prowdom_id").on("click",function(){
		var wdomproduct=$(this).attr('data-wdomproduct-id');
		var rateId=$(this).attr('data-rateid');
		$(".changeRate2").val(rateId);
		$('#content').load("filter/product/productWidsomRe?wdpro_id="+wdomproduct,function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});
	/*-------------------------删除智慧包产品----------------------------------*/
	$(".delete_prodom_id").on("click",function(){
		var wdompro=$(this).attr('data-productwd-Id');
		$('#content').load("filter/product/productWidsomDele?productId="+wdompro, function(){
			$('.pagination>li>a').on('click', pageFunc);
		});

	});
	/*--------------------------关闭弹框----------------------------------*/
	$("#formdetail").on("click",function(){
		$('#add_Pdialogdetail').dialog('destroy');
	});
	/*--------------------------修改智慧包前准备，即是，查询出，要修改的智慧包产品----------------------------------*/
	$(".detail_prowdm_id").on("click",function(){
		var productid=$(this).attr('data-detail-id');
		$.ajax({
			url:"filter/product/detailwdm",
			method:"post",
			dataType:"json",
			type:"POST",
			data:{
				"productid":productid
			},
			success : function(data) {
				if(data.message=="true"){
					$("#detail_product").val(data.lists[0].productName)
					$("#detail_01").val(data.rows[0].incrementLevelName);
					$("#detail_1").val(data.rows[0].phoneCount);
					$("#detail_2").val(data.rows[0].paperCount);
					$("#detail_3").val(data.rows[0].meetingroomHours);
					$("#detail_4").val(data.rows[0].seatCount);
					$("#detail_5").val(data.rows[0].seatBroadbandWidthName);
					$("#detail_6").val(data.rows[0].seatBroadbandLevelName);
					$("#detail_7").val(data.rows[0].seatAvgConNum);
					$("#detail_8").val(data.rows[0].isBackUpName);
					$("#detail_9").val(data.rows[0].personBroadbandWidthName);
					$("#detail_10").val(data.rows[0].personBroadbandLevelName);
					$("#detail_11").val(data.rows[0].personAvgConNum);
					$("#detail_14").val(data.rows[0].meetingMinute)
					$("#detail_12").val(data.rows[0].wifiRangeUseName);	
					$("#detail_13").val(data.rows[0].collaborationName);
					$("#detail_15").val(data.rows[0].isPhoneOendoorName);
					$("#detail_16").val(data.rows[0].isCabinetUseName);

					$("#add_Pdialogdetail").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
						close:function(){
							$('#add_Pdialogdetail').dialog('destroy');
						}});
				}

			},
			error : function(data) {
			}
		});

		/*--------------------------关闭弹框----------------------------------*/
		$("#formdetail").on('click',function(){
			$('#add_Pdialogdetail').dialog('destroy');
		})

	});


})

