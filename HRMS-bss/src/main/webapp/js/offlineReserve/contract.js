var price;
var markId;
var totalPriceArr = [];
var packagePriceArr = [];
var packagePrice;
var num = 0;
var stationArr = [];
var projectArr = [];
var rebateAvtive = false;// 是否使用过了折扣码
var favourCode = "00";// 折扣码，从后台获取数据之后给他赋值
var rebatePercent = 1;// 折扣码价格
var allotUserArr = [];// 分配给了那个用户
var productDiscount = 0.98;// 跨产品折扣
var productDiscountMark = false;// 用于判断是否拥有跨产品折扣
var areaDiscount = 0.98;// 跨项目折扣
var areaDiscountMark = false;// 判断是否拥有跨项目折扣
var startTime;
var endTime;
var andPoor = 0;// 分期之后总价之间的差
var disposableProduct = [];// 保存一次性消费的产品
var indexObjStory = 0;
var contractId = 8;// 合同id
var createPDFSendMail;
var orderId;
var isAdvanceCheck = 0;

$(function() {
	calendarSet();
	// 进入页面跳转到合同页面开始
	gotoPageCreateContract();
	var resetHeight = $(window).height() - $('.rent-box').offset().top - 60;
	resetHeight = resetHeight < 350 ? 350 : resetHeight;
	$('.rent-wrap').height(resetHeight);
	// 进入页面跳转到合同页面结束
	$('.sure-agreement').hide();
	$('.promptBox').hide();
	var pTitle;
	$(".item-list").find("span").click(function() {
		$(this).parent().remove();
	});
	$(".b").click(function() {
		$(this).toggleClass('select');
	});
	$(".bts").click(function() {
		$(this).toggleClass("btn-info");
	})
	$(".alert-close").click(function() {
		$(this).parent().hide();
		$(".bb-wrap").css('background', 'rgba(0, 0, 0, .5)');
		$(".b-wrap").addClass("hidden");
		$(".bb-wrap").addClass("hidden");
	});
	$("#sendClose").click(function() {
		$(this).parent().hide();
		$(".bb-wrap").addClass("hidden");
	});

	// 发送
	$(".send").click(function() {
		$(".send-alert1").removeClass("hidden");
		$(".send-alert1").show();
		$(".bb-wrap").css('background', 'rgba(0, 0, 0, .5)');
		$(".bb-wrap").removeClass("hidden");
	});
	$(".advanceCheckBtn").click(function() {
		var date = $('#contractHead').find('p').eq(3).text().substring(4, 14);
		$('#advanceCheckStartDate').val(date);
		$(".advanceCheck").removeClass("hidden");
		$(".advanceCheck").show();
		$(".bb-wrap").css('background', 'rgba(0, 0, 0, .5)');
		$(".bb-wrap").removeClass("hidden");
	});

	/*
	 * $(".alert-close").click(function(){ $(this).parent().hide();
	 * $(".bb-wrap").css('background','rgba(0, 0, 0, .5)');
	 * $(".bb-wrap").addClass("hidden"); });
	 */
	// 邮件发送
	$('#emailSend').click(function() {
		$('#bookPage').css('box-shadow', 'none');
		var text = $('#bookPage').html();
		if ($("#userEmailInputId").val() == "") {
			$('.promptBox').find('p').text("请输入邮箱账号！")
			$('.promptBox').show();
			$(".bb-wrap").css('background', 'rgba(0, 0, 0, 0)');
			$(".b-wrap").removeClass("hidden");
			return;
		}

		$.ajax({
			url : 'filter/offlineReserve/sendEmail',
			type : 'post',
			data : {
				emailContent : text,
				userMail : $("#userEmailInputId").val(),
				createPDFSendMail : createPDFSendMail,
				addContent : $("#text-con").val(),
				contractId : contractId
			},
			traditional : true,
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				// 测试
				$(".send-alert1").addClass("hidden");
				$(".bb-wrap").addClass("hidden");
			}
		});
	})

	// 确认提前入住
	$('#sureAdvanceCheck').click(function() {
		$('#bookPage').css('box-shadow', 'none');
		if ($("#advanceCheckStartDate").val() == "") {
			$('.promptBox').find('p').text("请输入时间！")
			$('.promptBox').show();
			$(".bb-wrap").css('background', 'rgba(0, 0, 0, 0)');
			$(".b-wrap").removeClass("hidden");
			return;
		}
		var date = $('#contractHead').find('p').eq(3).text().substring(4, 14);
		if(date<$("#advanceCheckStartDate").val()){
			$('.promptBox').find('p').text("起始日期需小于合同起始日期！")
			$('.promptBox').show();
			$(".bb-wrap").css('background', 'rgba(0, 0, 0, 0)');
			$(".b-wrap").removeClass("hidden");
			return;
		}
		confirmAct();

		$.ajax({
			url : 'filter/offlineReserve/sureAdvanceCheck',
			type : 'post',
			data : {
				contractId : $("#contractIdInp").val(),
				startDate : $("#advanceCheckStartDate").val()
			},
			traditional : true,
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data) {
					isAdvanceCheck = 1;
					alert("操作成功！");

				} else {
					alert("操作失败	！")
				}
				// 测试
				$(".advanceCheck").addClass("hidden");
				$(".bb-wrap").addClass("hidden");
			}
		});
	})

	$('.circle-content').find("input").blur(function() {
		var inputName = $(this).attr("id");
		invokeValidateFunction(inputName);
	})
	// 保存追加内容
	$("#upd-save").click(function() {
		$('#addContent').hide();
		$('.addContextTitle').hide();
		if ($("#text-con").val().trim().length != 0) {
			$('#addContent').show();
			$('.addContextTitle').show();
		}
		$(".app-con").html($("#text-con").val());
		$(".b-wrap").addClass("hidden");
		$(".updateContract").addClass("hidden");
		var text = $("#text-con").val();
		var contractId = $("#contractId").val();
		// 调接口保存追加的内容
		$.ajax({
			url : 'filter/offlineReserve/saveTheText',
			type : 'post',
			data : {
				contractId : contractId,
				text : text
			},
			traditional : true,
			async : false,
			cache : false,
			dataType : 'json',
			success : function(data) {
				if (data) {
					$('.promptBox').find('p').text("条款保存成功！")
					$('.promptBox').show();
					$(".b-wrap").removeClass("hidden");
				}
			},
			error : function(data) {
			}
		});
	});

	$('.printBtn').click(function() {
		$('#contractHead').css('box-shadow', 'none');
		var tmpTitle = $(document).attr('title');
		$(document).attr('title', "办伴科技 分布式移动办公领导者 联合办公 服务式商务中心");
		if ($('.rent-English').css('display') == "none") {
			$('.rent-contract').eq(0).jqprint();
		} else {
			$('.rent-contract').eq(1).jqprint();
		}
		// $('#contractHead').jqprint();
		// $(document).attr('title',tmpTitle);
	});
	// 确认合同事件
	$('.sure_contract').click(function() {
		// 友情提醒，请注意提前入住操作。
		// alert("友情提醒，请注意提前入住操作。");
		if (isAdvanceCheck == 0) {
			var date = $('#contractHead').find('p').eq(3).text().substring(4, 14);
			$('#advanceContractDate').text(date);
			$(".remindDialog").removeClass("hidden");
			$(".remindDialog").show();
			$(".bb-wrap").css('background', 'rgba(0, 0, 0, .5)');
			$(".bb-wrap").removeClass("hidden");
		} else if (isAdvanceCheck == 1) {
			sureContract();
		}

	});

	$('#contractDate').click(function() {
		sureContract();
	});

	$('#setAdvanceDate').click(function() {
		$(".bb-wrap").css('background', 'rgba(0, 0, 0, .5)');
		$(".b-wrap").addClass("hidden");
		$(".bb-wrap").addClass("hidden");
		$(".remindDialog").hide();
		var date = $('#contractHead').find('p').eq(3).text().substring(4, 14);
		$('#advanceCheckStartDate').val(date);
		$(".advanceCheck").removeClass("hidden");
		$(".advanceCheck").show();
		$(".bb-wrap").css('background', 'rgba(0, 0, 0, .5)');
		$(".bb-wrap").removeClass("hidden");
	});

});

