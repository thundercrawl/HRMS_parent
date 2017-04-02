
$(function(){
	$("#query_wallet_item").on("click",function(){
		$('#wallt_item_ip').val($('#query_item_fr').serialize());
		$('#wallet_item_info').load("filter/wallet/searchWalletItem?page=0", $('#query_item_fr').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});

});

$("#add_walletItem").on('click', function() {
	$("#htitle").html("添加钱包科目信息");
	$("#item_dialog").dialog({
		modal : true,
		autoOpen : true,
		height : 'auto',
		width : 450,
		resizable : false,
		close : function() {
			$('#item_dialog').dialog('close');
		}
	});
});




