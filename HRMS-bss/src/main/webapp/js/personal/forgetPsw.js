$(function(){
	 $('.next').on('click',function(){
		 var account=$("#account").val();
			$('#page-body').load("filter/personal/forgetPsw1?account="+account);
		});
	 $('.second').on('click',function(){
		 var account=$("#account").val();
		 var name=$("#name").val();
		 var phone=$("#phone").val();
		 var idCard=$("#idCard").val();
			$('#page-body').load("filter/personal/forgetPsw2?account="+account+
					"name="+name+"&phone="+phone+"&idCard"+idCard);
		});
	 $('.fail').on('click',function(){
			$('#page-body').load("filter/personal/forgetPsw");
		});
})