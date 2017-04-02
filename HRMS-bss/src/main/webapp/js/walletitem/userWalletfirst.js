
$("#user_wallet_query").on("click",function(){
	$('#user_wallet_ip').val($('#user_wallet_fr').serialize());
	$('#user_wallet_info').load("filter/wallet/searchUserWallet", $('#user_wallet_fr').serialize(), function(){
		$('.pagination>li>a').on('click', pageFunc);
	});
});

