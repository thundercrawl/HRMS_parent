$(function() {
	var sumInputHide=$('#stageData').find('.sumInputHide');
	var totalMoneyTd=$('#stageData').find('.totalMoney');
	for(var i=0;i<totalMoneyTd.length;i++){
		totalMoneyTd.eq(i).text(sumInputHide.eq(i).val());
	}
	
	var addOrUpdateMark = 0;// 0为add 1为update
	
	$('#return').on('click', function() {
		$('#addPdialog').dialog('destroy');
	});

	$('.updatePro').on('click', function() {
		addOrUpdateMark = 1;
		$("#addPdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 300,
			resizable : false,
			close : function() {
				$('#addPdialog').dialog('destroy');
			}
		});
		
		$("#orderDetailId").val($(this).attr('data-orderDetailId'));
		$("#orderId").val($(this).attr('data-orderId'));
		$("#productId").val($(this).attr('data-productId'));
		$("#amount").val($(this).attr('data-amount'));
		$("#orderTime").val($(this).attr('data-orderTime'));
		$("#rentStartTime").val($(this).attr('data-rentStartTime'));
		$("#rentEndTime").val($(this).attr('data-rentEndTime'));
		$("#shoopingCartId").val($(this).attr('data-shoopingCartId'));
		$("#productType").val($(this).attr('data-productType'));
	});

	$('#formcheck').on('click', function() {
		var flag = 0;
		
		var orderDetailId = $("#orderDetailId").val();
		var orderId = $("#orderId").val();
		var productId = $("#productId").val();
		var amount = $("#amount").val();
		var orderTime = $("#orderTime").val();
		var rentStartTime = $("#rentStartTime").val();
		var rentEndTime = $("#rentEndTime").val();
		var shoopingCartId = $("#shoopingCartId").val();
		var productType = $("#productType").val();
		flag = verifyIsEmpty(orderDetailId,orderDetailId,flag);
		flag = verifyIsEmpty(orderId,orderId,flag);
		flag = verifyIsEmpty(productId,productId,flag);
		flag = verifyIsEmpty(amount,amount,flag);
		flag = verifyIsEmpty(orderTime,orderTime,flag);
		flag = verifyIsEmpty(rentStartTime,rentStartTime,flag);
		flag = verifyIsEmpty(rentEndTime,rentEndTime,flag);
		flag = verifyIsEmpty(shoopingCartId,shoopingCartId,flag);
		flag = verifyIsEmpty(productType,productType,flag);
		if (flag == 0 && addOrUpdateMark == 0) {
			add();
		} else if (flag == 0 && addOrUpdateMark == 1) {
			update();
		} else {
			alert("请输入合法的数据，感谢您的配合！");
		}
	})

	$('.deleteParam').on('click', function() {
		$('#page-body').load("filter/order/deleteOfcOrderDetail?orderDetailId="+$(this).attr('data-orderDetailId'));
	})
	$('.deleteAsset').on('click', function() {
		var orderId = $('#orderId').val();
		$('#content').load("filter/order/deleteAsset?assetId="+$(this).attr('data-assetId')+"&assetTypeStr="+$(this).attr('data-assetTypeStr')+"&orderId="+orderId);
	});
	$("#assetManage").on("click", function() {
		addOrUpdateMark = 0;
		$("#assetTable").show();
		$('#stageTable').hide();
	});
	$('#lookStageData').click(function(){
		$('#stageTable').show();
		$("#assetTable").hide();
	});
	$('.detail').on('click', function() {
		$('#page-body').load("filter/order/ofcOrderDetailPage?orderId="+$(this).attr('data-orderId'));
	});
	$('#returnBtn').on('click', function() {//订单明细返回按钮
		debugger;
		if($('#returnMark').val()){
			$('#content').load("filter/sys/contract/home?mark="+$('#returnMark').val());
		}else{
			var companyName = $('#companyName').val();
			var userName = $('#userName').val();
			var orderStartTime = $('#orderStartTime').val();
			var orderEndTime = $('#orderEndTime').val();
			var status = $('#status').attr('value');
			//alert($('#oldPage').val());
			$('#content').load("filter/order/returnOfcOrderSearch?companyName="+ companyName+"&status="+status+"&userName="+userName+"&orderStartTime="+orderStartTime+"&orderEndTime="+orderEndTime+"&page=0");
//		$('#content').load("filter/order/showOfcOrder?companyName="+ companyName+"&status="+status+"&userName="+userName+"&orderStartTime="+orderStartTime+"&orderEndTime="+orderEndTime+"&page="+$('#oldPage').val());
		}
	})

	$('#findproject').on('click', function() {
		var projectname = $('#findInput').val();
		if (projectname == "输入订单的名称" || projectname == "") {
			$('#textspan').html("请输入合法的订单名称");
			$('#textspan').css("color", "red");
		}
	});

	$('#findInput').on('focus', function() {
		$('#textspan').html("");
	})
	
	$('.form_datetime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('.form_date').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('.form_time').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
});

