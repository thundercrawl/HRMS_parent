$('.reDatetimepicker').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
	minDate: '-1970/01/01',
});
$(function(){
	/*--------------------------添加智慧包----------------------------------*/
	$("#wd_pro_sure").on("click",function(){
		var re_zss=/^\d+(?=\.{0,1}\d+$|$)/;
		var re=/^[0-9]*[0-9][0-9]*$/;
		var redata=/^(\d{4})-(\d{2})-(\d{2})$/;
		var productId=$.trim($("#productId").val());
		var project_Id=$.trim($("#project_Id option:selected").val());
		var product_Name=$.trim($("#product_Name").val());
		var boo_1=product_Name.length>0&&product_Name.length<=30;
		var product_Desc=$.trim($("#product_Desc").val());
		var boo_2=product_Desc.length>0&&product_Desc.length<=30;
		var product_productLevel=$.trim($("#product_productLevel option:selected").val());
		var boo4=re.test(product_productLevel);
		var product_validDate=$.trim($("#product_validDate").val());
		var boo5=redata.test(product_validDate);
		var product_status=$.trim($("#product_status option:selected").val());
		var boo6=re.test(product_status);
		var product_expireDate=$.trim($("#product_expireDate").val());
		var boo7=redata.test(product_expireDate);
		var  boodate=new Date(product_validDate)<= new Date(product_expireDate);
		var bssrate_id=$.trim($("#bssrate_id option:selected").val());
		var iteminfo=$.trim($("#iteminfo option:selected").val());  
		var hidden_projectid=$.trim($("#hidden_projectid").val());
		var hidden_itemId=$.trim($("#hidden_itemId").val());
		var hidden_spaceId=$.trim($("#hidden_spaceId").val());
		var hidden_rateId=$.trim($("#hidden_rateId").val());
		if(hidden_itemId>0){
			iteminfo=hidden_itemId;
		}
		if(hidden_rateId>0){
			bssrate_id=hidden_rateId;
		}
		var wd_incrementLevel=$.trim($("#wd_incrementLevel option:selected").val());
		var boo8=re.test(wd_incrementLevel);
		var wd_phoneCount=$.trim($("#wd_phoneCount").val());
		var boo_phonecount=re_zss.test(wd_phoneCount);
		var wd_paperCount=$.trim($("#wd_paperCount").val());
		var boo_paperCount=re.test(wd_paperCount);
		var wd_meetingroomHours=$.trim($("#wd_meetingroomHours").val());
		var boo_meetingroomHours=re.test(wd_meetingroomHours);
		var wd_seatCount=$.trim($("#wd_seatCount").val());
		var boo_seatCount=re.test(wd_seatCount);
		var wd_seatBroadbandWidth=$.trim($("#wd_seatBroadbandWidth").val());
		var boo_seatBroadbandWidth=re.test(wd_seatBroadbandWidth);
		var wd_seatBroadbandLevel=$.trim($("#wd_seatBroadbandLevel option:selected").val());
		var boo15=re.test(wd_seatBroadbandLevel);
		var wd_seatAvgConNum=$.trim($("#wd_seatAvgConNum").val());
		var boo_seatAvgConNum=re.test(wd_seatAvgConNum);
		var wd_isBackup=$.trim($("#wd_isBackup option:selected").val());
		var boo9=re.test(wd_isBackup);
		var wd_personBroadbandWidth=$.trim($("#wd_personBroadbandWidth").val());
		var boo_personBroadbandWidth=re.test(wd_personBroadbandWidth);
		var wd_personBroadbandLevel=$.trim($("#wd_personBroadbandLevel option:selected").val());
		var boo10=re.test(wd_personBroadbandLevel);
		var wd_PERSON_AVG_CON_NUM=$.trim($("#wd_PERSON_AVG_CON_NUM").val());
		var boo_PERSON_AVG_CON_NUM=re.test(wd_PERSON_AVG_CON_NUM);
		var wd_wifiRangeUse=$.trim($("#wd_wifiRangeUse option:selected").val());
		var boo12=re.test(wd_wifiRangeUse);
		var wd_collaboration=$.trim($("#wd_collaboration option:selected").val());
		var boo13=re.test(wd_collaboration);
		var wd_meetingMinute=$.trim($("#wd_meetingMinute").val());
		var boo_meetingMinute=re.test(wd_meetingMinute);
		var wd_isPhoneOendoor=$.trim($("#wd_isPhoneOendoor option:selected").val());
		var boo14=re.test(wd_isPhoneOendoor);
		var wd_isCabinetUse=$.trim($("#wd_isCabinetUse option:selected").val());
		var boo11=re.test(wd_isCabinetUse);
		var boo_hidden_projectid=hidden_projectid>0;
		var boo16=bssrate_id>0;
		var boo17=iteminfo>0;
		var capacity_add=$("#capacity_add").val();
		var boocap=re.test(capacity_add);
		if(boo_hidden_projectid){
			project_Id=hidden_projectid;
		}	
		var boo_3=re.test(project_Id);
		$("#spanproduct_Name").hide();
		$("#spanproduct_Desc").hide();
		$("spanproject_Id").hide();
		$("#spanproduct_productLevel").hide();
		$("#spanproduct_validDate").hide();
		$("#spanproduct_status").hide();
		$("#spanproduct_expireDate").hide();
		$("#spanwd_isBackup").hide();
		$("#spanwd_incrementLevel").hide();
		$("#spanwd_personBroadbandLevel").hide();
		$("#spanwd_wifiRangeUse").hide();
		$("#spanwd_collaboration").hide();
		$("#spanwd_isPhoneOendoor").hide();
		$("#spanwd_seatBroadbandLevel").hide();
		$("#spanbssrate_id").hide();
		$("#spanwd_phoneCount").hide();
		$("#spanwd_paperCount").hide();
		$("#spanwd_meetingroomHours").hide();
		$("#spanwd_seatBroadbandWidth").hide();
		$("#spanwd_seatAvgConNum").hide();
		$("#spanwd_personBroadbandWidth").hide();
		$("#spanwd_PERSON_AVG_CON_NUM").hide();
		$("#spanwd_meetingMinute").hide();
		$("#spanwd_seatCount").hide();
		$("#spaniteminfo").hide();
		$("#spanwd_isCabinetUse").hide();
		$("#spancapacity").hide();
		if(boo_3&&boo_2&&boo_1&&boo_phonecount&&boo_paperCount&&boo_meetingroomHours&&boo_seatCount&&boo_seatBroadbandWidth
				&&boo_seatAvgConNum&&boo_personBroadbandWidth&&boo_PERSON_AVG_CON_NUM&&boo_meetingMinute
				&&boo4&&boo5&boo6&&boo7&&boo8&&boo9&&boo10&boo12&boo13&boo14&&boo16&&boo15&&boo17&&boo11&&boocap&&boodate){
			$.ajax({
				url:"filter/product/saveWdisomPro",
				dataType:"json",
				type:"POST",
				data:{"productId":productId,
					"projectId":project_Id,
					"productName":product_Name,
					"productDesc":product_Desc,
					"productLevel":product_productLevel,
					"incrementLevel":wd_incrementLevel,
					"capacity":capacity_add,
					"rateId":bssrate_id,
					"itemId":iteminfo,
					"spaceId":hidden_spaceId,
					"status":product_status,
					"validDate":product_validDate,
					"expireDate":product_expireDate,
					"phoneCount":wd_phoneCount,
					"paperCount":wd_paperCount,
					"meetingroomHours":wd_meetingroomHours,
					"seatCount":wd_seatCount,
					"seatBroadbandWidth":wd_seatBroadbandWidth,
					"seatBroadbandLevel":wd_seatBroadbandLevel,
					"seatAvgConNum":wd_seatAvgConNum,
					"isBackup":wd_isBackup,
					"personBroadbandWidth":wd_personBroadbandWidth,
					"personBroadbandLevel":wd_personBroadbandLevel,
					"personAvgConNum":wd_PERSON_AVG_CON_NUM,
					"wifiRangeUse":wd_wifiRangeUse,
					"collaboration":wd_collaboration,
					"meetingMinute":wd_meetingMinute,
					"isPhoneOendoor":wd_isPhoneOendoor,
					"isCabinetUse":wd_isCabinetUse,
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						$('#content').load("filter/product/product_widsom_Fir");
					}else{
						alert("失败");
					}

				},error : function(data) {
					alert("失败")
				}});}else{
					if(!boocap){
						$("#spancapacity").show();
					}	
					if(!boo_1){
						$("#spanproduct_Name").show();
					}
					if(!boo_2){
						$("#spanproduct_Desc").show();
					}
					if(!boo_3){
						$("#spanproject_Id").show();
					}
					if(!boo4){
						$("#spanproduct_productLevel").show();
					}
					if(!boo5){
						$("#spanproduct_validDate").show();
					}			
					if(!boo6){
						$("#spanproduct_status").show();
					}
					if(!boo7){
						$("#spanproduct_expireDate").show();
					}
					if(!boodate){
						$("#spanproduct_status").show();
						$("#spanproduct_expireDate").show();
					}
					if(!boo8){
						$("#spanwd_incrementLevel").show();
					}
					if(!boo9){
						$("#spanwd_isBackup").show();
					}
					if(!boo10){
						$("#spanwd_personBroadbandLevel").show();
					}
					if(!boo11){
						$("#spanwd_isCabinetUse").show();
					}
					if(!boo12){
						$("#spanwd_wifiRangeUse").show();
					}
					if(!boo13){
						$("#spanwd_collaboration").show();
					}
					if(!boo14){
						$("#spanwd_isPhoneOendoor").show();
					}
					if(!boo15){
						$("#spanwd_seatBroadbandLevel").show();
					}
					if(!boo16){
						$("#spanbssrate_id").show();
					}
					if(!boo17){
						$("#spaniteminfo").show();
					}
					if(!boo_phonecount){
						$("#spanwd_phoneCount").show();
					}
					if(!boo_paperCount){
						$("#spanwd_paperCount").show();
					}
					if(!boo_meetingroomHours){
						$("#spanwd_meetingroomHours").show();
					}
					if(!boo_seatBroadbandWidth){
						$("#spanwd_seatBroadbandWidth").show();
					}
					if(!boo_seatAvgConNum){
						$("#spanwd_seatAvgConNum").show();
					}
					if(!boo_personBroadbandWidth){
						$("#spanwd_personBroadbandWidth").show();
					}
					if(!boo_PERSON_AVG_CON_NUM){
						$("#spanwd_PERSON_AVG_CON_NUM").show();
					}
					if(!boo_meetingMinute){
						$("#spanwd_meetingMinute").show();
					}
					if(!boo_seatCount){
						$("#spanwd_seatCount").show();
					}
				}
	});
	/*-------------------------返回上一层----------------------------------*/
	$("#wd_pro_esc").on("click",function(){
		$('#content').load("filter/product/product_widsom_Fir");
	/*	window.location.href="filter/product/product_widsom_Fir";*/
	})


})

