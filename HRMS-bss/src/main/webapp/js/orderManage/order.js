$(function() {
	var addOrUpdateMark = 0;// 0为add 1为update
	var orderStatus =$('#orderStatusInput').val();
	var selectStatusLi=$('#selectStatus').find('li');
	for(var i=0;i<selectStatusLi.length;i++){
		if(selectStatusLi.eq(i).attr('data-value')==orderStatus){
			$('#orderStatusSpan').val(selectStatusLi.eq(i).attr('data-value'));
			$('#orderStatusSpan').text(selectStatusLi.eq(i).text());
		}
	}
	$("#addParam").on("click", function() {
		addOrUpdateMark = 0;
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
		$("#orderNo").val("");
		$("#companyId").val("");
		$("#userId").val("");
		$("#totalPrice").val("");
		$("#ensurePriceFee").val("");
		$("#channel").val("");
	});
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
		
		$("#orderNo").val($(this).attr('data-orderNo'));
		$("#companyId").val($(this).attr('data-companyId'));
		$("#userId").val($(this).attr('data-userId'));
		$("#totalPrice").val($(this).attr('data-totalPrice'));
		$("#ensurePriceFee").val($(this).attr('data-ensurePriceFee'));
		$("#channel").val($(this).attr('data-channel'));
		$("#status").val($(this).attr('data-status'));
	});

	$('#formcheck').on('click', function() {
		var flag = 0;
		
		var orderNo = $("#orderNo").val();
		var companyId = $("#companyId").val();
		var userId = $("#userId").val();
		var totalPrice = $("#totalPrice").val();
		var ensurePriceFee = $("#ensurePriceFee").val();
		var channel = $("#channel").val();
//		var status = $("#status").val();
		flag = verifyIsEmpty(orderNo,orderNo,flag);
		flag = verifyIsEmpty(companyId,companyId,flag);
		flag = verifyIsEmpty(userId,userId,flag);
		flag = verifyIsEmpty(totalPrice,totalPrice,flag);
		flag = verifyIsEmpty(ensurePriceFee,ensurePriceFee,flag);
		flag = verifyIsEmpty(channel,channel,flag);
		if (flag == 0 && addOrUpdateMark == 0) {
			add();
		} else if (flag == 0 && addOrUpdateMark == 1) {
			update();
		} else {
			alert("请输入合法的数据，感谢您的配合！");
		}
	});

	$('.deleteParam').on('click', function() {
		$('#content').load("filter/orderManage/deleteOfcOrder?orderNo="+$(this).attr('data-orderNo')+"&page="+$(this).attr('data-page'));
	});
	
	$('.detail').on('click', function() {
		var companyName = $('#companyName').val();
		var userName = $('#userName').val();
		var orderStartTime = $('#orderStartTime').val();
		var orderEndTime = $('#orderEndTime').val();
		var status = $('#orderStatusSpan').attr('value');
		$('#content').load("filter/orderManage/ofcOrderDetailPage?companyName="+ companyName+"&status="+status+"&userName="+userName+"&orderStartTime="+orderStartTime+"&orderEndTime="+orderEndTime+"&orderId="+$(this).attr('data-orderId')+"&page="+$(this).attr('data-page'));
	});
	
	$('.dropdown-toggle').on('click', function(){
		$('#selectStatus').show();
	});
	
	$('#selectStatus > li').click(function(){
		$('#orderStatusSpan').text($(this).text());
		$('#orderStatusSpan').attr('value',$(this).attr("data-value"));
		$('#selectStatus').hide();
	});

	$('#findproject').on('click', function() {
		var projectname = $('#findInput').val();
		if (projectname == "输入订单的名称" || projectname == "") {
			$('#textspan').html("请输入合法的订单名称");
			$('#textspan').css("color", "red");
		}
	});
	
	$('#queryBtn').on('click', function() { //查询按钮事件
		debugger
		var salerName=$('#salerName').val();
		var companyName = $('#companyName').val();
		var userName = $('#userName').val();
		var orderStartTime = $('#orderStartTime').val();
		var orderEndTime = $('#orderEndTime').val();
		var orderNo = $('#orderNo').val();
		var status = $('#orderStatusSpan').attr('value');
		$('#content').load("filter/orderManage/returnOfcOrderSearch?companyName="+ encodeURI(companyName)+"&page="+0+"&status="+status+"&userName="+encodeURI(userName)+"&orderStartTime="+orderStartTime+"&orderEndTime="+orderEndTime+"&orderNo="+orderNo+"&salerName="+salerName);
	});

	$('#findInput').on('focus', function() {
		$('#textspan').html("");
	});
	
	$('.form_datetime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	
	/*---------------确认付款---------------------*/
	$('.suerorder').click(function(){
		if (window.confirm("确定付款？")) {
			var orderid = $(this).attr('data-orderId');
			var page = $(this).attr('data-page');
			$('#content').load("filter/orderManage/surePar?page="+page+"&orderid="+orderid);
		}
	});
	
	
	$('.cancelOrder').click(function(){
		if (window.confirm("确定进行取消订单操作？")) {
		}
	});
	
	$('.releaseResource').click(function(){
		if (window.confirm("确定进行资源释放操作？")) {
			var orderid = $(this).attr('data-orderId');
			var page = $(this).attr('data-page');
			$('#content').load("filter/orderManage/releaseOrder?page="+page+"&orderid="+orderid);
		}
	});
	
	$('.toContract').click(function(){
			var orderid = $(this).attr('data-orderId');
			$('#content').load('filter/offlineReserve/orderToContract?orderId='+orderid) ;  
	});
	
});

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
		var orderNo = $("#orderNo").val();
		var companyId = $("#companyId").val();
		var userId = $("#userId").val();
		var totalPrice = $("#totalPrice").val();
		var ensurePriceFee = $("#ensurePriceFee").val();
		var channel = $("#channel").val();
		var status = $("#status").val();
		$.ajax({
			url : 'filter/orderManage/addOfcOrder',
			type : 'post',
			data : {
				'orderNo' : orderNo,
				'companyId' : companyId,
				'userId' : userId,
				'totalPrice' : totalPrice,
				'ensurePriceFee' : ensurePriceFee,
				'channel' : channel,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
//				alert(data);
				$('#addPdialog').dialog('destroy');
			}
		});
	}
}

function update() {
	if (window.confirm("确定提交？")) {
		var orderNo = $("#orderNo").val();
		var companyId = $("#companyId").val();
		var userId = $("#userId").val();
		var totalPrice = $("#totalPrice").val();
		var ensurePriceFee = $("#ensurePriceFee").val();
		var channel = $("#channel").val();
		var status = $("#status").val();
		$.ajax({
			url : 'filter/orderManage/updateOfcOrder',
			type : 'post',
			data : {
				'orderNo' : orderNo,
				'companyId' : companyId,
				'userId' : userId,
				'totalPrice' : totalPrice,
				'ensurePriceFee' : ensurePriceFee,
				'channel' : channel,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
//				alert(data);
				$('#addPdialog').dialog('destroy');
			}
		});
	}
}