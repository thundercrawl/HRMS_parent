$(function() {
	$('#formParam').val($('#recordfrom').serialize());
	$('#startTime').val(getStartFormatDateStart());
	$('#endTime').val(getNowFormatDate());
	$('#startTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('#endTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('#submitTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('#endTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('#fromTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});
	$('#toTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d',
		formatDate: 'Y-m-d',
	});

	// 选择年月时间插件
	$('#submitMonTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m',
		formatDate: 'Y-m',
	});
	$('#endMonTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m',
		formatDate: 'Y-m',
	});

});
// 充值
function showDeposit() {
	$('#content').load("filter/PersonalBills/showDeposit");
}

function findComDeposit(){
	$('#formParam').val($('#recordfrom').serialize());
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var fromTime = $('#startTime').val();
	var toTime = $('#endTime').val();
	var payWay = $('#channel').val();
	var type= $('#type').val();
	var page=0;
	var pageSize=10;
	var isCom=$('#isCom').val();
	var orderNo= $('#orderNo').val();
	$('#PersonalBills12').load("filter/PersonalBills/findRecOut?page="+page+"&userPhone=" + userPhone
			+"&userName="+userName+ "&companyName=" + companyName + "&fromTime="
			+ fromTime + "&toTime=" + toTime+ "&pageSize=" + pageSize
			+ "&payWay=" + payWay+ "&type=" + type+ "&orderNo=" + orderNo+ "&isCom=" + isCom,
			function(){
		$('.pagination>li>a').on('click', pageFunc);
	});
//	if(fromTime==""&&toTime!=""){
//		alert("请选择起始时间");
//	}else if(fromTime!=""&&toTime==""){
//		alert("请选择结束时间");
//	}else if(fromTime>toTime){
//		alert("起始时间不能大于结束时间");
//	}else{
//		if (payWay == 0) {
//			
//		}	
//	}
}
// 充值查询
function findDeposit() {
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var submitTime = $('#submitTime').val();
	var endTime = $('#endTime').val();
	var channel = $('#channel').val();
	if(submitTime==""&&endTime!=""){
		alert("请选择起始时间");
	}else if(submitTime!=""&&endTime==""){
		alert("请选择结束时间");
	}else if(submitTime>endTime){
		alert("起始时间不能大于结束时间");
	}else{
		if (channel == 0) {
			$('#content').load("filter/PersonalBills/showDeposit?userPhone=" + userPhone
					+"&userName="+userName+ "&companyName=" + companyName + "&submitTime="
					+ submitTime + "&endTime=" + endTime
					+ "&channel=" + "");
		} else {
			$('#content').load("filter/PersonalBills/showDeposit?userPhone=" + userPhone
					+"&userName="+userName+ "&companyName=" + companyName + "&submitTime="
					+ submitTime + "&endTime=" + endTime + "&channel="
					+ channel);
		}	
	}
	
}
// 提现
function showWithdraw() {
	$('#content').load("filter/PersonalBills/showWithdraw");
}

// 提现查询
function findWithdraw() {
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var submitTime = $('#submitTime').val();
	var endTime = $('#endTime').val();
	var channel = $('#channel').val();
	if(submitTime==""&&endTime!=""){
		alert("请选择起始时间");
	}else if(submitTime!=""&&endTime==""){
		alert("请选择结束时间");
	}else if(submitTime>endTime){
		alert("起始时间不能大于结束时间");
	}else{
	if (channel == 0) {
		$('#content').load("filter/PersonalBills/showWithdraw?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName + "&submitTime="
				+ submitTime + "&endTime=" + endTime
				+ "&channel=" + "");
	} else {
		$('#content').load("filter/PersonalBills/showWithdraw?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName + "&submitTime="
				+ submitTime + "&endTime=" + endTime + "&channel="
				+ channel);
	}
	}
}
// 退款
function showRefund() {
	$('#content').load("filter/PersonalBills/showRefund");
}
// 退款查詢
function findRefund() {
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var orderNo = $('#orderNo').val();
	var submitTime = $('#submitTime').val();
	var endTime = $('#endTime').val();
	var channel = $('#channel').val();
	if(submitTime==""&&endTime!=""){
		alert("请选择起始时间");
	}else if(submitTime!=""&&endTime==""){
		alert("请选择结束时间");
	}else if(submitTime>endTime){
		alert("起始时间不能大于结束时间");
	}else{
	if (channel == 0) {
		$('#content').load("filter/PersonalBills/showRefund?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName + "&orderNo=" + orderNo
		+ "&submitTime=" + submitTime + "&endTime=" + endTime
		+ "&channel=" + "");
	} else {
		$('#content').load("filter/PersonalBills/showRefund?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName+ "&orderNo=" + orderNo
		+ "&submitTime=" + submitTime + "&endTime=" + endTime
		+ "&channel=" + channel);
	}
	}
}
// 支付
function showPayRecord() {
	$('#content').load("filter/PersonalBills/showPayRecord");
}
//支付查詢
function findPayRecord() {
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var orderNo = $('#orderNo').val();
	var fromTime = $('#fromTime').val();
	var toTime = $('#toTime').val();
	var payWay = $('#payWay').val();
	if(fromTime==""&&toTime!=""){
		alert("请选择起始时间");
	}else if(fromTime!=""&&toTime==""){
		alert("请选择结束时间");
	}else if(fromTime>toTime){
		alert("起始时间不能大于结束时间");
	}else{
	if (payWay == 0) {
		$('#content').load("filter/PersonalBills/showPayRecord?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName + "&orderNo=" + orderNo
		+ "&fromTime=" + fromTime + "&toTime=" + toTime
		+ "&payWay=" + "");
	} else {
		$('#content').load("filter/PersonalBills/showPayRecord?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName+ "&orderNo=" + orderNo
		+ "&fromTime=" + fromTime + "&toTime=" + toTime
		+ "&payWay=" + payWay);
	}
	}
}

// 日业务记录
function showDayBusinessRecord() {
	$('#content').load("filter/PersonalBills/showDayBusinessRecord");
}

// 日业务记录 查询
function findDayBusinessRecord() {
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var businessRecTime = $('#submitTime').val();
	$('#content').load("filter/PersonalBills/showDayBusinessRecord?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName + "&businessRecTime="+ businessRecTime)
}

// 月业务记录
function showMonBusinessRecord() {
	$('#content').load("filter/PersonalBills/showMonBusinessRecord");
}

// 月业务记录 查询
function findMonBusinessRecord() {
	var userName = $('#userName').val();
	var userPhone = $('#userPhone').val();
	var companyName = $('#companyName').val();
	var businessRecTime = $('#submitMonTime').val();
	$('#content').load("filter/PersonalBills/showMonBusinessRecord?userPhone=" + userPhone
				+"&userName="+userName+ "&companyName=" + companyName + "&businessRecTime="+ businessRecTime)
}
function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
	    return currentdate;
}
function getStartFormatDateStart() {
	    var date = new Date();
	    var seperator1 = "-";
	    var month = date.getMonth() + 1;
	    var strDate = 1;
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
	    return currentdate;
}