function sureContract() {
	var contractId = $("#contractId").val();
	$('#content').load('filter/sys/contract/suerConstract?orderid=' + contractId + "&msg=" + "&page=" + 0);
}

function update() {
	$(".updateContract").show();
	$(".updateContract").removeClass("hidden");
	$(".b-wrap").removeClass("hidden");
}

function gotoPageCreateContract() {
	$('#bookTitle').text("合同预览")
	contractId = $('#contractId').val();
	if (contractId == "")
		return;
	contractId = contractId;
	$('.sure-agreement').hide();
	findOrderInfoByContractId(contractId);
}

function confirmAct() {
	if (confirm('确定要执行此操作吗?')) {
		return true;
	}
	return false;
}

function closePaymentMethod() {
	var index = 4;
	$(".pay-con").eq(index).removeClass("hidden").siblings(".pay-con").addClass('hidden');
	$(".mod").eq(index).addClass('current-step').siblings(".mod").removeClass("current-step");
}

function update() {
	$(".updateContract").show();
	$(".updateContract").removeClass("hidden");
	$(".b-wrap").removeClass("hidden");
}

function findOrderInfoByContractId(contractId) {
	$
			.ajax({
				url : 'filter/offlineReserve/findOrderInfoByContractId',
				type : 'post',
				data : {
					contractId : contractId
				},
				traditional : true,
				async : false,
				cache : false,
				dataType : 'json',
				success : function(data) {
					debugger;
					var stagesStr = "";
					if (data.payAction == "1")
						stagesStr = "月付";
					if (data.payAction == "2")
						stagesStr = "季付";
					if (data.payAction == "3")
						stagesStr = "半年付";
					if (data.payAction == "5")
						stagesStr = "全款";
					if (data.payAction == "6")
						stagesStr = "双月付";
					console.log(data)
					$('#bookTitle').text(data.contractInfo.typeName + "预览");
					$('#contractTitle').text("租赁" + data.contractInfo.typeName);
					$('#contractHead')
							.find('.rent-con')
							.eq(0)
							.find('p')
							.eq(0)
							.html(
									"<span style='box-sizing: border-box;width: 120px;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>供应方(甲方)</span>上海办伴科技发展有限公司");
					if (data.contractInfo.companyName != null) {
						$('#contractHead')
								.find('.rent-con')
								.eq(0)
								.find('p')
								.eq(1)
								.html(
										"<span style='box-sizing: border-box;width: 120px;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>承租方(乙方)</span>"
												+ data.contractInfo.companyName);
						$('.rent-contract')
								.eq(1)
								.find('div')
								.eq(0)
								.find('p')
								.eq(1)
								.html(
										"<span style='box-sizing: border-box;width:140px;letter-spacing:0;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>Client Name</span>"
												+ data.contractInfo.companyName);
					}
					if (data.contractInfo.contractId != null) {
						$('#contractHead')
								.find('.rent-con')
								.eq(0)
								.find('p')
								.eq(2)
								.html(
										"<span style='box-sizing: border-box;width: 120px;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>合同编号</span>NO."
												+ data.contractInfo.contractId);
						$('.rent-contract')
								.eq(1)
								.find('div')
								.eq(0)
								.find('p')
								.eq(2)
								.html(
										"<span style='box-sizing: border-box;width:140px;letter-spacing:0;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>Reference </span>NO."
												+ data.contractInfo.contractId);
					}
					$('#contractHead')
							.find('.rent-con')
							.eq(0)
							.find('p')
							.eq(3)
							.html(
									"<span style='box-sizing: border-box;width: 120px;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>租赁周期</span>"
											+ data.leaseTime);
					if (data.contractInfo.finishtime != null) {
						$('#contractHead')
								.find('.rent-con')
								.eq(0)
								.find('p')
								.eq(4)
								.html(
										"<span style='box-sizing: border-box;width: 120px;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>合同签订日期</span>"
												+ data.contractInfo.finishtime);
						$('.rent-contract')
								.eq(1)
								.find('div')
								.eq(0)
								.find('p')
								.eq(4)
								.html(
										"<span style='box-sizing: border-box;width:140px;letter-spacing:0;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>Agreement date:</span>"
												+ data.contractInfo.finishtime);
					}
					$('#contractHead')
							.find('.rent-con')
							.eq(0)
							.find('p')
							.eq(5)
							.html(
									"<span style='box-sizing: border-box;width: 120px;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>付款周期</span>"
											+ stagesStr);
					$('.rent-contract')
							.eq(1)
							.find('div')
							.eq(0)
							.find('p')
							.eq(5)
							.html(
									"<span style='box-sizing: border-box;width:140px;letter-spacing:0;font-weight: bold;font-size: 15px;margin-right: 10px;float: left;display: block;text-align: left;'>Payment Plan	</span>"
											+ stagesStr);
					if (data.contractInfo.supplement != null && data.contractInfo.supplement != "") {
						$('.addContextTitle').show();
						$('.app-con').text(data.contractInfo.supplement);
						$('#text-con').text(data.contractInfo.supplement)
					}
					if (data.loginUser != null) {
						if (data.sellerInfo != null) {
							if (data.sellerInfo.adminLname != null) {
								$('#contractHead').find('.rent-con').eq(1).find('p').eq(0).html(
										"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>联系人</span>"
												+ data.sellerInfo.adminRname);
								$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(0).html(
										"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Contact Name</span>"
												+ data.sellerInfo.adminRname);
							}
							if (data.sellerInfo.adminPhone != null) {
								$('#contractHead').find('.rent-con').eq(1).find('p').eq(1).html(
										"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>电话</span>"
												+ data.sellerInfo.adminPhone);
								$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(1).html(
										"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Tel</span>"
												+ data.sellerInfo.adminPhone);
							}
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(2).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>职位</span>" + "销售");
							$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(2).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Position</span>"
											+ "Salesman");
							if (data.sellerInfo.adminEmail != null) {
								$('#contractHead').find('.rent-con').eq(1).find('p').eq(3).html(
										"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>邮箱</span>"
												+ data.sellerInfo.adminEmail);
								$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(3).html(
										"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>E-mail</span>"
												+ data.sellerInfo.adminEmail);
							}
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(4).html(
									"<span style='width: 70px;font-weight: bold;font-size: 15px;margin-right: 10px;'>账单地址</span>");
							$('.rent-contract')
									.eq(1)
									.find('div')
									.eq(1)
									.find('p')
									.eq(4)
									.html(
											"<span style='box-sizing: border-box;width:140px;lette-spacing:0;font-weight: bold;font-size: 15px;margin-right: 10px;'>Mailing Address</span>");
						} else {
							// if(data.loginUser.adminLname!=null)
							// $('#contractHead').find('.rent-con').eq(1).find('p').eq(0).html("<span
							// style='width: 60px;font-weight: bold;font-size:
							// 15px;margin-right:
							// 10px;'>联系人</span>"+data.loginUser.adminRname);
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(0).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>联系人</span>" + "办伴科技");
							$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(0).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Contact Name</span>"
											+ "办伴科技");
							// if(data.loginUser.adminPhone!=null)
							// $('#contractHead').find('.rent-con').eq(1).find('p').eq(1).html("<span
							// style='width: 60px;font-weight: bold;font-size:
							// 15px;margin-right:
							// 10px;'>电话</span>"+data.loginUser.adminPhone);
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(1).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>电话</span>" + "400-920-9888");
							$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(1).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Tel</span>"
											+ "400-920-9888");
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(2).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>职位</span>");
							$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(2).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Position</span>"
											+ "Salesman");
							// if(data.loginUser.adminEmail!=null)
							// $('#contractHead').find('.rent-con').eq(1).find('p').eq(3).html("<span
							// style='width: 60px;font-weight: bold;font-size:
							// 15px;margin-right:
							// 10px;'>邮箱</span>"+data.loginUser.adminEmail);sales@distrii.com
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(3).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>邮箱</span>" + "sales@distrii.com");
							$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(3).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>E-mail</span>"
											+ "sales@distrii.com");
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(4).html(
									"<span style='width: 70px;font-weight: bold;font-size: 15px;margin-right: 10px;'>账单地址</span>");
							$('.rent-contract')
									.eq(1)
									.find('div')
									.eq(1)
									.find('p')
									.eq(4)
									.html(
											"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Mailing Address</span>");
						}
					}

					if (data.contractInfo != null) {
						if (data.contractInfo.userName != null) {
							$('#contractHead').find('.rent-con').eq(2).find('p').eq(0).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>联系人</span>" + data.contractInfo.userName);
							$('.rent-contract').eq(1).find('div').eq(2).find('p').eq(0).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Contact Name</span>"
											+ data.contractInfo.userName);
						}
						if (data.contractInfo.userPhone != null) {
							$('#contractHead').find('.rent-con').eq(2).find('p').eq(1).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>电话</span>" + data.contractInfo.userPhone);
							$('.rent-contract').eq(1).find('div').eq(2).find('p').eq(1).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Tel</span>"
											+ data.contractInfo.userPhone);
						}
						$('#contractHead').find('.rent-con').eq(2).find('p').eq(2).html(
								"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>职位</span>");
						$('.rent-contract')
								.eq(1)
								.find('div')
								.eq(2)
								.find('p')
								.eq(2)
								.html(
										"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Position</span>");
						if (data.contractInfo.userMail != null) {
							$('#contractHead').find('.rent-con').eq(2).find('p').eq(3).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>邮箱</span>" + data.contractInfo.userMail);
							$('.rent-contract').eq(1).find('div').eq(2).find('p').eq(3).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>E-mail</span>"
											+ data.contractInfo.userMail);
						}
						if (data.contractInfo.companyAddress != null) {
							$('#contractHead').find('.rent-con').eq(2).find('p').eq(4).html(
									"<span style='width: 70px;font-weight: bold;font-size: 15px;margin-right: 10px;'>账单地址</span>"
											+ data.contractInfo.companyAddress);
							$('.rent-contract').eq(1).find('div').eq(2).find('p').eq(4).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Mailing Address</span>"
											+ data.contractInfo.companyAddress);
						}
					}

					$('.rentbox').find('tr').remove()
					var list = data.list;
					var htm = "";
					var firstMoney = 0;
					var packageMoney = 0;
					var jianmian = 0;
					var margin = 0;
					var disposable = 0;
					var meetingRoomPackage = 0;
					var elasticStationJuan = 0;
					var htmHan = "<tr><th style='line-height: 25px;background-color: #E6E6E6;'>项目</th><th style='line-height: 25px;background-color: #E6E6E6;'>产品名称</th><th style='line-height: 25px;background-color: #E6E6E6;'>单价</th><th style='line-height: 25px;background-color: #E6E6E6;'>数量</th><th style='line-height: 25px;background-color: #E6E6E6;'>租赁周期</th><th style='line-height: 25px;background-color: #E6E6E6;'>租金</th></tr>";
					var htmEng = "<tr><th style='box-sizing: border-box;line-height: 25px;background-color: #E6E6E6;'>Center Name</th><th style='box-sizing: border-box;line-height: 25px;background-color: #E6E6E6;'>Office NO.</th><th style='box-sizing: border-box;line-height: 25px;background-color: #E6E6E6;'>Unit Price</th><th style='box-sizing: border-box;line-height: 25px;background-color: #E6E6E6;'>Units</th><th style='box-sizing: border-box;line-height: 25px;background-color: #E6E6E6;'>Service Provision</th><th style='box-sizing: border-box;line-height: 25px;background-color: #E6E6E6;'>Rental</th></tr>";
					for (var i = 0; i < list.length; i++) {
						for (var j = 0; j < list[i].length; j++) {
							var unitStr = "元/月";
							var unitStrSon = "元/月/人";
							var price = list[i][j].nomalFee;
							var rent = list[i][j].nomalFee * list[i][j].capacity;
							var productType = list[i][j].productType;
							var moneyMark = "￥";
							if (productType == 1 || productType == 3) {
								unitStr = "元/月";
								unitStrSon = unitStr;
								rent = list[i][j].nomalFee * list[i][j].amount;
							}
							if (productType == 2) {
								unitStr = "张会议室劵/时";
								unitStrSon = unitStr;
								moneyMark = "";
							}
							if (productType == 4) {
								unitStr = "张弹性工位劵/日";
								unitStrSon = unitStr;
								price = price / 31;
								rent = rent / 31;
								moneyMark = "";
							}
							if (productType == 5 || productType == 6) {
								// 智慧包及其减免产品
								rent = list[i][j].nomalFee * list[i][j].amount;
							}
							if (list[i][j].favourDiscount != null) {
								price = Math.floor((price * list[i][j].favourDiscount) / 100);
								rent = Math.floor((rent * list[i][j].favourDiscount) / 100);
							}
							var assetNumStr = "";
							if (list[i][j].parentId == 0) {
								var assetList = list[i][j].assetList;
								for (var k = 0; k < assetList.length; k++) {
									if (k != 0 && k % 5 == 0)
										assetNumStr += "</br>";
									if (k != assetList.length - 1) {
										assetNumStr += assetList[k].assetCode + ",";
									} else {
										assetNumStr += assetList[k].assetCode;
									}
								}
							}
							if (j == 0) {
								htm += "<tr><td rowspan='" + list[i].length + "' valign='top' style='line-height: 30px;vertical-align: middle;'>";
								htm += list[i][j].projectName + "</td><td style='line-height: 30px;vertical-align: middle;'>" + list[i][j].productName + "("
										+ list[i][j].capacity + ")</br>" + assetNumStr + "</td><td style='line-height: 30px;vertical-align: middle;'>"
										+ moneyMark + "" + price + "" + unitStrSon + "</td><td style='line-height: 30px;vertical-align: middle;'>"
										+ list[i][j].amount + "</td><td>" + list[i][j].rentStartTime + "到" + list[i][j].rentEndTime
										+ "</td><td style='line-height: 30px;vertical-align: middle;'>" + moneyMark + "" + rent + "" + unitStr + "</td></tr>";
							} else {
								htm += "<tr><td valign='top' style='line-height: 30px;vertical-align: middle;'>";
								htm += list[i][j].productName + "(" + list[i][j].capacity + ")</br>" + assetNumStr
										+ "</td><td style='line-height: 30px;vertical-align: middle;'>" + moneyMark + "" + price + "" + unitStrSon
										+ "</td><td style='line-height: 30px;vertical-align: middle;'>" + list[i][j].amount
										+ "</td><td style='line-height: 30px;vertical-align: middle;'>" + list[i][j].rentStartTime + "到"
										+ list[i][j].rentEndTime + "</td><td style='line-height: 30px;vertical-align: middle;'>" + moneyMark + "" + rent + ""
										+ unitStr + "</td></tr>";
							}

							if (list[i][j].productType == 2)
								meetingRoomPackage = meetingRoomPackage + list[i][j].rent;
							if (list[i][j].productType == 4)
								elasticStationJuan = elasticStationJuan + list[i][j].rent;
							if (list[i][j].parentId == 0) {
								var splitList = list[i][j].splitList;
								if (splitList.length > 0) {
									if (productType != 2 && productType != 4)
										firstMoney += splitList[0].priceFee;
								}
								margin += list[i][j].ensureFee;
							}
							if (list[i][j].productType == 5) {
								var splitList = list[i][j].splitList;
								if (splitList.length > 0)
									packageMoney += splitList[0].priceFee;
							}
							if (list[i][j].productType == 6 || list[i][j].productType == 7) {
								var splitList = list[i][j].splitList;
								if (splitList.length > 0)
									jianmian += splitList[0].priceFee;
							}
							// 一次性费用
							if (list[i][j].productType == 10 || list[i][j].productType == 11) {
								disposable += list[i][j].splitList[0].priceFee;
							}
						}
					}
					var indexMark = 0;
					if (list[0][0].crossProjectDiscount != 1 && list[0][0].crossProjectDiscount != null) {// 跨点组合优惠
						if (indexMark == 0) {
							indexMark++;
							htm += "<tr><td rowspan='3' valign='top' style='line-height: 30px;vertical-align: middle;'>";
						}
						htm += "</td><td style='line-height: 30px;vertical-align: middle;'>跨点折扣</td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'>"
								+ list[0][0].crossProjectDiscount + "% off</td></tr>"
					}
					if (list[0][0].crossProductDiscount != 1 && list[0][0].crossProductDiscount != null) {// 跨产品组合优惠
						if (indexMark == 0) {
							indexMark++;
							htm += "<tr><td rowspan='3' valign='top' style='line-height: 30px;vertical-align: middle;'>";
						}
						htm += "</td><td style='line-height: 30px;vertical-align: middle;'>跨产品折扣</td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'>"
								+ list[0][0].crossProductDiscount + "% off</td></tr>";
					}
					if (list[0][0].payActionDiscount != 1 && list[0][0].payActionDiscount != null) {// 跨产品组合优惠
						if (indexMark == 0) {
							indexMark++;
							htm += "<tr><td rowspan='3' valign='top' style='line-height: 30px;vertical-align: middle;'>";
						}
						htm += "</td><td style='line-height: 30px;vertical-align: middle;'>付款节奏折扣</td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'>"
								+ list[0][0].payActionDiscount + "% off</td></tr>";
					}
					if (list[0][0].favourDiscount != 1 && list[0][0].favourDiscount != null) {// 优惠码
						if (indexMark == 0) {
							indexMark++;
							htm += "<tr><td rowspan='3' valign='top' style='line-height: 30px;vertical-align: middle;'>";
						}
						htm += "</td><td style='line-height: 30px;vertical-align: middle;'>优惠码折扣</td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'>"
								+ list[0][0].favourDiscount + "% off</td></tr>";
					}
					if (firstMoney != 0) {
						$('.rent-f').find('span').eq(0).text(firstMoney + ".00元");
						$('.rent-f').eq(1).find('span').eq(0).text(firstMoney + ".00元");
					}
					if (packageMoney != 0) {
						$('.rent-f').find('span').eq(1).text(packageMoney + ".00元");
						$('.rent-f').eq(1).find('span').eq(1).text(packageMoney + ".00元");
					}
					if (disposable != 0) {
						$('.rent-f').find('span').eq(2).text(disposable + ".00元");
						$('.rent-f').eq(1).find('span').eq(2).text(disposable + ".00元");
					}
					if (margin != 0) {
						$('.rent-f').find('span').eq(3).text(margin + ".00元");
						$('.rent-f').eq(1).find('span').eq(3).text(margin + ".00元");
					}
					if (jianmian != 0) {
						$('.rent-f').find('span').eq(4).text(jianmian + ".00元");
						$('.rent-f').eq(1).find('span').eq(4).text(jianmian + ".00元");
					}
					var firstMoneyTotal = packageMoney + firstMoney + margin + jianmian + disposable;
					var total = packageMoney + firstMoney + margin + jianmian + disposable;
					var totalStr = "";
					if (total != 0)
						totalStr = totalStr + total + ".00元";
					if (meetingRoomPackage != 0)
						totalStr = totalStr + "  " + meetingRoomPackage + "张会议室券";
					if (elasticStationJuan != 0)
						totalStr = totalStr + "  " + elasticStationJuan + "张弹性工位劵";
					// createPDFSendMail=firstMoney+","+packageMoney+","+disposable+","+margin+","+jianmian+","+totalStr;
					createPDFSendMail = firstMoney + ".00元," + packageMoney + ".00元," + disposable + ".00元," + margin + ".00元," + jianmian + ".00元," + totalStr;
					$('.rent-f').find('span').eq(5).text(totalStr);
					$('.rent-f').eq(1).find('span').eq(5).text(totalStr);
					$('#contractProducts').append(htmHan + htm);
					$('.rentbox').eq(1).append(htmEng + htm);
				}
			});
}

