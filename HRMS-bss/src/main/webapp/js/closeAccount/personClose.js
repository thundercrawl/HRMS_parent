$(function(){
			$(".ch-round").click(function () {
				$(this).toggleClass("round-index");
				if ($(".ch-round").length == $(".round-index").length) {
					$(".all-ch").addClass("all-index");
				} else {	
					$(".all-ch").removeClass("all-index");
				}
			});
			$(".all-ch").click(function () {
				$(this).toggleClass("all-index");
				if ($(this).hasClass("all-index")) {
					$(".ch-round").addClass("round-index");
				} else {
					$(".ch-round").removeClass("round-index");
				}
			});
			$('.printButton').click(function(){
				$('#printInfo').css('box-shadow','none');
				$('#printInfo').jqprint();
			});

			$(".surecheckordersec").on("click",function(){
				var orderIdarray="";
				for(var i=0;i<$(".ch-round").length;i++){
					if($(".ch-round").eq(i).attr("class")=="ch-round round-index"){
						orderIdarray+=$(".ch-round").eq(i).attr("data-orderno")+"|";
					}
				}
				if(orderIdarray.length<2){
					alert("请选择要结清的账单");
					return ;
				}
				var flagling=0;
				for(var i=0;i<$(".all-ch").length;i++){
					if($(".all-ch").eq(i).attr("class")=="all-ch all-index"){
						flagling=1;
					}
				}
				var companyId=$(this).attr("data-companyId");
				var userId=$(this).attr("data-userId");
				$.ajax({
					url:"filter/account/UserCheckoutsec",
					dataType:"json",
					type:"POST",
					data:{
						"userId":userId,
						"companyId":companyId,
						"orderIdarray":orderIdarray,
						"flag":1
					},cache:false,
					success:function(data){
						if(data.message=="true"){
							$('#content').load("filter/account/showPersonAccount?companyId="+companyId+"&userId="+userId, function(){
								$('.pagination>li>a').on('click', pageFunc);
							});
						}else{}
					},error : function(data) {
						
					}
				});
				
				
			});
			$(".surecheckorder").on("click",function(){
				var orderIdarray="";
				for(var i=0;i<$(".seclorder-ch").length;i++){
						orderIdarray+=$(".seclorder-ch").eq(i).attr("data-orderno")+"|";
				}
				var companyId=$(this).attr("data-companyId");
				var userId=$(this).attr("data-userId");
				var unsettlementMPkg=$(this).attr("data-unsettlementMPkg");
				var unsettlementRPkg=$(this).attr("data-unsettlementRPkg");
				var unsettlementFee=$(this).attr("data-unsettlementFee");
				$.ajax({
					url:"filter/account/UserCheckout",
					dataType:"json",
					type:"POST",
					data:{
						"userId":userId,
						"companyId":companyId,
						"orderIdarray":orderIdarray,
						"unsettlementMPkg":unsettlementMPkg,
						"unsettlementRPkg":unsettlementRPkg,
						"unsettlementFee":unsettlementFee
					},cache:false,
					success:function(data){
						if(data.message=="true"){
							$('#content').load("filter/account/showPersonAccount?companyId="+companyId+"&userId="+userId, function(){
								$('.pagination>li>a').on('click', pageFunc);
							});
						}else{}
					},error : function(data) {
						
					}
				});
				
			});
			

		});