function checkAll(obj){
	var curCheckBox = document.getElementsByName("checkAsset");
	for(var i = 0; i < curCheckBox.length; i++){
	curCheckBox.item(i).checked = obj.checked;
	}
}

function verifyIsEmpty(id,idValue,flag){
	if(flag==1){
		if(idValue==""){
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('X');
			$("#"+id+"Span").css("color","red");
		}else{
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('√');
			$("#"+id+"Span").css("color","green");
		}
	}else if(flag==0){
		if(idValue==""){
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('X');
			$("#"+id+"Span").css("color","red");
			flag = 1;
		}else{
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('√');
			$("#"+id+"Span").css("color","green");
			flag = 0;
		}
	}
	
	return flag;
}

function add() {
	if (window.confirm("确定提交？")) {
		var orderDetailId = $("#orderDetailId").val();
		var orderId = $("#orderId").val();
		var productId = $("#productId").val();
		var amount = $("#amount").val();
		var orderTime = $("#orderTime").val();
		var rentStartTime = $("#rentStartTime").val();
		var rentEndTime = $("#rentEndTime").val();
		var shoopingCartId = $("#shoopingCartId").val();
		var productType = $("#productType").val();
		var status = $("#status").val();
		$.ajax({
			url : 'filter/order/addOfcOrderDetail',
			type : 'post',
			data : {
				'orderId' : orderId,
				'orderDetailId' : orderDetailId,
				'productId' : productId,
				'amount' : amount,
				'orderTime' : orderTime,
				'rentStartTime' : rentStartTime,
				'rentEndTime' : rentEndTime,
				'shoopingCartId' : shoopingCartId,
				'productType' : productType,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				alert(data);
				$('#addPdialog').dialog('destroy');
			}
		});
	}
}

function update() {
	if (window.confirm("确定提交？")) {
		var orderDetailId = $("#orderDetailId").val();
		var orderId = $("#orderId").val();
		var productId = $("#productId").val();
		var amount = $("#amount").val();
		var orderTime = $("#orderTime").val();
		var rentStartTime = $("#rentStartTime").val();
		var rentEndTime = $("#rentEndTime").val();
		var shoopingCartId = $("#shoopingCartId").val();
		var productType = $("#productType").val();
		var status = $("#status").val();
		$.ajax({
			url : 'filter/order/updateOfcOrderDetail',
			type : 'post',
			data : {
				'orderId' : orderId,
				'orderDetailId' : orderDetailId,
				'productId' : productId,
				'amount' : amount,
				'orderTime' : orderTime,
				'rentStartTime' : rentStartTime,
				'rentEndTime' : rentEndTime,
				'shoopingCartId' : shoopingCartId,
				'productType' : productType,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				alert(data);
				$('#addPdialog').dialog('destroy');
			}
		});
	}
}