function getFirstMoney() {

	var arr = [];
	arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, stationArr[i].discountProductId, stationArr[i].discountProductType,
			areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, discountPrice, stationArr[i].startTime,
			stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime, allotUserArr[0], allotUserArr[1],
			stationArr[i].packageUnit, stationArr[i].volume, 0, 0, stationArr[i].packageType, stationArr[i].packageDiscountPrice, index++, "no"));
	$.ajax({
		url : 'filter/offlineReserve/saveOrderInfo',
		type : 'post',
		data : {
			arr : JSON.stringify(arr)
		},
		async : false,
		cache : false,
		dataType : 'json',
		success : function(data) {
			console.log(data)
		}
	});
}

// 调到下一步
function skipStep(index) {
	/*
	 * if(index==1){ padding2PageData(); } if(index==2){//判断是否拥有能够升级的智慧包 var
	 * packageIsUpArr=judgePackageIsUp(); createPackageUpInfo(packageIsUpArr); }
	 * if(index==3){ orderNoAndTime(); getByStagesData(1); createOrderPage(); }
	 * if(index==4){ var flag = createOrder(2);//生成意向书 if(!flag) return; }
	 * if(index==5){ if($('#bookTitle').text()=="合同预览"){ return; }
	 * //createOrder(1);//生成合同 }
	 * $(".pay-con").eq(index).removeClass("hidden").siblings(".pay-con").addClass('hidden');
	 * $(".mod").eq(index).addClass('current-step').siblings(".mod").removeClass("current-step");
	 * $(".b-wrap").addClass("hidden");
	 */
}

