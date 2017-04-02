$(function() {


	$('#forBillSearch').on('click',function(){
		/*$('#versionSearchCondition').val($('#forid').serialize());*/
		$('#tid').load("filter/billSearch/getBillSearch?page=0",$('#forBillId').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});
	
	bookDelete=function(bookId){
		console.info(bookId);
		var sure=confirm("是否确认删除挂账");
		if(sure){
			$.ajax({
				url : 'filter/billSearch/deleteBook',
				type : 'POST',
				data : {
				"bookId":bookId
				},
				cache : false,
				dataType : 'json',
				success : function(data) {
					if(data.message=="success"){
						alert("删除挂账成功");
						$('#tid').load("filter/billSearch/getBillSearch?page=0",$('#forBillId').serialize(), function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else if(data.message=="error"){
						alert(data.errorMsg);
					}
				},
				error:function(data){
					alert("网络异常");
				}
			});
		}
		
	}

});
