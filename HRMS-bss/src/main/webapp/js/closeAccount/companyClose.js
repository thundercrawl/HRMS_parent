$(function() {
	$(document).click(function(e) {
		if (e.toElement.textContent != "打印") {
			$(document).attr("title", "办伴科技 分布式移动办公领导者 联合办公 服务式商务中心");
		}
	});
	$('.printButton').click(
			function() {
				debugger;
				var title = $(this).parent().parent().find('table').eq(0).find('tr>td').eq(5).html().trim();
				var billDate = $(this).parent().parent().find('table').eq(0).find('tr').eq(2).find('td').eq(5).html().trim();
				var isFirstBill = $('#isFirstBill').val();
				if(isFirstBill=="true"){
					title = title +"  "+ billDate + "首付款账单";
				}else{
					billDate = billDate.substring(0,7);
					title = title +"  "+ billDate + "账单";
				}
				/* $('#printInfo').css('box-shadow','none'); */
				$(document).attr("title",title);
				$('#printInfo').jqprint();
				$('#printBankPage').jqprint();
			});
	
	$('.returnButton').click(
			function() {
				debugger;
				var url = $(this).attr('url');
				$('#content').load(url);
				
			});
	$(".closaccountButton").click(
			function() {
				var billMonth = $("#billMonth").val();
				var companyId = $("#companyId").val();
				var unsettlementFee = $("#unsettlementFee").val();
				var unsettlementRPkg = $("#unsettlementRPkg").val();
				var unsettlementMPkg = $("#unsettlementMPkg").val();
				$.ajax({
					url : "filter/account/companyCheckout",
					dataType : "json",
					type : "POST",
					data : {
						"companyId" : companyId,
						"billMonth" : billMonth,
						"unsettlementFee" : unsettlementFee,
						"unsettlementRPkg" : unsettlementRPkg,
						"unsettlementMPkg" : unsettlementMPkg
					},
					cache : false,
					success : function(data) {
						if (data.message == "true") {
							$('#content').load(
									"filter/account/closeCompanyAccount?companyId="
											+ companyId + "&billMonth="
											+ billMonth);
							;
							alert("结账成功");
						} else if (data.message == "4002") {
							alert("账户余额不足");
						} else {
							alert("结账失败");
						}
					},
					error : function(data) {

					}
				});

			});

});