function downloadPDF() {
	var form = $("<form>"); // 定义一个form表单
	form.attr('style', 'display:none'); // 在form表单中添加查询参数
	form.attr('target', '');
	form.attr('method', 'post');
	form.attr('action', "filter/offlineReserve/createPdf");

	var input1 = $('<input>');
	input1.attr('type', 'hidden');
	input1.attr('name', 'contractId');
	input1.attr('value', contractId);
	var input2 = $('<input>');
	input2.attr('type', 'hidden');
	input2.attr('name', 'createPDFSendMail');
	input2.attr('value', createPDFSendMail);
	var input3 = $('<input>');
	input3.attr('type', 'hidden');
	input3.attr('name', 'addContent');
	input3.attr('value', $("#text-con").val());
	$('body').append(form); // 将表单放置在web中
	form.append(input1); // 将查询参数控件提交到表单上
	form.append(input2); // 将查询参数控件提交到表单上
	form.append(input3); // 将查询参数控件提交到表单上
	form.submit();
}

function payComplete() {
	$.ajax({
		url : 'filter/offlineReserve/payComplete',
		type : 'POST',
		data : {
			contractId : contractId
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data) {
				$('.promptBox').find('p').text("订单状态修改成功!")
				$('.promptBox').show();
				$(".b-wrap").removeClass("hidden");
			}
		},
		error : function(data) {
		}
	});
}

// 取消订单释放房源
function cancelOrder() {
	//
	$.ajax({
		url : 'filter/offlineReserve/releaseOrder',
		type : 'POST',
		data : {
			orderId : orderId
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data) {
				$('.promptBox').find('p').text("资源释放成功!")
				$('.promptBox').show();
				$(".b-wrap").removeClass("hidden");
			}
		},
		error : function(data) {
		}
	});
}

function calendarSet() {
	$('#advanceCheckStartDate').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
}

function hideAgreement() {
	$('.sure-agreement').hide()
	$(".b-wrap").addClass("hidden");
}
