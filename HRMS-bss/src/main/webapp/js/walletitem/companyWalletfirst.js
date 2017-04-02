
$("#company_wallet_query").on("click",function(){
	$('#company_wallet_ip').val($('#company_wallet_fr').serialize());
	$('#company_wallet_info').load("filter/wallet/searchCompanyWallet", $('#company_wallet_fr').serialize(), function(){
		$('.pagination>li>a').on('click', pageFunc);
	});
});

