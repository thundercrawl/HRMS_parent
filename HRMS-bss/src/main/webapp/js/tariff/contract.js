function checkAll( obj){
	var curCheckBox = document.getElementsByName("promotions");
	for(var i = 0; i < curCheckBox.length; i++){
	curCheckBox.item(i).checked = obj.checked;
	}
	}
//$("#deletecontracts").click(function(){
//	var obj=document.getElementsByName('promotions');
////promotions是checkbox的name属性值
//	var checkval=[];
//	for(var  k in obj){
//		if(obj[k].checked)
//			checkval.push(obj[k].value);
//	}
//	var contracts=checkval.toString();
//	if(checkval==null||checkval==""){
//		alert("请勾选要删除的合同！");
//	}else{
//		if(window.confirm("确定删除所选合同？")){
//		var page=document.getElementById("page").value;
//		var url=document.getElementById("huan").value;
//		$('#content').load("filter/sys/contract/deletecontract?"+url+"&page="+page+"&contracts="+contracts);
//		}}
//	});
$('#datetimepickerfrom').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
$('#datetimepickerto').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
function findcontracts(){
	var a = /^(\d{4})-(\d{2})-(\d{2})$/;
	var b=/^\d+$/;
	var fromtime=document.getElementById("datetimepickerfrom").value;
	var totime=document.getElementById("datetimepickerto").value;
	var username=document.getElementById("username").value;
	var ordernumber=document.getElementById("ordernumber").value;
	var companyname=document.getElementById("companyname").value;
	var status=document.getElementById("contractstatus").value;
	var types=document.getElementById("contracttype").value;
	var contractid=document.getElementById("contractid").value;
	if (fromtime!=null&&fromtime!=""&&totime!=null&&totime!=""&&!a.test(document.getElementById("datetimepickerfrom").value)&&!a.test(document.getElementById("datetimepickerto").value)) { 
		alert("日期格式不正确!"); 
		}else if(ordernumber!=null&&ordernumber!=""&&!b.test(ordernumber)){
			alert("请输入正确的订单编号！");
		}else{
			$('#content').load("filter/sys/contract/home?orderid="+encodeURI(ordernumber)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types+"&contractid="+contractid);
		} 
}
$(function(){
	/*------------合同/意向书的确认-------------*/
	$('.sure').on('click',function(){

//		filter/offlineReserve/toContract
		var orderid = $(this).attr('orderid');
		var page = $(this).attr('page');
//		var confirms = confirm("你要确定此合同？");
//		if(confirms==true){
			$('#content').load('filter/offlineReserve/toContract?contractId='+orderid) ;  
			//$('#content').load('filter/sys/contract/suerConstract?orderid='+orderid+"&msg="+"&page="+page);
//		}
	});
	/*--------------确定付款---------------------*/
	$('.surePay').click(function(){
		var orderid = $(this).attr('orderid');
		var page = $(this).attr('page');
		var confirms = confirm("你要确定付款？");
		if(confirms==true){
			$('#content').load('filter/sys/contract/surePar?contractid='+orderid+"&page="+page);
		}
	});
	
	/*--------------生成首付款---------------------*/
	$('.firstPay').click(function(){
		var orderid = $(this).attr('orderid');
		var page = $(this).attr('page');
		var confirms = confirm("你要确定生成首付款账单？");
		if(confirms==true){
			$('#content').load('filter/sys/contract/firstPay?contractid='+orderid+"&page="+page);
		}
	});
	/*--------------查询首付款账单---------------------*/
	$('.checkFirstPay').click(function(){
		debugger;
		var hostContractUrl = $(this).attr('value');
		hostContractUrl = hostContractUrl.replace(/&/g,'@');
		console.log(hostContractUrl);
		var orderid = $(this).attr('orderid');
		$('#content').load('filter/account/checkFirstPayBill?contractid='+orderid+'&hostContractUrl='+hostContractUrl);
		
	});

	//意向书生成合同事件
	$('.create_contract').on('click',function(){
		var orderid = $(this).attr('orderid');
		var page = $(this).attr('page');
		var confirms = confirm("你要确定此合同？");
		if(confirms==true){
			$('#content').load('filter/sys/contract/suerConstract?orderid='+orderid+"&msg="+"&page="+page);
		}
	});
	
	//点击合同跳转到合同页面事件
	$('.showContract').on('click',function(){
		var orderid = $(this).attr('id');
		$('#content').load('filter/offlineReserve/toContract?contractId='+orderid) ;  
	});
	
	
	//跳转到订单详情
	$('.showOrder').on('click',function(){
		var orderid = $(this).attr('id');
		$('#content').load("filter/order/toOrderDetail?orderId="+orderid+"&mark="+$('.pagination > .active').text().trim());  
	});
});
