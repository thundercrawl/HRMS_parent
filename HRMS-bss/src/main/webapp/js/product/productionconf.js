$('.reDatetimepicker').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});

var departmentList4 = Handlebars.compile($("#departmentList4").html());

var initData = [];
$(function (){
	/*--------------------------配置智慧包产品和优惠产品，先查出，该产品由选择的智慧包和优惠产品----------------------------------*/
	$(".pzwidsomas").on('click',function(){
		var productId=$(this).attr('data-productidgw');
		var page=$(this).attr('data-pagegw');
		var projectId=$(this).attr('data-project');
		$("#assert_project").val($(this).attr('data-project'));
		$("#assert_widsom").val($(this).attr('data-productidgw'));
		$("#product_id").html($(this).attr('data-productname')+"配置智慧包和优惠产品");
		$("#pagefont").val($(this).attr('data-pagegw'));
		/*-------------------------查询可配置的智慧包产品---------------------------------*/
		$.ajax({
			url:"filter/product/queryWdm",
			dataType:"json",
			type:"POST",
			data:{
				"productId":productId,
				"projectId":projectId
			},cache:false,
			async:false, 
			success:function(data){	
				if(data.message=="true"){
					$('#wdisomadd').html(departmentList4(data.rows));
					$("#add_Pdialog_prowidsom").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
						close:function(){
							$('#add_Pdialog_prowidsom').dialog('destroy');
						}});
					
				}else{
					alert("失败");
					return ;
				}
			},error : function(data) {
			}});
	});
	/*--------------------------给产品配置优惠产品和智慧包 提交表单----------------------------------*/
	$("#sure_pro_wdm_1").on('click',function(){
		var chk_value=[];
		$('input[name="product_wdmname"]:checked').each(function(){ 
			chk_value.push($(this).val()); 
		});
		var wdm=[];
		for( var i=0;i<chk_value.length;i++){
			wdm.push(chk_value[i]+"|"+$("#"+chk_value[i]+"se option:selected").val())
		}
		var whdmst="";
		for(var j=0;j<wdm.length;j++){
			whdmst=whdmst+":"+wdm[j];
		}
		var assert_project=$("#assert_project").val();
		var productId=$("#assert_widsom").val();
		var product_id=$("#product_id").val();
		var product=$("#assert_widsom").val();
		var pagefont=$("#pagefont").val();
		if(wdm.length>0){
				$.ajax({
					url:"filter/product/saveWdmPro",
					dataType:"json",
					type:"POST",
					data:{"productId":productId,
						"wdm":whdmst
					},cache:false,
					success:function(data){	
						if(data.message=="true"){
							$('#add_Pdialog_prowidsom').dialog('destroy');
						}else{
							alert("失败")
							$('#add_Pdialog_prowidsom').dialog('destroy');
						}

					},error : function(data) {
						$('#add_Pdialog_prowidsom').dialog('destroy');
					}});

		}else{
			alert("请选择要配置的智慧包和优惠产品");
		}
	});
	$("#esc_pro_wdm_1").on('click',function(){

		$('#add_Pdialog_prowidsom').dialog('destroy');

	});
	/*--------------------------修改产品----------------------------------*/
	$(".revise_product").on('click',function(){
		var page=$(this).attr('data-page1');
		$("#productitem_Id").val($(this).attr('data-itemid'));
		$("#hiddenrate_Id").val($(this).attr('data-rateid'));
		$("#product_productLevelxg").val($(this).attr('data-productLeavl'));
		$("#product_statusxg").val($(this).attr('data-status'));
		$("#productspace_Id").val($(this).attr('data-space'));
		$("#product_Idxg").val($(this).attr('data-productid1'));
		$("#project_Idxg").val($(this).attr('data-productid1'));
		$("#product_Namexg").val($(this).attr('data-productName'));
		$("#product_Descxg").val($(this).attr('data-productDesc'));
		$("#product_statusxg option:selected").val($(this).attr('data-status'));
		$("#product_productLevelxg option:selected").val($(this).attr('data-productLeavl'));
		$("#product_expireDatexg").val($(this).attr('data-expireDate'));
		$("#product_validDatexg").val($(this).attr('data-validDate'));
		$("#produpage").val(page);
		$("#capacityxg").val($(this).attr('data-capacity'));
		$("#assert_idxg").val($(this).attr('data-assetType'));
		$("#productpro_Id").val($(this).attr('data-projectid'));
		$("#showproducttype").val($(this).attr('data-assetType'));
		$("#showproducttypeName").val($(this).attr('data-assetTypeName'));
		$("#showproductPrice").val($(this).attr('data-assetMoney'));
		var rateId=$(this).attr('data-rateid');
		
		$(".changeRate").val(rateId);
		var product_type=$(this).attr('data-assetType');
		var productArea=$(this).attr('data-productArea'); 
		if(product_type==3){
			$("#product_areaxg").html("<td>办公室面积</td><td><input type=\"number\"  id=\"officeareaxg\" value=\""+productArea+"\"" +
			" maxlength=\"5\"> <span id=\"spanofficeareaxg\"  style=\"display: none;color: red;font-size: 18px\">X</span></td>");
		}else{
			$("#product_areaxg").html(''); 
		}
		$("#add_Pdialog_xg").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
			close:function(){
				$('#add_Pdialog_xg').dialog('destroy');
			}});
	});
	/*--------------------------添加产品时，判断是否是办公室，如果是，出现办公室面积的输入框----------------------------------*/
	$("#assert_id").blur(function(){
		var assert_id=$.trim($("#assert_id option:selected").val());
		if(assert_id==3){
			$("#office_area").html("<td>办公室面积</td><td><input type=\"number\"  id=\"officearea\" maxlength=\"5\"> <span id=\"spanofficearea\"  style=\"display: none;color: red;font-size: 18px\">X</span></td>");

		}else{
			$("#office_area").html('');
		}
	});
	/*--------------------------添加产品，提交表单----------------------------------*/
	$("#formcheck_product_sure").on('click',function(){
		/*var boo_dateen=new Date(leasehold_start)<= new Date(leasehold_end);*/
		var redata=/^(\d{4})-(\d{2})-(\d{2})$/;
		var product_Id=$("#product_Id").val();
		var re_zss=/^\d+(?=\.{0,1}\d+$|$)/;
		var re=/^[0-9]*[0-9][0-9]*$/;
		var capacity=$.trim($("#capacity").val());
		var boo0=re.test(capacity);
		var project_Id=$.trim($("#project_Id option:selected").val());
		var boo_3=re.test(project_Id);
		var product_Name=$.trim($("#product_Name").val());
		var boo_1=product_Name.length>0&&product_Name.indexOf(" ") == -1;
		var product_Desc=$.trim($("#product_Desc").val());
		var boo_2=product_Desc.length>0&&product_Desc.indexOf(" ") == -1;
		var product_productLevel=1;
		var boo_4=re.test(product_productLevel);
		var product_validDate=$.trim($("#product_validDate").val());
		var boo_5=redata.test(product_validDate);
		var product_status=1;
		var boo_6=re.test(product_status);
		var product_expireDate=$.trim($("#product_expireDate").val());
		var boo_9=redata.test(product_expireDate);
		var  boodate=new Date(product_validDate)<= new Date(product_expireDate);
		var bssrate_id=$.trim($("#bssrate_id option:selected").val());
		var iteminfo=$.trim($("#iteminfo option:selected").val());
		var boo_7=re.test(bssrate_id);
		var boo_8=re.test(iteminfo);
		var space_id=$.trim($("#space_id option:selected").val());
		var boo9=re.test(space_id) || space_id==-1;
		var assert_id=$.trim($("#assert_id option:selected").val());
		boo10=re.test(assert_id);
		$("#spanproduct_Name").hide();
		$("#spanproduct_Desc").hide();
		$("#spanproject_Id").hide();
		$("#spanproduct_productLevel").hide();
		$("#spanproduct_validDate").hide();
		$("#spanproduct_status").hide();
		$("#spaniteminfo").hide();
		$("#spanbssrate_id").hide();
		$("#spanproduct_expireDate").hide();
		$("#spanspace_id").hide();
		$("#spancapacity").hide();
		$("#spanassert_id").hide();
		if(!boo_3){
			$("#spanproject_Id").show();
			return ;
		}
		if(!boo_1){
			$("#spanproduct_Name").show();
			return ;
		}
		if(!boo_2){
			$("#spanproduct_Desc").show();
			return ;
		}
		if(!boo_4){
			$("#spanproduct_productLevel").show();
			return ;
		}
		if(!boo_6){
			$("#spanproduct_status").show();
			return ;
		}
		if(!boo0){
			$("#spancapacity").show();
			return ;
		}
		if(!boo_5){
			$("#spanproduct_validDate").show();
			return ;
		}  
		if(!boo_9){
			$("#spanproduct_expireDate").show();
			return ;
		}
		if(!boodate){
			$("#spanproduct_validDate").show();
			$("#spanproduct_expireDate").show();
			return ;
		}
		if(!boo_7){
			$("#spanbssrate_id").show();
			return ;
		}
		if(!boo_8){
			$("#spaniteminfo").show();
			return ;
		}
		if(!(boo9 )){
			$("#spanspace_id").show();
			return ;
		}
		if(!boo10){
			$("#spanassert_id").show();
			return ;
		}
		var office_area="";
		if(assert_id==3){
			office_area=$("#officearea").val();
			var booarea=re_zss.test(office_area);
			if(!booarea){
				alert("请输入办公室面积");
				return ;
			}
		}
		if(boo_1&&boo_3&&boo_2&&boo_4&&boo_5&&boo_6&&boo_8&&boo_7&&boo9&&boo_9&&boo0&&boo10&&boodate){
			$.ajax({
				url:"filter/product/saveProduct",
				dataType:"json",
				type:"POST",
				data:{"capacity":capacity,
					"productId":product_Id,
					"projectId":project_Id,
					"productName":product_Name,
					"productDesc":product_Desc,
					"productLevel":product_productLevel,
					"status":product_status,
					"validDate":product_validDate,
					"expireDate":product_expireDate,
					"spaceId":space_id,
					"productType":assert_id,
					"rateId":bssrate_id,
					"itemId":iteminfo,
					"productArea":office_area
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						$('#add_Pdialog_pro').dialog('destroy');
						$('#content').load("filter/product/proconfirst", function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						$('#add_Pdialog_pro').dialog('destroy');
					}
				},error : function(data) {
					$('#add_Pdialog_pro').dialog('destroy');
				}});
		}
	})
	/*--------------------------关闭增加产品弹框----------------------------------*/
	$("#formcheck_product_esc").on("click",function(){
		$('#add_Pdialog_pro').dialog('destroy');
	});
	/*--------------------------关闭修改产品弹框----------------------------------*/
	$("#formcheck_product_escxg").on("click",function(){
		$('#add_Pdialog_xg').dialog('destroy');
	});
	/*--------------------------修改产品提交表单----------------------------------*/
	$("#formcheck_product_surexg").on('click',function(){
		var product_Id=$("#product_Idxg").val();
		var re_zss=/^\d+(?=\.{0,1}\d+$|$)/;
		var re=/^[0-9]*[0-9][0-9]*$/;
		var redata=/^(\d{4})-(\d{2})-(\d{2})$/;
		var capacity=$.trim($("#capacityxg").val());
		var boo0=re.test(capacity);
		var project_Id=$.trim($("#project_Idxg").val());
		var product_Name=$.trim($("#product_Namexg").val());
		var boo_1=product_Name.length>0&&product_Name.length<=30;
		var product_Desc=$.trim($("#product_Descxg").val());
		var boo_2=product_Desc.length>0&&product_Desc.length<=120;
		var product_productLevel=$.trim($("#product_productLevelxg option:selected").val());
		var boo_4=re.test(product_productLevel);
		var product_validDate=$.trim($("#product_validDatexg").val());
		var boo_5=redata.test(product_validDate);
		var product_status=$.trim($("#product_statusxg option:selected").val());
		var boo_6=re.test(product_status);
		var product_expireDate=$.trim($("#product_expireDatexg").val());
		var boo_9=redata.test(product_expireDate);
		var  boodate=new Date(product_validDate)<= new Date(product_expireDate);
		var bssrate_id=$.trim($("#bssrate_id2 option:selected").val());
		var iteminfo=$.trim($("#productitem_Id").val());
		var boo_8=re.test(iteminfo);
		var space_id=$.trim($("#productspace_Id").val());
		var assert_idxg=$.trim($("#assert_idxg").val());
		var officeareaxg="";
		if(assert_idxg==3){
			officeareaxg=$("#officeareaxg").val();
		}
		var project_Id=$.trim($("#productpro_Id").val());

		$("#spanproduct_Namexg").hide();
		$("#spanproduct_Descxg").hide();
		$("#spanproject_Idxg").hide();
		$("#spanproduct_productLevelxg").hide();
		$("#spanproduct_validDatexg").hide();
		$("#spanproduct_statusxg").hide();
		$("#spaniteminfoxg").hide();
		$("#spanbssrate_idxg").hide();
		$("#spanproduct_expireDatexg").hide();
		$("#spanspace_idxg").hide();
		$("#spancapacityxg").hide();
		if(!boo0){
			$("#spancapacityxg").show();
			return ;
		}
		if(!boo_1){
			$("#spanproduct_Namexg").show();
			return ;
		}
		if(!boo_2){
			$("#spanproduct_Descxg").show();
			return ;
		}

		if(!boo_4){
			$("#spanproduct_productLevelxg").show();
			return ;
		}
		if(!boo_5){
			$("#spanproduct_validDatexg").show();
			return ;
		}
		if(!boodate){
			$("#spanproduct_productLevelxg").show();
			$("#spanproduct_validDatexg").show();
			return ; 
		}
		if(!boo_6){
			$("#spanproduct_statusxg").show();
			return ;
		}
		if(!boo_9){
			$("#spanproduct_expireDatexg").show();
			return ;
		}

		if(boo_1&&boo_2&&boo_4&&boo_5&&boo_6&&boo_8&&boo_9&&boo0&&boodate){
			$.ajax({
				url:"filter/product/saveProduct",
				dataType:"json",
				type:"POST",
				data:{"productId":product_Id,
					"projectId":project_Id,
					"productName":product_Name,
					"productDesc":product_Desc,
					"productLevel":product_productLevel,
					"status":product_status,
					"validDate":product_validDate,
					"expireDate":product_expireDate,
					"spaceId":space_id,
					"rateId":bssrate_id,
					"itemId":iteminfo,
					"capacity":capacity,
					"productType":assert_idxg,
					"productArea":officeareaxg,
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						alert("修改成功");
						$('#add_Pdialog_xg').dialog('destroy');
						$('#product_info_de').load("filter/product/productionconfall",$('#query_info_product').serialize()+"&page=0", function(){
							$('.pagination>li>a').on('click', pageFunc);
						});

					}else{
						alert("修改失败");
						$('#add_Pdialog_xg').dialog('destroy');
					}

				},error : function(data) {
				}});
		}

	});
	/*--------------------------关闭弹框----------------------------------*/
	$("#return_product_escxg").on("click",function(){
		$('#add_Pdialog_xg').dialog('destroy');
	})
	/*--------------------------删除产品----------------------------------*/
	$(".delete_product").on("click",function(){
		if(confirm("确定删除此条记录吗？")){
			var product_id=$(this).attr('data-productid2');
			var page=$(this).attr('data-page');
			var detail=$('#query_info_product').serialize();
			$('#product_info_de').load("filter/product/productDele",$('#query_info_product').serialize()+"&product_id="+product_id+"&page=0", function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
		}
		
	});
	/*--------------------------关闭弹框----------------------------------*/
	$("#return_product_esc").on("click",function(){
		$('#add_Pdialog_pro').dialog('destroy');
	})

	var departmentList = Handlebars.compile($("#departmentList").html());
	var departmentList2 = Handlebars.compile($("#departmentList2").html());
	var departmentList3 = Handlebars.compile($("#departmentList3").html());
	/*--------------------------查询，当前产品可选择可配置的资产----------------------------------*/
	$(".gwconfsert").on('click',function(){
		debugger;
		$("#page_gw").val($(this).attr('data-pagegw'));
		$("#assert_gw").val($(this).attr('data-productidgw'));
		var product_id=$(this).attr('data-productidgw');
		$.ajax({
			url:"filter/product/assertinfo",
			dataType:"json",
			type:"POST",
			data:{
				"product_id":product_id
			},cache:false,
			success:function(data){	
				if(data.message=="true"){
					debugger;
					var index = 0;
					initData = [];
					for(var i=0;i<data.rows.length;i++){
						if(data.rows[i].isbinding){
							index++;
							if(data.total==1)initData.push(data.rows[i].seatId);
							if(data.total==2)initData.push(data.rows[i].meetingroomId);
							if(data.total==3)initData.push(data.rows[i].officeId);
						}
					}
					if(data.total==1){
						$('#assertfg').html(departmentList(data.rows));
					}
					if(data.total==2){
						$('#assertfg').html(departmentList2(data.rows));
					}
					if(data.total==3){
						$('#assertfg').html(departmentList3(data.rows));
					}

					$("#add_Pdialog_pro1gw").dialog({ modal:true,autoOpen: true, height:'auto', width:480,resizable:false,
						close:function(){
							$('#add_Pdialog_pro1gw').dialog('destroy');
						}});
				}
			},error : function(data) {
				alert("错误+++");
			}
		});


	});
	/*--------------------------配置资产---------------------------------*/
	$("#formcheck_product_suregw").on('click',function(){
		var prodele="";	
		var deletele = "";
		var  productid=$("#assert_gw").val();
		var re=/^[0-9]*[0-9][0-9]*$/;
		var boo2=re.test(productid);
		var chk_value =[];
		var nochk_value = [];
		debugger;
		for(var i=0;i<initData.length;i++){
			var flag = false;
			var value;
			$('input[name="confprodusenamegw"]:checked').each(function(){ 
				if($(this).val().substring(0,5)==initData[i]){
					flag = true;
				}
			});
			if(!flag){
				nochk_value.push($("#"+initData[i]).val());
				deletele=deletele+":"+$("#"+initData[i]).val();
			}
		}
		$('input[name="confprodusenamegw"]:checked').each(function(){ 
			chk_value.push($(this).val()); 
			prodele=prodele+":"+$(this).val();
		});
		if(chk_value.length==0&&boo2&&nochk_value.length==0){
			alert("请选择");
		}else{			
			$.ajax({
				url:"filter/product/confProdAssert",
				dataType:"json",
				type:"POST",
				data:{
					"prod":prodele,
					"deleteprod":deletele,
					"productid":productid
					
				},cache:false,
				success:function(data){	
					if(data.message=="true"){
						debugger;
						var noDeleteAssets = "";
						if(data.lists!=null){
							for(var i=0;i<data.lists.length;i++){
								noDeleteAssets += $('#'+data.lists[i].id.assetId).parent().parent().find('td').eq(1).text();
								if(i!==data.lists.length-1) noDeleteAssets +=","
							}
							if(noDeleteAssets!="")
							alert(noDeleteAssets+"资产已有使用记录，不能取消配置")
						}
						$('#add_Pdialog_pro1gw').dialog('destroy');	
					}else{
						alert("失败");
					}
				},error : function(data) {
					$('#add_Pdialog_pro1gw').dialog('destroy');	
				}
			});

		}


	});
	/*--------------------------关闭弹框----------------------------------*/
	$("#return_product_escgw").on('click',function(){
		$('#add_Pdialog_pro1gw').dialog('destroy');

	});

	$(".show").click(function(){
		var Index = $(this).index();
		$(".show-ul").eq(Index).toggle();
	});
	$(".all-choose").change(function(){
		$(".all-choose").is(":checked") ? 
				$(".show-ul").find(".choose").prop("checked",true) :
					$(".show-ul").find(".choose").prop("checked",false);


	});
})

