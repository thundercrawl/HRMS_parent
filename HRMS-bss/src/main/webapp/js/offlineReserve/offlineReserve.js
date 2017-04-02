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
var contractId = 23;// 合同id
var createPDFSendMail;
var orderId;
var meetingBag = 0;// 会议室券
var peopleDayBag = 0;// 弹性工位券
var ssPhone;
var discountNumber;// 优惠码

var searchComPhone; // 查询公司所用的用户电话号码

var minDate;
var maxDate;

$(function() {
	// 进入页面跳转到合同页面开始
	gotoPageCreateContract();
	var resetHeight = $(window).height() - $('.rent-box').offset().top - 60;
	resetHeight = resetHeight < 350 ? 350 : resetHeight;
	$('.rent-wrap').height(resetHeight);
	// 进入页面跳转到合同页面结束
	$('.sure-agreement').hide();
	$('.promptBox').hide();
	var pTitle;
	$('#phoneSearch').keypress(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			if ($("#phoneSearch").val() == "") {
				$('.promptBox').find('p').text("请输入手机号进行查询！");
				$('.promptBox').show();
				$(".b-wrap").removeClass("hidden");
				return;
			}
			getUserInfoByPhone($("#phoneSearch").val());
			ssPhone = $("#phoneSearch").val();
		}
	});

	$('#inputAssetId').keypress(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			$('#projectSelect').trigger('click');
		}
	});

	$(".item-list").find("span").click(function() {
		$(this).parent().remove();
	});
	$(".b").click(function() {
		$(this).toggleClass('select');
	});
	changeTab(".register", "current-register", ".circle-content");
	register();
	$(".bts").click(function() {
		$(this).toggleClass("btn-info");
	});
	var currentTime = new Date().Format("yyyy-MM-dd");
	$('#datetimepicker2').val(currentTime);
	$('#datetimepicker3').val(currentTime);
	calendarSet();
	// 生成意见书
	$(".create-b").click(function() {
		$('#bookTitle').text("意向书预览");
		$(".send-alert2").removeClass("hidden");
		$(".send-alert2").show();
		$(".b-wrap").removeClass("hidden");
	});
	// 生成合同
	$(".create-c").click(function() {
		$('#bookTitle').text("合同预览");
		$('.pact-sure').hide();// 隐藏确定按钮
	});
	$(".alert-close").click(function() {
		$(this).parent().hide();
		$(".b-wrap").css('background', 'rgba(0, 0, 0, .5)');
		$(".b-wrap").addClass("hidden");
	});

	// 发送
	$(".send").click(function() {
		$(".send-alert1").removeClass("hidden");
		$(".send-alert1").show();
		$(".b-wrap").removeClass("hidden");
	});
	// 发送
	$(".advanceCheckBtn").click(function() {
		var date = $('#contractHead').find('p').eq(3).text().substring(4, 14);
		$('#advanceCheckStartDate').val(date);
		$(".advanceCheck").removeClass("hidden");
		$(".advanceCheck").show();
		$(".b-wrap").css('background', 'rgba(0, 0, 0, .5)');
		$(".b-wrap").removeClass("hidden");
	});
	// 邮件发送
	$('#emailSend').click(function() {
		var text = $('#bookPage').html();
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
				$(".b-wrap").addClass("hidden");
			}
		});
	});

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
		if (date < $("#advanceCheckStartDate").val()) {
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
					alert("操作成功！")
				} else {
					alert("操作失败	！")
				}
				// 测试
				$(".advanceCheck").addClass("hidden");
				$(".b-wrap").addClass("hidden");
			}
		});
	})

	$('.circle-content').find("input").blur(function() {
		var inputName = $(this).attr("id");
		invokeValidateFunction(inputName);
	});

	$('.marginInput').blur(function() {

	});
	// 保存
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
					$('.promptBox').find('p').text("条款保存成功！");
					$('.promptBox').show();
					$(".b-wrap").removeClass("hidden");
				}
			},
			error : function(data) {
			}
		});
	});

	// 获取默认选中办公位置所对应的空间类型
	getCurrentProjectSpactType($('#projectSelected option:selected').val());

	$('#meetingRoomDate').hide();
	$('#elasticStationRoomDate').hide();// 弹性工位
	$('#officeRoomDate').show();// 办公室

	// $(".btn-search").unbind('click');
	// $(".btn-search").click(function(){
	$("#searchUser").click(function() {
		if ($("#phoneSearch").val() == "") {
			$('.promptBox').find('p').text("请输入手机号进行查询！");
			$('.promptBox').show();
			$(".b-wrap").removeClass("hidden");
			return;
		}
		getUserInfoByPhone($("#phoneSearch").val());

	});

	$("#searchCompany").click(function() {
		if ($("#inputEmail3").val() == "") {
			$('.promptBox').find('p').text("请输入公司名进行查询！");
			$('.promptBox').show();
			$(".b-wrap").removeClass("hidden");
			return;
		} else {
			searchComPhone = $("#inputEmail3").val();
		}
		getCompanyInfoByPhone(this, searchComPhone);

	});

	$("#register-sure").click(function() {
		var input = $('.circle-content').find("input");
		var flag = false;
		for (var i = 0; i < input.length; i++) {
			var inputName = input.eq(i).attr("id");
			flag = invokeValidateFunction(inputName);
			if (!flag)
				break;
		}
		if ($('#userpass').val() != $('#userpassTwo').val())
			flag = false;
		if (flag)
			userRegister();
	});

	// 注册新公司
	$("#newcompany-register").click(function() {
		var phone = $('.currentSelectUser').parent().parent().parent().parent().find('.td-number').html();
		$('#companyPhone').val(phone);
		$(".seat-alert9").css("margin-top", "-" + parseInt($(".seat-alert8").css("height")) / 2 + "px");
		$(".seat-alert8").hide();
		$(".seat-alert9").show();
		$(".b-wrap").removeClass("hidden");
	});

	$('#register-exit').click(function() {
		$(".order-rights").css("display", "none");
		$(".order-right").css("display", "block");
	});

	$('.printBtn').click(function() {
		if ($('.rent-English').css('display') == "none") {
			$('.rent-contract').eq(0).jqprint();
		} else {
			$('.rent-contract').eq(1).jqprint();
		}
	});
	$('#datetimepicker5').blur(function() {
		var dateStr = ($('#datetimepicker5').val() + "").substring(3);
		if (dateStr != "00") {
			var dateTou = ($('#datetimepicker5').val() + "").substring(0, 2);
			if (dateTou == "23") {
				$('#datetimepicker5').val("00:00");
			} else {
				$('#datetimepicker5').val((parseInt(dateTou) + 1) + ":00");
			}
		}
	});

	$('#datetimepicker6').blur(function() {
		var dateStr = ($('#datetimepicker6').val() + "").substring(3);
		if (dateStr != "00") {
			var dateTou = ($('#datetimepicker6').val() + "").substring(0, 2);
			if (dateTou == "23") {
				$('#datetimepicker6').val("00:00");
			} else {
				$('#datetimepicker6').val((parseInt(dateTou) + 1) + ":00");
			}
		}
	});

	// ===============my===============================
	$('#projectSelect')
			.click(
					function() {
						var inputAssetId = $('#inputAssetId').val();
						var projectId = $('#projectSelected option:selected').val();
						var projectName = $('#projectSelected option:selected').attr('projectNameData');
						var type = $('#spaceSelected option:selected').val();
						if (type == "" || type == undefined) {
							$('.promptBox').find('p').text("空间类型不能为空！");
							$('.promptBox').show();
							$(".b-wrap").removeClass("hidden");
							return;
						}
						if (type == 1) {// 开放式工位
							startTime = $('#start-date').val();
							endTime = $('#endDate').val();
						}
						if (type == 2) {// 会议室
							startTime = $('#datetimepicker4').val() + " " + $('#datetimepicker5').val();
							endTime = $('#datetimepicker4').val() + " " + $('#datetimepicker6').val();
							var sDate = new Date(startTime);
							var eDate = new Date(endTime);
							if (sDate >= eDate) {
								$('.promptBox').find('p').text("结束时间必须大于起始时间！");
								$('.promptBox').show();
								$(".b-wrap").removeClass("hidden");
								return;
							}
							if ($('#datetimepicker5').val().trim() == "" || $('#datetimepicker6').val().trim() == ""
									|| $('#datetimepicker4').val().trim() == "") {
								$('.promptBox').find('p').text("日期不能为空！");
								$('.promptBox').show();
								$(".b-wrap").removeClass("hidden");
								return;
							}
						}
						if (type == 3) {// 办公室
							startTime = $('#start-date').val();
							endTime = $('#endDate').val();
						}
						if (type == 4) {// 弹性工位
							startTime = $('#datetimepicker2').val();
							endTime = $('#datetimepicker3').val();
						}
						/*
						 * var currentTime = new Date().Format("yyyy-MM-dd");
						 * if(getDays(currentTime,startTime)<0){
						 * $('.promptBox').find('p').text("起始时间必须大于当前时间！");
						 * $('.promptBox').show();
						 * $(".b-wrap").removeClass("hidden"); return; }
						 */
						if (startTime.trim() == "" || endTime.trim() == "") {
							$('.promptBox').find('p').text("日期不能为空!");
							$('.promptBox').show();
							$(".b-wrap").removeClass("hidden");
							return;
						}
						if (getDays(startTime, endTime) < 0) {
							$('.promptBox').find('p').text("结束日期必须大于起始日期！");
							$('.promptBox').show();
							$(".b-wrap").removeClass("hidden");
							return;
						}
						$
								.ajax({
									url : 'filter/offlineReserve/selectProjectDetail',
									type : 'post',
									data : {
										'projectId' : projectId,
										'type' : type,
										'assetNum' : inputAssetId.trim(),
										'startTime' : startTime,
										'endTime' : endTime
									},
									cache : false,
									async : false,
									dataType : 'json',
									success : function(data) {
										debugger;
										$('#productInfoBody').find('tr').remove();
										if (data.length == 0 && inputAssetId.trim() != "") {
											$('.promptBox').find('p').text("没有该资产或者该资产已被租用！");
											$('.promptBox').show();
											$(".b-wrap").removeClass("hidden");
											return;
										}
										var spaceSelectedOption = $('#spaceSelected').find('option');
										var htm = "";
										for (var i = 0; i < data.length; i++) {
											var spaceType = "";
											var priceSign = "";
											var signString = "/";
											for (var j = 0; j < spaceSelectedOption.length; j++) {
												if (data[i].spaceId == spaceSelectedOption.eq(j).val()) {
													spaceType = spaceSelectedOption.eq(j).text().trim();
												}
											}
											if (data[i].productType == 1 || data[i].productType == 3) {
												priceSign = "￥";
												signString = "/";
											}
											if (data[i].productType == 2) {
												priceSign = "";
												signString = "张会议室券/";
											}
											if (data[i].productType == 4) {
												priceSign = "";
												signString = "张弹性工位券/";
											}
											// projectId为产品id pjId为项目id
											if (inputAssetId.trim() != "") {
												htm += "<tr projectId='" + data[i].projectId + "' pjId=" + projectId + " projectName=" + projectName + " type="
														+ type + " id='productId" + data[i].projectId + "'><td>" + projectName + "</td><td productType='"
														+ data[i].productType + "' productArea='" + data[i].productArea + "'>" + data[i].productName + "("
														+ inputAssetId.trim() + ")</td><td>" + spaceType + "</td><td>" + data[i].capacity
														+ "</td><td dataUnit='" + data[i].unitEnum + "' dataUnitEnum='" + data[i].unit + "' dataMoney='"
														+ data[i].money + "'>" + priceSign + data[i].money + signString + data[i].unitEnum
														+ "</td><td dataCount='" + data[i].count + "'>" + data[i].count + "</td>"
														+ "<td class='seat-positive'><div class='btn btn-info my-btn' onclick='showAlert(this)'>选择座位</div>";
											} else {
												htm += "<tr projectId='" + data[i].projectId + "' pjId=" + projectId + " projectName=" + projectName + " type="
														+ type + " id='productId" + data[i].projectId + "'><td>" + projectName + "</td><td productType='"
														+ data[i].productType + "' productArea='" + data[i].productArea + "'>" + data[i].productName
														+ "</td><td>" + spaceType + "</td><td>" + data[i].capacity + "</td><td dataUnit='" + data[i].unitEnum
														+ "' dataUnitEnum='" + data[i].unit + "' dataMoney='" + data[i].money + "'>" + priceSign
														+ data[i].money + signString + data[i].unitEnum + "</td><td dataCount='" + data[i].count + "'>"
														+ data[i].count + "</td>"
														+ "<td class='seat-positive'><div class='btn btn-info my-btn' onclick='showAlert(this)'>选择座位</div>";
											}

											for (var j = 0; j < data[i].incrementProductOutsList.length; j++) {
												htm += "<input type='hidden' class='inputVal'  productId='" + data[i].incrementProductOutsList[j].productId
														+ "' incrementLevel='" + data[i].incrementProductOutsList[j].incrementLevel + "' ratePriceFee='"
														+ data[i].incrementProductOutsList[j].ratePriceFee + "' unit='"
														+ data[i].incrementProductOutsList[j].unit + "' discountPrice='"
														+ data[i].incrementProductOutsList[j].discountPrice + "' discountProductType='"
														+ data[i].incrementProductOutsList[j].discountProductType + "' discountProductId='"
														+ data[i].incrementProductOutsList[j].discountProductId + "' incrementProductName='"
														+ data[i].incrementProductOutsList[j].incrementProductName + "' >";
											}
											htm += "<div id='seat-alertId' class='seat-alert' ><div class='seat-header'>选择座位<img class='exitBtn' src='img/iconfont-chahao.png' style='width:16px;float:right;margin-top:6px;margin-right:20px;cursor:pointer;'></img></div>";

											htm += "<div class='seat-con'><ul>";
											for (var j = 0; j < data[i].productAssettInfoList.length; j++) {
												htm += "<li class='clearfix'><div class='seat-con-l'><p class='h'>" + data[i].productAssettInfoList[j].floor
														+ "楼:</p></div>";
												htm += "<div class='seat-con-r'>";
												for (var x = 0; x < data[i].productAssettInfoList[j].assetNumber.length; x++) {
													htm += "<span class='col'><a href='javascript:;' assetId='" + data[i].productAssettInfoList[j].seattId[x]
															+ "'  class='b spana'>" + data[i].productAssettInfoList[j].assetNumber[x] + "</a></span>";
												}
												htm += "</div></li>";
											}
											htm += "</ul><div class='btn-wrap'><div class='btn btn-info my-btn sure-seat'>确定</div></div></div>";

											htm += "</td></tr>";
										}

										$('#productInfoBody').append(htm);
										$(".con-right-first").css("height", $(".con-left").height() - 200);
										$(".b").click(function() {
											$(this).toggleClass('select');
										});

										// 判断哪些资产/座位已经被选中了
										var findTr = $('#productInfoBody').find('tr');
										for (var i = 0; i < findTr.length; i++) {
											for (var j = 0; j < stationArr.length; j++) {
												if (stationArr[j].seatArr.length > 0) {
													if (findTr.eq(i).attr('projectId') == stationArr[j].id) {
														var findSpana = findTr.eq(i).find('.spana');
														for (var x = 0; x < findSpana.length; x++) {
															for (var y = 0; y < stationArr[j].seatArr.length; y++) {
																if (findSpana.eq(x).text().trim() == stationArr[j].seatArr[y]) {
																	findSpana.eq(x).addClass('select');
																	findTr.eq(i).find('.my-btn').eq(0).addClass("btn-warning").html("已选择");
																	var num = findTr.eq(i).find('td').eq(5).attr('dataCount');
																	var selectNum = findTr.eq(i).find('.select').length;
																	findTr.eq(i).find('td').eq(5).text(num - selectNum);
																}
															}
														}
													}
												}
											}
										}

									}
								});
					});

	$('#page1con-right').mouseover(function() {
		$('#page1con-right').find('button').attr('disabled', true);
		var flag = true;
		for (var i = 0; i < stationArr.length; i++) {
			if (stationArr[i].existPackage == "yes") {
				flag = false;
				if (stationArr[i].packageName != null && stationArr[i].seatArr.length > 0) {
					flag = true;
				} else {
					break;
				}
			}
		}
		if (stationArr.length == 0) {
			flag = false;
		}
		if (flag) {
			$('#page1con-right').find('button').attr('disabled', false);
		}
	});

	$(".bcc").click(function() {
		componyRegister();
	});

	// 选择分期
	$('#createContract').click(function() {
		// 创建合同
		// findOrderInfoByContractId(14)
		$('.sure-agreement').show();
		$(".b-wrap").removeClass("hidden");
	});

	$('#saveFavourCode').click(function() {
		discountNumber = document.getElementById("inputDiscountNumber").value;// 输入的优惠码
		if (discountNumber == "" || discountNumber == null) {
			alert("请输入折扣码!");
		} else {
			if (checkFavourCode(discountNumber)) {
				favourCode = discountNumber;
				alert("折扣码使用成功！");
				calculateMethod();
			} else {
				alert("请输入正确的折扣码！");
			}
		}

	});

	var currentDate = new Date();
	$('#deadline').val((new Date(currentDate.getTime() + 24 * 60 * 60 * 1000)).Format("yyyy-MM-dd"));

});

function checkFavourCode(code) {// 验证优惠码
	if (code == "" || code == "00") {
		return false;
	} else {
		var flag = false;
		$.ajax({
			url : 'filter/offlineReserve/checkFavourCode',
			type : 'post',
			data : {
				'code' : code
			},
			cache : false,
			dataType : 'json',
			async : false,
			success : function(data) {
				flag = data;
				return flag;
			}
		});
		return flag;
	}

}

function getDiscountPrice(price, code, productType, productId) {// 解析优惠码
																// 返回产品折后价价格
	var discountPrice = "0";
	if (code == "00") {
		return price;
	} else {
		$.ajax({
			url : 'filter/offlineReserve/getDiscountPrice',
			type : 'post',
			data : {
				'price' : price,
				'favourCode' : code,
				'productType' : productType,
				'productId' : productId
			},
			cache : false,
			dataType : 'json',
			async : false,
			success : function(data) {
				discountPrice = data;
			}
		});
		return discountPrice;
	}
}

function allocationUser() {
	// 点击分配按钮
	var btnInfo = $('.search-result').find('.btn-info');
	var companyName2 = btnInfo.parent().parent().find(".filling-name").text();
	var userName2 = btnInfo.parent().parent().find(".td-name").text();
	var userPhone2 = btnInfo.parent().parent().find(".td-number").text();
	var companyId = btnInfo.parent().parent().attr('companyId');
	var userId = btnInfo.parent().parent().attr('userId');
	var userMail = btnInfo.parent().parent().attr('userMail');
	if (userId != 0 && userId != null) {
		allotUserArr = [];
		allotUserArr.push(userId);
		allotUserArr.push(companyId);
		allotUserArr.push(userMail);
		allotUserArr.push(companyName2);
		allotUserArr.push(userName2);
		$('#userEmailInputId').val(userMail);
		$('.pbo').find('button').eq(1).attr('disabled', false);
		userId = null;
		var html = '';
		if (userName2 != '空') {
			html = "<div class='test-people'>已分配给会员：<p>" + userName2 + "(公司：" + companyName2 + ")" + "</p></div>";
		} else {
			html = "<div class='test-people'>已分配给会员：<p>" + userPhone2 + "(公司：" + companyName2 + ")" + "</p></div>";
		}
		$('#fenpaiDiv').find('.test-people').remove();
		$('#fenpaiDiv').append(html);
	}
}

function selectCurrentSpace(val) {
	if (val == 2) {// 会议室
		$('#meetingRoomDate').show();
		$('#elasticStationRoomDate').hide();// 工位
		$('#officeRoomDate').hide();// 办公室
		$('#openTypeStationRoomDate').hide();// 开放式工位
	}
	if (val == 1) {
		$('#meetingRoomDate').hide();
		$('#elasticStationRoomDate').hide();// 弹性工位
		$('#officeRoomDate').find(".li-show").show();
		$('#officeRoomDate').show();// 开放式工位
		$('#date-div').val("");
		$('#endDate').val("");
	}
	if (val == 3) {
		$('#meetingRoomDate').hide();
		$('#elasticStationRoomDate').hide();// 工位
		$('#officeRoomDate').find(".li-show").hide();
		$('#officeRoomDate').show();// 办公室
		$('#date-div').val("");
		$('#endDate').val("");
	}
	if (val == 4) {
		$('#meetingRoomDate').hide();
		$('#elasticStationRoomDate').show();// 工位
		$('#officeRoomDate').hide();// 办公室
	}
}

function gotoPageCreateContract() {
	$('#bookTitle').text("合同预览");
	contractId = $('#contractId').val();
	if (contractId == "" || contractId == null)
		return;
	$('.sure-agreement').hide();
	findOrderInfoByContractId(contractId);
	var index = 4;
	$(".pay-con").eq(index).removeClass("hidden").siblings(".pay-con").addClass('hidden');
	$(".mod").eq(index).addClass('current-step').siblings(".mod").removeClass("current-step");
	$(".b-wrap").addClass("hidden");
}

function createContract() {
	$('.sure-agreement').hide();
	var flag = createOrder(1);
	if (!flag) {
		$('.promptBox').find('p').text("订单创建失败，请提交相关信息给后台管理人员！");
		$('.promptBox').show();
		$(".b-wrap").removeClass("hidden");
		return;
	}
	var index = 4;
	$(".pay-con").eq(index).removeClass("hidden").siblings(".pay-con").addClass('hidden');
	$(".mod").eq(index).addClass('current-step').siblings(".mod").removeClass("current-step");
	$(".b-wrap").addClass("hidden");
}

function closePaymentMethod() {
	var index = 4;
	$(".pay-con").eq(index).removeClass("hidden").siblings(".pay-con").addClass('hidden');
	$(".mod").eq(index).addClass('current-step').siblings(".mod").removeClass("current-step");
}

function getUserInfoByPhone(phone) {
	$
			.ajax({
				url : 'filter/offlineReserve/findUserInfo',
				type : 'post',
				data : {
					'phone' : phone
				},
				cache : false,
				dataType : 'json',
				async : false,
				success : function(data) {
					$('.search-result').find('tr').remove();
					$(".order-rights").css("display", "none");
					$(".order-right").css("display", "block");
					var htm = "";
					htm += "<tr class='person-list'><td ><i class='glyphicon glyphicon-user'></i></td><td class='td-name'>会员名称</td><td class='td-number'>会员手机号</td><td>所属公司</td><td>点击选择</td></tr>";

					for (var i = 0; i < data.length; i++) {
						var username = "空";
						if (data[i].userName != null) {
							username = data[i].userName;
						}
						htm += "<tr class='person-list' userId='"
								+ data[i].userId
								+ "'  companyId='' userMail='"
								+ data[i].userMail
								+ "'  ><td><i class='glyphicon glyphicon-user'></i></td><td class='td-name'>"
								+ username
								+ "</td>"
								+ "<td class='td-number'>"
								+ data[i].userPhone
								+ "</td><td><div class='dropdown choose-name'><button class='btn btn-default dropdown-toggle filling-name' type='button' id='dropdownMenu1' data-toggle='dropdown' aria-haspopup='true' aria-expanded='true'>"
								+ "选择公司" + "<span class='caret'></span></button><ul class='dropdown-menu company-date' aria-labelledby='dropdownMenu1'>";
						for (var j = 0; j < data[i].comanyInfoList.length; j++) {
							htm += "<li companyId='" + data[i].comanyInfoList[j].companyId + "'><a>" + data[i].comanyInfoList[j].companyName + "</a></li>";
						}
						htm += "<li class='sepcial-company'>+新增公司</li>"
								+ "</ul></div></td><td><button type='button' class='btn btn-default bts' onclick='userSelected(this)'>选择</button></td></tr>";
					}

					$('.search-result').append(htm);

					clickUpDown();
				}
			});
}

// 选择分期
function selectStages() {
	var selectedVal = $('#selectStages option:selected').val();
	if (selectedVal == 5) {
		$('#stagesData').find('p').text("");
		return;
	}// selectStagesStr
	var arr = getOrderCommitParamsArr();
	$.ajax({
		url : 'filter/offlineReserve/getTimeInterval',
		type : 'post',
		data : {
			arr : JSON.stringify(arr)
		},
		traditional : true,
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			// 测试
			// 生成合同或者意向书页面的数据
			if (!data) {
				$('.promptBox').find('p').text("时间选择不满足当前分期要求！");
				$('.promptBox').show();
				$(".b-wrap").removeClass("hidden");
				$('#selectStages').get(0).selectedIndex = 0;
				$('#stagesData').find('p').text("");
			} else {
				getByStagesData(2);
			}

		}
	});
}

function getByStagesData(mark) {

	var arr = getOrderCommitParamsArr();
	/*
	 * if(mark==1){ for(var i=0;i<arr.length-1;i++){ arr[i].splitSign = 1; } }
	 */
	$.ajax({
		url : 'filter/offlineReserve/getByStagesData',
		type : 'post',
		data : {
			arr : JSON.stringify(arr),
		},
		traditional : true,
		async : false,
		cache : false,
		dataType : 'json',
		success : function(data) {
			if (mark == 1) {
				var resultTotal = Math.floor(data[0]) + Math.floor(data[1]) + Math.floor(data[2]);
				var totalStr = "";
				if (resultTotal != 0)
					totalStr = "总金额:￥" + resultTotal + "  ";
				if (meetingBag != 0)
					totalStr = totalStr + meetingBag + "个会议室券   ";
				if (peopleDayBag != 0)
					totalStr = totalStr + peopleDayBag + "张弹性工位券";
				$('#orderTotal').val(resultTotal);
				$('#orderPageTotal').find('p').eq(3).text(totalStr);
			}
			if (mark == 2) {
				var resultTotal = Math.floor(data[0]) + Math.floor(data[1]) + Math.floor(data[2]);
				var totalStr = "";
				if (resultTotal != 0)
					totalStr = "总金额:￥" + resultTotal + "  ";
				if (meetingBag != 0)
					totalStr = totalStr + meetingBag + "个会议室券   ";
				if (peopleDayBag != 0)
					totalStr = totalStr + peopleDayBag + "张弹性工位券";
				$('#orderTotal').val(resultTotal);
				$('#orderPageTotal').find('p').eq(3).text(totalStr);
				$('#stagesData').find('p').eq(0).text("首期应付：￥" + Math.floor(data[0]));
				$('#stagesData').find('p').eq(1).text("中间应付：￥" + Math.floor(data[1]));
				$('#stagesData').find('p').eq(2).text("末期应付：￥" + Math.floor(data[2]));
			}
		}
	});

}

// 选中某个用户
function userSelected(t) {
	// var text=$('#dropdownMenu1').text();
	$('.person-list').find('button').removeClass('btn-info')
	$(t).toggleClass("btn-info");
	var text = $(t).parent().parent().find(".filling-name").text();
	if (text.trim() == '选择公司' || text.length == 0) {
		$('.promptBox').find('p').text("请选择公司！")
		$('.promptBox').show();
		$(".b-wrap").removeClass("hidden");
		$(t).removeClass("btn-info");
		$('.pbo').find('button').eq(1).attr('disabled', true);
	}
	allocationUser()
}

//
function packageOptionClick(currentThis) {
	// var seatId = $(currentThis).parent().parent().attr('id')
	var packageNoId = $(currentThis).parent().parent().attr('packageNoId');
	var packageType = 5;
	// packagePrice =
	// $(currentThis).find("option:selected").val()=="点击选择"?$(currentThis).find("option:selected").val():getDiscountPrice($(currentThis).find("option:selected").val(),favourCode,5,packageId);
	// //智慧包原价 优惠码折扣加在这里
	packagePrice = $(currentThis).find("option:selected").val();
	if (packagePrice == "点击选择") {
		removePackageInfo(packageNoId);
		calculateMethod();// 计算价格
		return;
	}
	var packageName = $(currentThis).find("option:selected").text();
	var packageUnit = $(currentThis).find("option:selected").attr("packageUnit");
	var packageId = $(currentThis).find("option:selected").attr("packageIdData");
	var packageDiscountPrice = $(currentThis).find("option:selected").attr("packageDiscountPrice");
	var discountProductType = $(currentThis).find("option:selected").attr("discountProductType");
	var discountProductId = $(currentThis).find("option:selected").attr("discountProductId");
	var incrementLevel = $(currentThis).find("option:selected").attr("incrementLevel");
	console.log(incrementLevel)
	addPackageInfo(packageNoId, packageType, packageName, packagePrice, packageId, packageUnit, packageDiscountPrice, discountProductType, discountProductId,
			incrementLevel);
	// 获取电信设置费
	console.log(stationArr);
	var liNum = $('.item-list').find('li').length;
	calculateMethod();// 计算价格
}
// 添加智慧宝信息
function addPackageInfo(packageNoId, packageType, packageName, packagePrice, packageId, packageUnit, packageDiscountPrice, discountProductType,
		discountProductId, incrementLevel) {
	for (var i = 0; i < stationArr.length; i++) {
		if (stationArr[i].packageNoId == packageNoId) {
			stationArr[i].packageType = packageType;
			stationArr[i].packagePrice = packagePrice;
			stationArr[i].packageName = packageName;
			stationArr[i].packageId = packageId;
			stationArr[i].packageUnit = packageUnit;
			stationArr[i].packageIncrementLevel = incrementLevel;
			stationArr[i].packageDiscountPrice = packageDiscountPrice;
			stationArr[i].discountProductType = discountProductType;
			stationArr[i].discountProductId = discountProductId;
			break;
		}
	}
}

// 删除智慧宝信息
function removePackageInfo(packageNoId) {
	for (var i = 0; i < stationArr.length; i++) {
		if (stationArr[i].packageNoId == packageNoId) {
			stationArr[i].packageType = null;
			stationArr[i].packagePrice = null;
			stationArr[i].packageName = null;
			stationArr[i].packageId = null;
			stationArr[i].packageUnit = null;
			stationArr[i].packageDiscountPrice = null;
			stationArr[i].packageIncrementLevel = null;
			stationArr[i].discountProductType = null;
			stationArr[i].discountProductId = null;
			break;
		}
	}
}

Date.prototype.Format = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, // 月份
		"d+" : this.getDate(), // 日
		"h+" : this.getHours(), // 小时
		"m+" : this.getMinutes(), // 分
		"s+" : this.getSeconds(), // 秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
		"S" : this.getMilliseconds()
	// 毫秒
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

// 获取选中办公位置的项目所对应的空间类型
function getCurrentProjectSpactType(val) {
	$('#spaceSelected').find('option').remove();
	$.ajax({
		url : 'filter/offlineReserve/getProjectSpaceType',
		type : 'post',
		data : {
			'projectId' : val
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			debugger;
			var htm = "";
			for (var i = 0; i < data.length; i++) {
				if (data[i].spaceId == 3) {
					htm += "<option value='" + data[i].spaceId + "'  selected='selected'>" + data[i].spaceName + "</option>";
				} else {
					htm += "<option value='" + data[i].spaceId + "'>" + data[i].spaceName + "</option>";
				}
			}
			$('#spaceSelected').append(htm);

		}
	});
	var spaceType = $('#spaceSelected option:selected').val();
	if (spaceType == 1 || spaceType == 3) {// 开放式工位
		$('#meetingRoomDate').hide();
		$('#elasticStationRoomDate').hide();// 弹性工位
		$('#officeRoomDate').show();// 办公室
	}
	if (spaceType == 2) {// 会议室
		$('#meetingRoomDate').show();
		$('#elasticStationRoomDate').hide();// 弹性工位
		$('#officeRoomDate').hide();// 办公室
	}
	if (spaceType == 4) {// 弹性工位
		$('#meetingRoomDate').hide();
		$('#elasticStationRoomDate').show();// 弹性工位
		$('#officeRoomDate').hide();// 办公室
	}
}

function update() {
	$(".updateContract").show();
	$(".updateContract").removeClass("hidden");
	$(".b-wrap").removeClass("hidden");
}

// 显示座位弹框
function showAlert(t) {
	price = $(t).parent().parent().find("td").eq(4).attr('dataMoney');
	var unit = $(t).parent().parent().find("td").eq(4).attr('dataUnit');
	var unitEnum = $(t).parent().parent().find("td").eq(4).attr('dataUnitEnum');
	var productType = $(t).parent().parent().find("td").eq(1).attr('productType');
	var productArea = $(t).parent().parent().find("td").eq(1).attr('productArea');
	var projectName = $(t).parent().parent().attr('projectName');
	var projectId = $(t).parent().parent().attr('pjId');
	var type = $(t).parent().parent().attr('type');
	if (($('#inputAssetId').val().trim() != "")) {
		$(t).siblings(".seat-alert").find(".b").addClass('select');
	} else {
		$(t).siblings(".seat-alert").css("margin-top", "-" + parseInt($(t).siblings(".seat-alert").css("height")) / 2 + "px");
		$(t).siblings(".seat-alert").show();
		$(".b-wrap").removeClass("hidden");
	}
	debugger;
	pTitle = $(t).parent().parent().find("td").eq(0).text();

	var typeTitle = $(t).parent().parent().find("td").eq(2).text().trim();
	var productName = $(t).parent().parent().find("td").eq(1).text().trim();
	markId = $(t).parent().parent().attr("projectId");

	var initSelected = $(t).siblings(".seat-alert").find(".b.select");

	// 点击取消按钮开始
	$(".exitBtn").unbind("click");
	$(".exitBtn").click(function() {
		$(this).parent().parent().find("a").removeClass('select');
		var currentAllA = $(this).parent().parent().find("a");
		for (var i = 0; i < initSelected.length; i++) {
			for (var j = 0; j < currentAllA.length; j++) {
				if (initSelected.eq(i).attr('assetid') == currentAllA.eq(j).attr('assetid')) {
					initSelected.eq(i).addClass('select');
				}
			}
		}
		hideAlert();
		$(".b-wrap").addClass("hidden");
	});
	// 点击取消按钮结束
	// $('#right-seat').find('#serverSelect').find('option').remove();
	$(".sure-seat").unbind("click");
	$(".sure-seat").click(
			function() {
				debugger;
				var input = $(t).parent().find('input');
				var tml = "<option >点击选择</option>";
				var existPackage = "no";
				if (input.length > 0) {
					existPackage = "yes";
					// ============================================
					var clickSelected = $(t).siblings(".seat-alert").find(".b.select");
					var allSelected = $(t).parent().parent().parent().find(".b.select");
					var selectedAssertStr = "";// 多个产品拥有同一个资产，可能选择重复

					if (clickSelected.length != 0)
						for (var j = 0; j < clickSelected.length; j++) {
							var selectedAssetIndex = 0;
							for (var x = 0; x < allSelected.length; x++) {
								if (allSelected.eq(x).attr('assetId') == clickSelected.eq(j).attr('assetId')) {
									selectedAssetIndex++;
									if (selectedAssetIndex > 1) {
										selectedAssertStr += clickSelected.eq(j).text().trim() + "  ";
										break;
									}
								}
							}
						}
					if (selectedAssertStr != "") {
						$('.promptBox').find('p').text(selectedAssertStr + "已被选择！");
						$('.promptBox').show();
						$(".b-wrap").removeClass("hidden");
						return;
					}

					var selectedArr = [];// 第二次点击被替换掉的
					for (var i = 0; i < initSelected.length; i++) {
						var initSelectedAssetId = initSelected.eq(i).attr('assetid');
						if (clickSelected.length == 0) {
							var rightDivClass = $('.rightDivClass');
							for (var x = 0; x < rightDivClass.length; x++) {
								if (rightDivClass.eq(x).attr('id') == markId) {
									var liElement = rightDivClass.eq(x).find('.item-list').find('li');
									for (var y = 0; y < liElement.length; y++) {
										if (liElement.eq(y).attr('assetId') == initSelectedAssetId) {
											var id = rightDivClass.eq(x).attr('id');
											var packageNoId = rightDivClass.eq(x).attr('packageNoId');
											var str = liElement.eq(y).text();
											var assetId = liElement.eq(y).attr('assetId');
											var substr = str.substr(0, str.length - 1);
											deleteSpanInfo(id, assetId);
											calculateMethod();// 删除标签之后重新计算价格
											console.log(stationArr)
											liElement.eq(y).remove();
											var spanLength = rightDivClass.eq(x).find(".item-list").find("span").length;
											deleteSpanInfoSelected(id, str, spanLength, packageNoId);
											if (spanLength == 0) {
												debugger;
												// removePackageInfo(id);
												removeObjStory(id, packageNoId);
												rightDivClass.eq(x).find('.server').hide();
												rightDivClass.eq(x).remove()
											}
										}
									}

								}
							}
						}
						for (var j = 0; j < clickSelected.length; j++) {
							var clickSelectedAssetId = clickSelected.eq(j).attr('assetid');
							if (initSelectedAssetId == clickSelectedAssetId) {
								break;
							}
							if (j == clickSelected.length - 1) {
								// selectedArr.push(initSelectedAssetId);
								var rightDivClass = $('.rightDivClass');
								for (var x = 0; x < rightDivClass.length; x++) {
									if (rightDivClass.eq(x).attr('id') == markId) {
										var liElement = rightDivClass.eq(x).find('.item-list').find('li');
										for (var y = 0; y < liElement.length; y++) {
											if (liElement.eq(y).attr('assetId') == initSelectedAssetId) {
												var id = rightDivClass.eq(x).attr('id');
												var packageNoId = rightDivClass.eq(x).attr('packageNoId');
												var str = liElement.eq(y).text();
												var assetId = liElement.eq(y).attr('assetId');
												var substr = str.substr(0, str.length - 1);
												deleteSpanInfo(id, assetId);
												calculateMethod();// 删除标签之后重新计算价格
												console.log(stationArr)
												liElement.eq(y).remove();
												var spanLength = rightDivClass.eq(x).find(".item-list").find("span").length;
												deleteSpanInfoSelected(id, str, spanLength, packageNoId);
												if (spanLength == 0) {
													debugger;
													// removePackageInfo(id);
													removeObjStory(id, packageNoId);
													rightDivClass.eq(x).find('.server').hide();
													rightDivClass.eq(x).remove()
												}
											}
										}

									}
								}
							}
						}
					}

					// ===================================
				}
				console.log(input);
				for (var i = 0; i < input.length; i++) {
					console.log(input.eq(i));
					tml += "<option packageIdData='" + input.eq(i).attr('productId') + "' value='" + input.eq(i).attr('ratePriceFee') + "' packageUnit='"
							+ input.eq(i).attr('unit') + "' incrementLevel='" + input.eq(i).attr('incrementLevel') + "'  packageDiscountPrice='"
							+ input.eq(i).attr('discountPrice') + "' discountProductType='" + input.eq(i).attr('discountProductType') + "' discountProductId='"
							+ input.eq(i).attr('discountProductId') + "' >" + input.eq(i).attr('incrementProductName') + " " + input.eq(i).attr('ratePriceFee')
							+ "/" + input.eq(i).attr('unit') + "</option>";
				}
				$('#serverSelect').find('option').remove();
				$('#serverSelect').append(tml);
				var idAndSelectedArr = sureCon(t, markId, pTitle, productName, typeTitle, existPackage);
				totalPriceArr.push(num * price)
				/*
				 * var projectName=$('#projectSelected
				 * option:selected').attr('projectNameData'); var
				 * projectId=$('#projectSelected option:selected').val(); var
				 * type = $('#spaceSelected option:selected').val();
				 */
				var volume = $(t).parent().parent().find('td').eq(3).text().trim();
				var timeEnough = "no";
				if (judgeDateIsTimeEnough(startTime, endTime)) {
					timeEnough = "yes";
				}
				var num = $(t).parent().parent().find('td').eq(5).attr('dataCount');
				var selectNum = $(t).parent().parent().find('.select').length;
				if (selectNum > 0) {
					pushProjectArrData(projectName);
				}
				if (selectNum > 0 && idAndSelectedArr != null) {
					pushStationArrData(new ObjStory(indexObjStory++, markId, projectName, projectId, productName, typeTitle, type, idAndSelectedArr[1],
							idAndSelectedArr[0], price, volume, null, null, null, null, null, null, timeEnough, startTime, endTime, unit, unitEnum, null,
							existPackage, 0, 0, 0, 0, null, idAndSelectedArr[2], productType, productArea, 0, 0, null, null, 0, false, 0, 0))
					console.log(stationArr)
					calculateMethod();
				}
				$(t).parent().parent().find('td').eq(5).text(num - selectNum);
				if (selectNum > 0) {
					$(t).addClass("btn-warning").html("已选择");
				} else {
					$(t).removeClass("btn-warning").html("选择座位");// btn-wrap
					$(t).parent().parent().find('.btn-wrap').find('div').eq(0).removeClass("btn-warning").html("确定");
				}
				//
				var rightDivClasss = $('#page1con-right').find('.rightDivClass');

				for (var i = 0; i < rightDivClasss.length; i++) {
					if (rightDivClasss.eq(i).attr('id') == markId) {
						rightDivClasss.eq(i).find('.server').show();
						if (input.length == 0) {
							rightDivClasss.eq(i).find('.server').hide();
						}
					}
				}
				$(".b-wrap").addClass("hidden");
			});
	if (($('#inputAssetId').val().trim() != "")) {
		debugger;
		$(".sure-seat").trigger('click');
	}
}

function judgeDateIsTimeEnough(startTime, endTime) {
	debugger;
	var resurt = false;
	$.ajax({
		url : 'filter/offlineReserve/judgeDateIsTimeEnough',
		type : 'post',
		data : {
			'startTime' : startTime,
			'endTime' : endTime
		},
		cache : false,
		dataType : 'json',
		async : false,
		success : function(data) {
			resurt = data;
		}
	});

	return resurt;
}

function removeObjStory(id, packageNoId) {
	if (typeof packageNoId == 'undefined') {
		var tempArr = [];
		for (var i = 0; i < stationArr.length; i++) {
			if (stationArr[i].id != id) {
				tempArr.push(stationArr[i]);
			}
		}
		stationArr = tempArr;
	} else {
		var tempArr = [];
		for (var i = 0; i < stationArr.length; i++) {
			if (stationArr[i].id != id) {
				tempArr.push(stationArr[i]);
			} else {
				if (stationArr[i].packageNoId != packageNoId) {
					tempArr.push(stationArr[i]);
				}
			}
		}
		stationArr = tempArr;
	}
	var tempProjectArr = [];
	for (var i = 0; i < projectArr.length; i++) {
		var flag = false;
		for (var j = 0; j < stationArr.length; j++) {
			if (projectArr[i] == stationArr[j].projectName) {
				flag = true;
				break;
			}
		}
		if (flag) {
			tempProjectArr.push(projectArr[i]);
		}
	}
	projectArr = tempProjectArr;
	console.log(stationArr);
}

// 计算数组的和
function getArrTotal(arr) {
	var total = 0;
	for (var i = 0; i < arr.length; i++) {
		total += arr[i];
	}
	return total;
}

function calculateMethod() {
	areaDiscountMark = false;
	rebateAvtive = false;
	productDiscountMark = false;
	var rent = 0;
	var packagePriceTotal = 0;
	var mark = 0;
	var rate = 1;
	var packageFavor = 0;// 智慧包的优惠
	/*
	 * var meetingBag = 0;//会议室券 var peopleDayBag = 0;//弹性工位券
	 */var margin = 0;// 保证金
	meetingBag = 0;
	peopleDayBag = 0;
	var disposableCost = 0;
	var telecomSetCost = 0;
	var rateRent = 0;
	// 计算房租
	for (var i = 0; i < projectArr.length; i++) {
		// 判断是否是组合优惠
		var returnArr = calculateCombinationTotal(projectArr[i]);
		rent += returnArr[0];
		// packageFavor += returnArr[1];
		meetingBag += returnArr[2];
		peopleDayBag += returnArr[3];
		margin += (returnArr[4] * getEnsureNumber());
		disposableCost += returnArr[5];
		telecomSetCost += returnArr[6];
	}
	rateRent = rent;
	if (productDiscountMark) {
		rate = rate * (1 - productDiscount);// 组合优惠
		rateRent = rateRent * productDiscount;
	}
	for (var i = 0; i < stationArr.length; i++) {
		if (stationArr[i].packagePrice != null) {
			if (stationArr[i].upPackageObj != null) {// 计算升级之后的智慧包的价格
				// alert(stationArr[i].upPackageObj.packagePrice)
				var favourPriceFee = getDiscountPrice(stationArr[i].upPackageObj.packagePrice, favourCode, stationArr[i].upPackageObj.packageType,
						stationArr[i].upPackageObj.packageId);
				// alert(favourPriceFee)
				var packagePrice = favourPriceFee * stationArr[i].seatArr.length * stationArr[i].volume;
				var calculatePackageResult = calculateDatePrice(stationArr[i].startTime, stationArr[i].endTime, packagePrice,
						stationArr[i].upPackageObj.packageUnit, stationArr[i].upPackageObj.packageType);
				packagePriceTotal = addFn(packagePriceTotal, Math.floor(calculatePackageResult));
				stationArr[i].calculatePackageResult = Math.floor(calculatePackageResult);
			} else {
				// alert(stationArr[i].packagePrice)
				var favourPackagePrice = getDiscountPrice(stationArr[i].packagePrice, favourCode, stationArr[i].packageType, stationArr[i].packageId);
				// alert(favourPackagePrice)
				var packagePrice = favourPackagePrice * stationArr[i].seatArr.length * stationArr[i].volume;
				var calculatePackageResult = calculateDatePrice(stationArr[i].startTime, stationArr[i].endTime, packagePrice, stationArr[i].packageUnit,
						stationArr[i].packageType);
				packagePriceTotal = addFn(packagePriceTotal, Math.floor(calculatePackageResult));
				stationArr[i].calculatePackageResult = Math.floor(calculatePackageResult);
			}
		}
	}
	// 跨点优惠
	if (projectArr.length > 1) {
		rate = rate * (1 - areaDiscount);
		// areaDiscountMark = true;
		rateRent = rateRent * areaDiscount;
	}

	var areaProductFavor = 0;
	for (var i = 0; i < stationArr.length; i++) {
		var currentPackageFavor = stationArr[i].packageFavor;
		if (stationArr[i].type == 1 || stationArr[i].type == 3) {
			if (productDiscountMark) {
				$('#oederPageInfo').append("<p>尊享跨产品折扣：98折</p>");
			}
			packageFavor += Math.ceil(currentPackageFavor);
		}
	}

	// 计算折扣码优惠
	if (rebateAvtive) {
		// 表示折扣
		rate = rate * rebatePercent;
		rateRent = rateRent * rebatePercent;
	}
	if (rate == 1) {
		rate = 0;
	}
	$('#priceExpense').find('p').remove();
	$('#rebatePageExpense').find('p').remove();
	$('#oederPageInfo').find('p').remove();
	if (rent != 0) {
		$('#priceExpense').append("<p>房费：￥" + Math.floor(rent) + "</p>");
		$('#rebatePageExpense').append("<p>房费：￥" + Math.floor(rent) + "</p>");
		$('#oederPageInfo').append("<p>房费：￥" + Math.floor(rent) + "</p>");
	}
	if (packagePriceTotal != 0) {
		$('#priceExpense').append("<p>服务费：￥" + Math.floor(packagePriceTotal) + "</p>");
		$('#rebatePageExpense').append("<p>服务费：￥" + Math.floor(packagePriceTotal) + "</p>");
		$('#oederPageInfo').append("<p>服务费：￥" + Math.floor(packagePriceTotal) + "</p>");
	}
	if (margin != 0) {
		/* $('#oederPageInfo').append("<p>保证金：￥"+Math.floor(margin)+"<span>编辑</span></p>"); */
		$('#oederPageInfo').append("<p class='marginP'>保证金：￥" + Math.floor(margin) + "</p>");
	}
	if (packageFavor != 0) { // 计算智慧包优惠
		$('#priceExpense').append("<p>智慧包减免优惠：￥" + Math.floor(packageFavor) + "</p>");
		$('#rebatePageExpense').append("<p>智慧包减免优惠：￥" + Math.floor(packageFavor) + "</p>");
		$('#oederPageInfo').append("<p>智慧包减免优惠：￥" + Math.floor(packageFavor) + "</p>");
	}
	if (peopleDayBag != 0) {
		$('#priceExpense').append("<p>所需弹性工位券为" + peopleDayBag + "张</p>");
		$('#rebatePageExpense').append("<p>所需弹性工位券为" + peopleDayBag + "张</p>");
		$('#oederPageInfo').append("<p>所需弹性工位券为" + peopleDayBag + "张</p>");
	}
	if (meetingBag != 0) {
		$('#priceExpense').append("<p>所需会议室券为" + meetingBag + "个</p>");
		$('#rebatePageExpense').append("<p>所需会议室券为" + meetingBag + "个</p>");
		$('#oederPageInfo').append("<p>所需会议室券为" + meetingBag + "个</p>");
	}
	// 一次性费用
	if (disposableCost != 0) {
		$('#priceExpense').append("<p>一次性费用：￥" + Math.floor(disposableCost) + "</p>");
		$('#oederPageInfo').append("<p>一次性费用：￥" + Math.floor(disposableCost) + "</p>");
	}
	if (telecomSetCost != 0) {
		$('#priceExpense').append("<p>一次性电信设置费用：￥" + Math.floor(telecomSetCost) + "</p>");
		$('#oederPageInfo').append("<p>一次性电信设置费用：￥" + Math.floor(telecomSetCost) + "</p>");
	}
	if (areaDiscountMark) {
		$('#oederPageInfo').append("<p>尊享跨项目折扣：98折</p>");
	}
	if (productDiscountMark) {
		$('#oederPageInfo').append("<p>尊享跨产品折扣：98折</p>");
	}
	/*
	 * var selectedStageVal=$('#selectStages option:selected').val();
	 * if(selectedStageVal==5)$('#oederPageInfo').append("<p class='selectStagesStr'>尊享付款节奏折扣：96折</p>");
	 * if(selectedStageVal==3)$('#oederPageInfo').append("<p class='selectStagesStr'>尊享付款节奏折扣：97折</p>");
	 * if(selectedStageVal==2)$('#oederPageInfo').append("<p class='selectStagesStr'>尊享付款节奏折扣：98折</p>");
	 */
	if (rebateAvtive || productDiscountMark || areaDiscountMark) {
		areaProductFavor = Math.floor(areaProductFavor);
	}
	margin = Math.floor(margin);
	rent = Math.floor(rent);
	packagePriceTotal = Math.floor(packagePriceTotal);

}

function calculateCombinationTotal(projectName) {
	productDiscountMark = false;
	var index = 0;
	var rent = 0;
	var flag = 0;
	var packageFavor = 0;
	var returnArr = [];
	var meetingBag = 0;
	var peopleDayBag = 0;
	var disposableCost = 0;
	var type;
	var margin = 0;// 保证金
	var telecomSetCost = 0;// 一次性电信设置费用
	for (var i = 0; i < stationArr.length; i++) {
		if (stationArr[i].seatArr.length > 0) {
			if (flag == 0 && stationArr[i].productType != 2 && stationArr[i].productType != 4) {
				type = stationArr[i].type;
				flag = 1;
			}
			if (type != stationArr[i].type && stationArr[i].productType != 2 && stationArr[i].productType != 4) {// 独立办公室+固定工位
				index++;
			}
		}
	}
	if (index > 0) {
		// productDiscountMark = true;
	}
	for (var i = 0; i < stationArr.length; i++) {

		if (stationArr[i].projectName == projectName && stationArr[i].seatArr.length > 0) {

			if (stationArr[i].type == 2) {// 计算会议室券
				var timePoor = getTimePoor(stationArr[i].startTime, stationArr[i].endTime, 2);
				var currentMeetingBag = stationArr[i].seatArr.length * timePoor * stationArr[i].volume * stationArr[i].price;
				meetingBag += currentMeetingBag;
				stationArr[i].calculateResult = currentMeetingBag;

			} else if (stationArr[i].type == 4) {// 计算弹性工位券包 弹性工位
				var timePoor = getTimePoor(stationArr[i].startTime, stationArr[i].endTime, 4);
				var currentPeopleDayBag = stationArr[i].seatArr.length * timePoor * stationArr[i].volume * stationArr[i].price;
				peopleDayBag += currentPeopleDayBag;
				stationArr[i].calculateResult = currentPeopleDayBag;
			} else {
				// price = stationArr[i].price * stationArr[i].seatArr.length *
				// stationArr[i].volume;
				// alert(stationArr[i].price)
				var favourPrice = getDiscountPrice(stationArr[i].price, favourCode, stationArr[i].productType, stationArr[i].id)
				// alert(favourPrice)
				// price = stationArr[i].price * stationArr[i].seatArr.length ;
				// //价格 乘以优惠券折扣 加在这里
				price = favourPrice * stationArr[i].seatArr.length; // 价格
																	// 乘以优惠券折扣
																	// 加在这里
				if (stationArr[i].packagePrice != null) {
					var val = calculateDatePrice(stationArr[i].startTime, stationArr[i].endTime, price, stationArr[i].unit, stationArr[i].type);
					stationArr[i].calculateResult = Math.floor(val);
					if (stationArr[i].discountProductType == 6) {// 具有减免房租的特性
						var discountPrice = 0;
						var valPackage = 0;
						if (stationArr[i].upPackageDiscountObj != null) {
							var tempValPackage = 0;
							// alert(stationArr[i].upPackageDiscountObj.upPackageDiscountPrice)
							var favourDiscountPrice = getDiscountPrice(stationArr[i].upPackageDiscountObj.upPackageDiscountPrice, favourCode,
									stationArr[i].upPackageDiscountObj.upPackageType, stationArr[i].upPackageDiscountObj.upPackageId);
							// alert(favourDiscountPrice)
							discountPrice = favourDiscountPrice * stationArr[i].seatArr.length * stationArr[i].volume;
							tempValPackage = calculateDatePrice(stationArr[i].startTime, stationArr[i].endTime, discountPrice,
									stationArr[i].upPackageDiscountObj.upPackageUnit, stationArr[i].type);
							if (stationArr[i].favorableLastMonth)
								tempValPackage = tempValPackage - discountPrice;
							// alert(stationArr[i].upPackageObj.packageDiscountPrice)
							var favourDiscountPrice = getDiscountPrice(stationArr[i].upPackageObj.packageDiscountPrice, favourCode,
									stationArr[i].upPackageObj.upPackageType, stationArr[i].upPackageObj.upPackageId);
							// alert(favourDiscountPrice)
							discountPrice = favourDiscountPrice * stationArr[i].seatArr.length * stationArr[i].volume;
							valPackage = calculateDatePrice(stationArr[i].startTime, stationArr[i].endTime, discountPrice,
									stationArr[i].upPackageObj.packageUnit, stationArr[i].type);
							if (stationArr[i].favorableLastMonth)
								valPackage = valPackage - discountPrice;
							valPackage = valPackage + tempValPackage;
						} else {
							// alert(stationArr[i].packageDiscountPrice)
							var favourPackageDiscountPrice = getDiscountPrice(stationArr[i].packageDiscountPrice, favourCode, stationArr[i].packageType,
									stationArr[i].packageId)
							// alert(favourPackageDiscountPrice)
							discountPrice = favourPackageDiscountPrice * stationArr[i].seatArr.length * stationArr[i].volume;
							valPackage = calculateDatePrice(stationArr[i].startTime, stationArr[i].endTime, discountPrice, stationArr[i].unit,
									stationArr[i].type);
							if (stationArr[i].favorableLastMonth)
								valPackage = valPackage - discountPrice;
						}
						stationArr[i].packageFavor = valPackage;
						if ((Math.abs(valPackage) - val) < 0) {// 如果智慧包的优惠大于房租,那么房租设置为0，但是保证金的价格还是不会优惠的
							packageFavor += Math.floor(valPackage);
						} else {
							stationArr[i].packageFavor = Math.floor(val);
							packageFavor += Math.floor(val);
						}
					}

					var currentMargin = Math.floor(getMargin(i, stationArr[i].unit, price, 1));
					stationArr[i].margin = currentMargin * getEnsureNumber();// 乘以押金倍数
					// rent=addFn(rent,valPackage);
					rent = addFn(rent, Math.floor(val));
					margin = addFn(margin, currentMargin);
					if (stationArr[i].productType == 3) {// 计算其一次性费用
						var obj = calculateDisposableCost(stationArr[i].projectId, stationArr[i].id, stationArr[i].type, 10);
						if (obj != undefined) {
							// alert(obj.ratePriceFee)
							var favourPriceFee = getDiscountPrice(obj.ratePriceFee, favourCode, obj.productType, obj.productId);
							// alert(favourPriceFee)
							var currentDisposableCost = Math.floor(Math.ceil(stationArr[i].productArea) * favourPriceFee * stationArr[i].seatArr.length);
							disposableCost = addFn(disposableCost, currentDisposableCost);
							stationArr[i].disposableCost = currentDisposableCost;
							stationArr[i].disposableCostPrice = obj.ratePriceFee;// 一次性设置费用单价
						}
					}
					// 计算一次性电信设置费 telecomSetCost
					var obj = calculateDisposableCost(stationArr[i].projectId, stationArr[i].id, stationArr[i].type, 11);
					if (obj != undefined) {
						// alert(obj.ratePriceFee)
						var favourPriceFee = getDiscountPrice(obj.ratePriceFee, favourCode, obj.productType, obj.productId);
						// alert(favourPriceFee)
						var price = favourPriceFee * stationArr[i].volume * stationArr[i].seatArr.length;
						telecomSetCost = addFn(telecomSetCost, Math.floor(price));
						stationArr[i].telecomSetCost = Math.floor(price);// /
					}
				} else {

					var val = calculateDatePrice(stationArr[i].startTime, stationArr[i].endTime, price, stationArr[i].unit, stationArr[i].type);
					rent = addFn(rent, Math.floor(val));
					stationArr[i].calculateResult = val;
					var currentMargin = Math.floor(getMargin(i, stationArr[i].unit, price, 1));
					stationArr[i].margin = currentMargin * getEnsureNumber();// 乘以押金倍数
					margin = addFn(margin, currentMargin);
					if (stationArr[i].productType == 3) {// 计算其一次性费用
						var obj = calculateDisposableCost(stationArr[i].projectId, stationArr[i].id, stationArr[i].type, 10);
						if (obj != undefined) {
							// alert(obj.ratePriceFee)
							var favourPriceFee = getDiscountPrice(obj.ratePriceFee, favourCode, obj.productType, obj.productId);
							// alert(favourPriceFee)
							var currentDisposableCost = Math.floor(Math.ceil(stationArr[i].productArea) * favourPriceFee * stationArr[i].seatArr.length);
							disposableCost = addFn(disposableCost, currentDisposableCost);
							stationArr[i].disposableCost = currentDisposableCost;
							stationArr[i].disposableCostPrice = obj.ratePriceFee;// 一次性设置费用单价
						}
					}
				}
			}

		}
	}

	returnArr.push(rent);
	returnArr.push(packageFavor);
	returnArr.push(meetingBag);
	returnArr.push(peopleDayBag);
	returnArr.push(margin);
	returnArr.push(disposableCost);
	returnArr.push(telecomSetCost);
	return returnArr;
}

// 判断这个日期是在20号之前还是之后
// 获取押金倍数
function judgeDateByDay(time) {
	var flag = false;
	$.ajax({
		url : 'filter/offlineReserve/judgeDateByDay',
		type : 'post',
		data : {
			"time" : time
		},
		async : false,
		traditional : true,
		cache : false,
		dataType : 'json',
		success : function(data) {
			flag = data;
		}
	});
	return flag;
}

// 获取押金倍数
function getEnsureNumber() {
	var count = 3;
	$.ajax({
		url : 'filter/offlineReserve/getEnsureNumber',
		type : 'post',
		data : {},
		async : false,
		traditional : true,
		cache : false,
		dataType : 'json',
		success : function(data) {
			count = data;
		}
	});
	return count;
}

// 获取一次性消费费用
function calculateDisposableCost(projectId, productId, spaceId, productType) {
	var obj;
	for (var z = 0; z < disposableProduct.length; z++) {
		if (disposableProduct[z].projectId == projectId && disposableProduct[z].productType == productType) {
			obj = disposableProduct[z];
			return obj;
		}
	}
	$.ajax({
		url : 'filter/offlineReserve/searchNonrecurringExpense',
		type : 'post',
		data : {
			projectId : projectId
		},
		async : false,
		traditional : true,
		cache : false,
		dataType : 'json',
		success : function(data) {
			debugger;
			for (var i = 0; i < data.length; i++) {
				if (data[i].productType == productType) {// 办公室一次性设置费用
															// productType = 10
					if (data[i].unit == 1) {//
						obj = data[i];
						var money = 0;
						money = data[i].ratePriceFee;
						// disposableProductObj(projectId,productId,productName,validDate,expireDate,capacity,rateId,ratePriceFee,unit,productType){
						var newO = new DisposableProductObj(projectId, data[i].productId, data[i].productName, data[i].validDate, data[i].expireDate,
								data[i].capacity, data[i].rateId, data[i].ratePriceFee, data[i].unit, data[i].productType, productId + spaceId)
						disposableProduct.push(newO);
					}
				}
			}
		}
	});
	return obj;
}

function DisposableProductObj(projectId, productId, productName, validDate, expireDate, capacity, rateId, ratePriceFee, unit, productType, parentNo) {
	this.projectId = projectId;
	this.productId = productId;
	this.productName = productName;
	this.validDate = validDate;
	this.expireDate = expireDate;
	this.capacity = capacity;
	this.rateId = rateId;
	this.ratePriceFee = ratePriceFee;
	this.unit = unit;
	this.productType = productType;
	this.parentNo = parentNo;
}

// 获取保证金
function getMargin(i, unit, price, type) {
	var val = 1;
	$.ajax({
		url : 'filter/offlineReserve/getPriceByUnit',
		type : 'post',
		data : {
			unit : unit,
			price : price,
			type : type
		},
		async : false,
		traditional : true,
		cache : false,
		dataType : 'json',
		success : function(data) {
			stationArr[i].oneMonthMoney = data;
			if (projectArr.length > 1) {
				// areaDiscountMark = true;
				data = data * 0.98;
			}
			if (productDiscountMark) {
				data = data * 0.98;
			}
			val = Math.floor(data);

		}
	});

	return val;
}

function getTimePoor(startTime, endTime, type) {
	var val = 1;
	$.ajax({
		url : 'filter/offlineReserve/getTimePoor',
		type : 'post',
		data : {
			startTime : startTime,
			endTime : endTime,
			type : type
		},
		async : false,
		traditional : true,
		cache : false,
		dataType : 'json',
		success : function(data) {
			val = data;
		}
	});

	return val;
}

function judgeIsCombination() {
	var mark = 0;
	for (var i = 0; i < stationArr.length; i++) {
		if (i > 0) {
			if (stationArr[0].type != stationArr[i].type)
				mark = 1;
			return mark;
		}
	}
	return mark;
}
function judegeIsSpanPointCombination() {// 判断是否是跨点加组合优惠
	var mark = 0;
	for (var i = 0; i < stationArr.length; i++) {
		for (var j = 0; j < stationArr.length; j++) {
			if (stationArr[i].projectName != stationArr[j].projectName) {
				if (stationArr[i].type != stationArr[j].type)
					mark = 2;
				return mark;
			}
		}
	}
	return mark;
}

// 获取处理日期之后的价格
function calculateDatePrice(startTime, endTime, price, unit, type) {
	var val = 0;
	$.ajax({
		url : 'filter/offlineReserve/getDatePrice',
		type : 'post',
		data : {
			startTime : startTime,
			endTime : endTime,
			unit : unit,
			type : type,
			price : price
		},
		async : false,
		traditional : true,
		cache : false,
		dataType : 'json',
		success : function(data) {
			val = data;
		}
	});
	return val;
}

// 确定选择项并添加到右侧
function sureCon(t, productId, pTitle, productName, typeTitle, existPackage) {
	var arr = [];
	var selectArr = [];
	var assetIdArr = [];
	var packageNoId = 0;
	num = 0;
	var htmls = "";
	var $as = $(t).siblings(".seat-alert").find(".b.select");
	var bNum = $(t).siblings(".seat-alert").find(".b");
	if (existPackage == "no") {
		if ($as.length > 0) {
			$as.each(function() {
				var lis = "<li assetId='" + $(this).attr('assetId') + "' >" + $(this).html() + "<span class='glyphicon glyphicon-remove'></span></li>";
				selectArr.push($(this).html());
				assetIdArr.push($(this).attr('assetId'))
				htmls += lis;
				num++;
			});
			rightAddCon(markId, productId, pTitle, htmls, productName, typeTitle, existPackage);
			$(t).addClass("btn-warning").html("已选择");
			hideAlert();
		} else {
			var kk;
			removeObjStory(productId, kk)
			calculateMethod();
			$("#" + productId).remove();
			// find('.server').hide();
			hideAlert();
		}
	}
	if (existPackage == "yes") {

		if ($as.length > 0) {
			var mark = false;
			if (stationArr.length == 0) {
				mark = true;
				$as.each(function() {
					var lis = "<li assetId='" + $(this).attr('assetId') + "' >" + $(this).html() + "<span class='iconfont glyphicon glyphicon-remove'></li>";
					selectArr.push($(this).html());
					assetIdArr.push($(this).attr('assetId'))
					htmls += lis;
					num++;
				});
			} else {
				var selectedNum = gerSelectedLength(productId);
				if (selectedNum == 0) {
					mark = true;
					$as.each(function() {
						var lis = "<li assetId='" + $(this).attr('assetId') + "' >" + $(this).html()
								+ "<span class='iconfont glyphicon glyphicon-remove'></li>";
						selectArr.push($(this).html());
						assetIdArr.push($(this).attr('assetId'))
						htmls += lis;
						num++;
					});
				} else {

					for (var x = 0; x < $as.length; x++) {
						var flag = true;
						var index = 0;
						var assetId = $as.eq(x).attr('assetId');
						for (var i = 0; i < stationArr.length && flag; i++) {
							if (productId == stationArr[i].id) {
								for (var j = 0; j < stationArr[i].seatArrId.length; j++) {
									if (assetId == stationArr[i].seatArrId[j]) {
										index++;
										flag = false;
										break;
									}
								}
							}
						}
						if (flag) {
							mark = true;
							htmls += "<li assetId='" + assetId + "' >" + $as.eq(x).html() + "<span class='iconfont glyphicon glyphicon-remove'></li>";
							selectArr.push($as.eq(x).html());
							assetIdArr.push(assetId)
						}
					}
				}
			}

			if (mark) {
				packageNoId = markId + generateMixed(6);
				rightAddCon(packageNoId, productId, pTitle, htmls, productName, typeTitle, existPackage);
			}
			$(t).addClass("btn-warning").html("已选择");
			hideAlert();
			if (!mark) {
				return null;
			}
		} else {
			hideAlert();
		}
	}
	arr.push(assetIdArr)
	arr.push(selectArr)
	arr.push(packageNoId)
	return arr;
}

// 获取已经被选中的智慧包的长度
function gerSelectedLength(productId) {
	var index = 0;
	for (var i = 0; i < stationArr.length; i++) {
		if (productId == stationArr[i].id) {
			index += stationArr[i].seatArrId.length;
		}
	}
	return index;
}

var chars = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
		'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ];

function generateMixed(n) {
	var res = "";
	for (var i = 0; i < n; i++) {
		var id = Math.ceil(Math.random() * 35);
		res += chars[id];
	}
	return res;
}

function OrderCommitParams(splitSign, projectId, productId, productType, areaDiscount, productDiscount, companyName, favourCode, favourDiscount, money,
		startTime, endTime, totalMoney, parentId, assetsIds, timeEnough, orderNo, orderTime, userId, companyId, unit, volume, margin, packageFavor, spaceType,
		offsetPrice, parentNo, isPackageUp, favorableLastMonth) {
	this.splitSign = splitSign; // 分期标志
	this.projectId = projectId; // 所属项目编号
	this.productId = productId; // 所属产品编号
	this.productType = productType; // 产品类型
	this.areaDiscount = areaDiscount; // 跨项目折扣
	this.productDiscount = productDiscount; // 跨产品折扣
	this.companyName = companyName; // 公司抬头(发票)
	this.favourCode = favourCode; // 优惠码
	this.favourDiscount = favourDiscount; // 优惠折扣
	this.money = money; // 押金
	this.startTime = startTime;
	this.endTime = endTime;
	this.totalMoney = totalMoney; // 总金额
	this.parentId = parentId; // 父产品ID
	this.assetsIds = assetsIds; //
	this.timeEnough = timeEnough; //
	this.orderNo = orderNo; // 订单编号
	this.orderTime = orderTime; // 订单创建时间
	this.userId = userId;
	this.companyId = companyId;
	this.unit = unit;// 金额单位
	this.volume = volume;// 产品容量
	this.margin = margin;// 保证金
	this.packageFavor = packageFavor;// 智慧包优惠
	this.spaceType = spaceType;// 空间类型
	this.offsetPrice = offsetPrice;//
	this.parentNo = parentNo;
	this.isPackageUp = isPackageUp;
	this.favorableLastMonth = favorableLastMonth;// 优惠最后一个月
	// this.payActionDiscount = payActionDiscount; //付款节奏折扣
}

function getOrderCommitParamsArr() {
	debugger;
	var arr = [];
	var areaDiscountMarkTemp = 1;
	var productDiscountTemp = 1;
	var splitSign = $('#selectStages option:selected').val();
	var orderNo = $('#orderPageTotal').find('p').eq(0).find('span').text();
	var orderTime = $('#orderPageTotal').find('p').eq(1).find('span').text();
	if (productDiscountMark) {
		productDiscountTemp = productDiscount;
	}
	if (areaDiscountMark) {
		areaDiscountMarkTemp = areaDiscount;
	}
	var index = 1;
	for (var i = 0; i < stationArr.length; i++) {

		var seatArrIdStr = "";
		for (var j = 0; j < stationArr[i].seatArrId.length; j++) {
			seatArrIdStr += stationArr[i].seatArrId[j];
			if (j != stationArr[i].seatArrId.length - 1) {
				seatArrIdStr += ",";
			}
		}
		// var deposit = stationArr[i].price * stationArr[i].seatArr.length *
		// stationArr[i].volume;//产品的价格
		console.log(stationArr[i].id)
		var favourPrice = getDiscountPrice(stationArr[i].price, favourCode, stationArr[i].productType, stationArr[i].id);// //
		var deposit = favourPrice * stationArr[i].seatArr.length;// 产品的价格
		var parentNo = index;
		if (stationArr[i].packageName != null) {
			arr
					.push(new OrderCommitParams(splitSign, stationArr[i].projectId, stationArr[i].id, stationArr[i].productType, areaDiscountMarkTemp,
							productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, deposit, stationArr[i].startTime, stationArr[i].endTime, 0, 0,
							seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime, allotUserArr[0], allotUserArr[1], stationArr[i].unitEnum,
							stationArr[i].volume, stationArr[i].margin, stationArr[i].packageFavor, stationArr[i].type, stationArr[i].price, index++, null,
							stationArr[i].favorableLastMonth));
			if (stationArr[i].type == 3) {// disposableProduct
				for (var j = 0; j < disposableProduct.length; j++) {
					// disposableProductObj(productId,productName,validDate,expireDate,capacity,rateId,ratePriceFee,unit,productType){
					if (disposableProduct[j].projectId == stationArr[i].projectId && disposableProduct[j].productType == 10) {
						var favourPriceFee = getDiscountPrice(disposableProduct[j].ratePriceFee, favourCode, disposableProduct[j].productType,
								disposableProduct[j].productId);
						var disposableMoney = Math.ceil(stationArr[i].productArea) * favourPriceFee * stationArr[i].seatArr.length;
						;
						arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, disposableProduct[j].productId, disposableProduct[j].productType,
								areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, disposableMoney,
								stationArr[i].startTime, stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime,
								allotUserArr[0], allotUserArr[1], disposableProduct[j].unit, disposableProduct[j].capacity, 0, 0, stationArr[i].type,
								disposableProduct[j].ratePriceFee, index++, null, stationArr[i].favorableLastMonth));
					}
				}
			}

			// 智慧包
			if (stationArr[i].upPackageObj != null) {// 升级之后的智慧包
				var favourPackagePrice = getDiscountPrice(stationArr[i].upPackageObj.packagePrice, favourCode, stationArr[i].upPackageObj.packageType,
						stationArr[i].upPackageObj.packageId)
				var procePackagePrice = favourPackagePrice * stationArr[i].volume * stationArr[i].seatArr.length;// 智慧包价格
				arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, stationArr[i].upPackageObj.packageId,
						stationArr[i].upPackageObj.packageType, areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode, rebatePercent,
						procePackagePrice, stationArr[i].startTime, stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo,
						orderTime, allotUserArr[0], allotUserArr[1], stationArr[i].upPackageObj.packageUnit, stationArr[i].volume, 0, 0,
						stationArr[i].upPackageObj.packageType, stationArr[i].upPackageObj.packagePrice, index++, null, stationArr[i].favorableLastMonth));
			} else {
				var favourPackagePrice = getDiscountPrice(stationArr[i].packagePrice, favourCode, stationArr[i].packageType, stationArr[i].packageId);
				var procePackagePrice = favourPackagePrice * stationArr[i].volume * stationArr[i].seatArr.length;// 智慧包价格
				arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, stationArr[i].packageId, stationArr[i].packageType, areaDiscountMarkTemp,
						productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, procePackagePrice, stationArr[i].startTime, stationArr[i].endTime, 0,
						parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime, allotUserArr[0], allotUserArr[1], stationArr[i].packageUnit,
						stationArr[i].volume, 0, 0, stationArr[i].packageType, stationArr[i].packagePrice, index++, null, stationArr[i].favorableLastMonth));
			}
			if (stationArr[i].discountProductType == 6) {
				var packageDiscountPrice = getDiscountPrice(stationArr[i].packageDiscountPrice, favourCode, stationArr[i].discountProductType,
						stationArr[i].discountProductId)
				var discountPrice = packageDiscountPrice * stationArr[i].volume * stationArr[i].seatArr.length;// 智慧包价格
				if (discountPrice > stationArr[i].price)
					discountPrice = stationArr[i].price;
				if (discountPrice > 0) {
					discountPrice = -discountPrice;
				}
				if (stationArr[i].upPackageDiscountObj != null) {
					var packageDiscountPrice = getDiscountPrice(stationArr[i].upPackageObj.packageDiscountPrice, favourCode,
							stationArr[i].upPackageObj.discountProductType, stationArr[i].upPackageObj.discountProductId);
					discountPrice = packageDiscountPrice * stationArr[i].volume * stationArr[i].seatArr.length;
					arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, stationArr[i].upPackageObj.discountProductId,
							stationArr[i].upPackageObj.discountProductType, areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode,
							rebatePercent, discountPrice, stationArr[i].startTime, stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough,
							orderNo, orderTime, allotUserArr[0], allotUserArr[1], stationArr[i].upPackageObj.packageUnit, stationArr[i].volume, 0, 0,
							stationArr[i].upPackageObj.packageType, stationArr[i].upPackageObj.packageDiscountPrice, index++, "no",
							stationArr[i].favorableLastMonth));
				} else {
					arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, stationArr[i].discountProductId, stationArr[i].discountProductType,
							areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, discountPrice, stationArr[i].startTime,
							stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime, allotUserArr[0], allotUserArr[1],
							stationArr[i].packageUnit, stationArr[i].volume, 0, 0, stationArr[i].packageType, stationArr[i].packageDiscountPrice, index++,
							"no", stationArr[i].favorableLastMonth));
				}
			}
			// 设置智慧包的升级产品
			if (stationArr[i].upPackageDiscountObj != null) {// 存在智慧包的升级产品
				// upPackageDiscountObj(upPackageId,upPackageName,upPackageType,upPackageDiscountPrice,upPackageUnit)
				var upPackageDiscountObj = stationArr[i].upPackageDiscountObj;
				var upPackageDiscountPrice = getDiscountPrice(upPackageDiscountObj.upPackageDiscountPrice, favourCode, upPackageDiscountObj.upPackageType,
						upPackageDiscountObj.upPackageId);
				var discountPrice = upPackageDiscountPrice * stationArr[i].volume * stationArr[i].seatArr.length;// 智慧包价格
				arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, upPackageDiscountObj.upPackageId, upPackageDiscountObj.upPackageType,
						areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, discountPrice, stationArr[i].startTime,
						stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime, allotUserArr[0], allotUserArr[1],
						upPackageDiscountObj.upPackageUnit, stationArr[i].volume, 0, 0, stationArr[i].packageType, upPackageDiscountObj.upPackageDiscountPrice,
						index++, "", stationArr[i].favorableLastMonth));
			}
			// 设置一次性电信设置费
			for (var j = 0; j < disposableProduct.length; j++) {
				// disposableProductObj(productId,productName,validDate,expireDate,capacity,rateId,ratePriceFee,unit,productType){
				if (disposableProduct[j].projectId == stationArr[i].projectId && disposableProduct[j].productType == 11) {
					var ratePriceFee = getDiscountPrice(disposableProduct[j].ratePriceFee, favourCode, disposableProduct[j].productType,
							disposableProduct[j].productId);
					var disposableMoney = disposableProduct[j].ratePriceFee * stationArr[i].volume * stationArr[i].seatArr.length;
					arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, disposableProduct[j].productId, disposableProduct[j].productType,
							areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, disposableMoney, stationArr[i].startTime,
							stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime, allotUserArr[0], allotUserArr[1],
							disposableProduct[j].unit, disposableProduct[j].capacity, 0, 0, stationArr[i].type, disposableProduct[j].ratePriceFee, index++,
							null, stationArr[i].favorableLastMonth));
				}
			}
		} else {
			arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, stationArr[i].id, stationArr[i].productType, areaDiscountMarkTemp,
					productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, deposit, stationArr[i].startTime, stationArr[i].endTime, 0, 0,
					seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime, allotUserArr[0], allotUserArr[1], stationArr[i].unitEnum, stationArr[i].volume,
					stationArr[i].margin, 0, stationArr[i].type, stationArr[i].price, index++, null, stationArr[i].favorableLastMonth));
			if (stationArr[i].type == 3) {// disposableProduct
				for (var j = 0; j < disposableProduct.length; j++) {
					// disposableProductObj(productId,productName,validDate,expireDate,capacity,rateId,ratePriceFee,unit,productType){
					if (disposableProduct[j].projectId == stationArr[i].projectId && disposableProduct[j].productType == 10) {
						var ratePriceFee = getDiscountPrice(disposableProduct[j].ratePriceFee, favourCode, disposableProduct[j].productType,
								disposableProduct[j].productId);
						var disposableMoney = Math.ceil(stationArr[i].productArea) * ratePriceFee * stationArr[i].seatArr.length;
						;
						arr.push(new OrderCommitParams(splitSign, stationArr[i].projectId, disposableProduct[j].productId, disposableProduct[j].productType,
								areaDiscountMarkTemp, productDiscountTemp, allotUserArr[3], favourCode, rebatePercent, disposableMoney,
								stationArr[i].startTime, stationArr[i].endTime, 0, parentNo, seatArrIdStr, stationArr[i].timeEnough, orderNo, orderTime,
								allotUserArr[0], allotUserArr[1], disposableProduct[j].unit, disposableProduct[j].capacity, 0, 0, stationArr[i].type,
								disposableProduct[j].ratePriceFee, index++, null, stationArr[i].favorableLastMonth));
					}
				}
			}
		}
	}

	return arr;
}

/*
 * 创建订单
 */
function createOrder(contractType) {
	var arr = getOrderCommitParamsArr();
	debugger;
	var orderTotalMany = $('#orderTotal').val();
	var flag = false;
	$.ajax({
		url : 'filter/offlineReserve/saveOrderInfo',
		type : 'post',
		data : {
			arr : JSON.stringify(arr),
			totalPoor : andPoor,
			contractType : contractType,
			orderTotalMany : orderTotalMany
		},
		async : false,
		cache : false,
		dataType : 'json',
		success : function(data) {
			flag = data.flag;
			console.log(data)
			if (flag) {
				orderId = data.ofcOrder.orderId;
				if (contractType == 1) {
					$('#contractHead').find('h1').text('租赁合同(线下)')
				} else {
					$('#contractHead').find('h1').text('租赁意向书(线下)')
				}
				contractId = data.contractId;
				$('#contractIdInp').val(contractId);
				findOrderInfoByContractId(data.contractId);
				$('#addContent').hide();
			}
		}
	});
	return flag;
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
					console.log(data);
					$('#bookTitle').text(data.contractInfo.typeName + "预览");
					$('#contractTitle').text("租赁" + data.contractInfo.typeName + "(线下)")
					$('#contractHead').find('.rent-con').eq(0).find('p').eq(0).html("<span>供应方(甲方)</span>上海办伴科技发展有限公司");
					if (data.contractInfo.companyName != null) {
						$('#contractHead').find('.rent-con').eq(0).find('p').eq(1).html("<span>承租方(乙方)</span>" + data.contractInfo.companyName);
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
						$('#contractHead').find('.rent-con').eq(0).find('p').eq(2).html("<span>合同编号</span>NO." + data.contractInfo.contractId);
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
					$('#contractHead').find('.rent-con').eq(0).find('p').eq(3).html("<span>租赁周期</span>" + data.leaseTime);
					if (data.contractInfo.finishtime != null) {
						$('#contractHead').find('.rent-con').eq(0).find('p').eq(4).html("<span>合同签订日期</span>" + data.contractInfo.finishtime);
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
					$('#contractHead').find('.rent-con').eq(0).find('p').eq(5).html("<span>付款周期</span>" + stagesStr);
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
						$('.app-con').text(data.contractInfo.supplement)
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
							if (data.loginUser.adminLname != null) {
								$('#contractHead').find('.rent-con').eq(1).find('p').eq(0).html(
										"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>联系人</span>"
												+ data.loginUser.adminRname);
								$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(0).html(
										"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Contact Name</span>"
												+ data.loginUser.adminRname);
							}
							if (data.loginUser.adminPhone != null) {
								$('#contractHead').find('.rent-con').eq(1).find('p').eq(1)
										.html(
												"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>电话</span>"
														+ data.loginUser.adminPhone);
								$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(1).html(
										"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Tel</span>"
												+ data.loginUser.adminPhone);
							}
							$('#contractHead').find('.rent-con').eq(1).find('p').eq(2).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>职位</span>" + "销售");
							$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(2).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Position</span>"
											+ "Salesman");
							if (data.loginUser.adminEmail != null) {
								$('#contractHead').find('.rent-con').eq(1).find('p').eq(3)
										.html(
												"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>邮箱</span>"
														+ data.loginUser.adminEmail);
								$('.rent-contract').eq(1).find('div').eq(1).find('p').eq(3).html(
										"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>E-mail</span>"
												+ data.loginUser.adminEmail);
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
						$('.rent-contract').eq(1).find('div').eq(2).find('p').eq(2).html(
								"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>Position</span>"
										+ "Salesman");
						if (data.contractInfo.userMail != null) {
							$('#contractHead').find('.rent-con').eq(2).find('p').eq(3).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>邮箱</span>" + data.contractInfo.userMail);
							$('.rent-contract').eq(1).find('div').eq(2).find('p').eq(3).html(
									"<span style='box-sizing: border-box;width:110px;letter-spacing:0;;font-weight: bold;font-size: 15px;margin-right: 10px;'>E-mail</span>"
											+ data.contractInfo.userMail);
						}
						if (data.contractInfo.companyAddress != null) {
							$('#contractHead').find('.rent-con').eq(2).find('p').eq(4).html(
									"<span style='width: 60px;font-weight: bold;font-size: 15px;margin-right: 10px;'>账单地址</span>"
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
								rent = list[i][j].nomalFee;
								/*
								 * price =
								 * list[i][j].ensureFee/list[i][j].amount; rent =
								 * list[i][j].ensureFee * list[i][j].capacity;
								 */
								// price = list[i][j].splitList[0].priceFee;
								rent = rent * list[i][j].amount;
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
								// firstMoney +=
								// splitList[0].priceFee-list[i][j].ensureFee;
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
								// packageMoney += list[i][j].zhihuibaoMoney;
							}
							if (list[i][j].productType == 6 || list[i][j].productType == 7) {
								/*
								 * var cut = list[i][j].zhihuibaoMoney; jianmian +=
								 * Math.ceil(cut);
								 */
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
					/*
					 * if(list[0][0].crossProjectDiscount!=1&&list[0][0].crossProjectDiscount!=null){//跨点组合优惠
					 * if(indexMark==0){ indexMark++; htm+="<tr><td rowspan='3' valign='top' style='line-height: 30px;vertical-align: middle;'>"; }
					 * htm+="</td><td style='line-height: 30px;vertical-align: middle;'>跨点折扣</td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'>"+list[0][0].crossProjectDiscount+"%
					 * off</td></tr>" }
					 * if(list[0][0].crossProductDiscount!=1&&list[0][0].crossProductDiscount!=null){//跨产品组合优惠
					 * if(indexMark==0){ indexMark++; htm+="<tr><td rowspan='3' valign='top' style='line-height: 30px;vertical-align: middle;'>"; }
					 * htm+="</td><td style='line-height: 30px;vertical-align: middle;'>跨产品折扣</td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'></td><td style='line-height: 30px;vertical-align: middle;'>"+list[0][0].crossProductDiscount+"%
					 * off</td></tr>"; }
					 */
					if (list[0][0].payActionDiscount != 1 && list[0][0].payActionDiscount != null) {// 跨产品组合优惠
						if (indexMark == 0) {
							indexMark++;
							htm += "<tr><td rowspan='3' valign='top' style='line-height: 30px;vertical-align: middle;'>";
						}
						console.log(list[0][0].payActionDiscount)
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
					// createPDFSendMail=firstMoney+","+packageMoney+","+disposable+","+margin+","+jianmian+","+firstMoneyTotal;
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

// 右侧添加内容
function rightAddCon(rid, productId, pTitle, htmls, productName, typeTitle, existPackage) {
	if ($("#" + rid).html() == undefined) {

		var $rightSeat = $("#right-seat").clone();
		$rightSeat.removeClass().addClass("right-seat");
		$rightSeat.addClass("rightDivClass");
		$rightSeat.attr("id", productId);
		if (existPackage == "yes") {
			$rightSeat.attr("packageNoId", rid);
		}
		addSeat($rightSeat, htmls);
		$rightSeat.find(".title").text(pTitle);
		$rightSeat.find(".pp").text(productName + "(" + typeTitle + ")");
		$(".con-right-first").append($rightSeat);
	} else {
		addSeat($("#" + rid), htmls);
	}
}
// 添加选择座位
function addSeat($ele, htmls) {
	$ele.find(".item-list li").remove();
	$ele.find(".item-list").append(htmls);
	$ele.find(".item-list").find("span").unbind("click");
	$ele.find(".item-list").find("span").click(function() {
		var parent = $(this).parent().parent().parent();
		var id = parent.attr('id');
		var packageNoId = parent.attr('packageNoId');

		var str = $(this).parent().text();
		var assetId = $(this).parent().attr('assetId');
		var substr = str.substr(0, str.length - 1);
		deleteSpanInfo(id, assetId);
		calculateMethod();// 删除标签之后重新计算价格
		console.log(stationArr)
		$(this).parent().remove();
		var spanLength = $ele.find(".item-list").find("span").length;
		deleteSpanInfoSelected(id, str, spanLength, packageNoId);
		if (spanLength == 0) {
			// removePackageInfo(id);
			removeObjStory(id, packageNoId);
			parent.find('.server').hide();
			parent.remove()
		}
		calculateMethod();// 计算价格
	});
	//
}

function deleteSpanInfoSelected(id, str, spanLength, packageNoId) {

	var tr = $('#productInfoBody').find('tr');
	for (var i = 0; i < tr.length; i++) {
		if (tr.eq(i).attr('projectid') == id) {
			var spans = tr.eq(i).find('.spana');
			if (spanLength == 0) {
				if (typeof packageNoId == 'undefined') {
					tr.eq(i).find('.seat-positive').find('div').eq(0).removeClass("btn-warning").html("选择座位");
				} else {
					var selectedNum = gerSelectedLength(id);
					if (selectedNum == 0) {
						tr.eq(i).find('.seat-positive').find('div').eq(0).removeClass("btn-warning").html("选择座位");
					}
				}
			}

			for (var j = 0; j < spans.length; j++) {
				if (spans.eq(j).html().trim() == str) {
					spans.eq(j).removeClass('select');
				}
			}
			// 重新计算剩余数量
			var dataCount = tr.eq(i).find('td').eq(5).attr('dataCount')
			var selectNum = tr.eq(i).find('.select').length;
			tr.eq(i).find('td').eq(5).text(dataCount - selectNum);
		}
	}
}

// 删除标签时更新选中的座位的信息
function deleteSpanInfo(id, assetId) {
	for (var i = 0; i < stationArr.length; i++) {
		if (stationArr[i].existPackage == "no") {
			if (stationArr[i].id == id) {
				var tempArr = [];
				var tempArrId = [];
				for (var j = 0; j < stationArr[i].seatArrId.length; j++) {
					if (stationArr[i].seatArrId[j] != assetId) {
						// seatArrId
						tempArr.push(stationArr[i].seatArr[j])
						tempArrId.push(stationArr[i].seatArrId[j])
					}
				}
				stationArr[i].seatArr = tempArr;
				stationArr[i].seatArrId = tempArrId;
				break;
			}
		} else {
			if (stationArr[i].id == id) {
				var tempArr = [];
				var tempArrId = [];
				var flag = false;
				for (var j = 0; j < stationArr[i].seatArrId.length; j++) {
					if (stationArr[i].seatArrId[j] != assetId) {
						tempArr.push(stationArr[i].seatArr[j])
						tempArrId.push(stationArr[i].seatArrId[j])
					}
				}
				stationArr[i].seatArr = tempArr;
				stationArr[i].seatArrId = tempArrId;
				console.log(stationArr)
			}
		}

	}
}

function pushStationArrData(obj) {
	if (stationArr.length == 0) {
		stationArr.push(obj);
	} else {
		if (obj.existPackage == "yes") {
			stationArr.push(obj);
		} else {
			for (var i = 0; i < stationArr.length; i++) {
				if (stationArr[i].id == obj.id && stationArr[i].type == obj.type && stationArr[i].startTime == obj.startTime
						&& stationArr[i].endTime == obj.endTime) {
					stationArr[i].seatArr = obj.seatArr;
					stationArr[i].seatArrId = obj.seatArrId;
					break;
				}
				if (stationArr[i].id == obj.id && stationArr[i].type != obj.type && stationArr[i].startTime == obj.startTime
						&& stationArr[i].endTime == obj.endTime) {
					stationArr.push(obj);
					break;
				}
				if (i == stationArr.length - 1) {
					stationArr.push(obj);
					break;
				}
			}
		}
	}

}

function pushProjectArrData(projectName) {
	if (projectArr.length == 0) {
		projectArr.push(projectName)
	} else {
		for (var i = 0; i < projectArr.length; i++) {
			if (projectArr[i] == projectName) {
				break;
			}
			if (i == projectArr.length - 1) {
				projectArr.push(projectName);
				break;
			}
		}
	}
}
// 调到下一步
function skipStep(t, index) {
	if (index == 1) {
		favourCode = "00";
		$("#inputDiscountNumber").attr("value", '');// 清空内容
		calculateMethod();
		padding2PageData();
	}
	if (index == 2) {// 判断是否拥有能够升级的智慧包

		if (!($(t).hasClass('previousStep'))) {
			var packageIsUpArr = judgePackageIsUp();
			// 创建智慧包升级页面展示的html
			createPackageUpInfo(packageIsUpArr);
		}
	}
	if (index == 3) {
		orderNoAndTime();
		getByStagesData(1);
		createOrderPage();
	}
	if (index == 4) {
		var flag = createOrder(2);// 生成意向书
		if (!flag) {
			$('.promptBox').find('p').text("订单创建失败，请提交相关信息给后台管理人员！")
			$('.promptBox').show();
			$(".b-wrap").removeClass("hidden");
			return;
		}
	}
	if (index == 5) {
		if ($('#bookTitle').text() == "合同预览") {
			return;
		}
		// createOrder(1);//生成合同
	}

	if (index == 6 || index == 7) {

	}
	$(".pay-con").eq(index).removeClass("hidden").siblings(".pay-con").addClass('hidden');
	$(".mod").eq(index).addClass('current-step').siblings(".mod").removeClass("current-step");
	$(".b-wrap").addClass("hidden");
}

function packageUpInfoTest() {
	var packageUp = [];
	packageUp.push(new ObjPackageUp(1, "康定路项目", 166, "开放式工位", 2, '智慧包'));
	var input = $('#productId' + packageUp[0].productId).find('input');
	getUpPackageInfo()
	return;
	$.ajax({
		url : 'filter/offlineReserve/getUpPackageInfo',
		type : 'post',
		data : {
			'projectId' : 1
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			var htm = "";
			htm += "<div class='server grey-server upPackage' id='upPackage" + packageUp[0].productId + "' currentProductId='" + packageUp[0].productId + "' >"
					+ packageUp[0].projectName + "--" + packageUp[0].productName
					+ "智慧包升级<select class='form-control input-md' onchange='clickPackageUpOption(this)'>";
			for (var x = 0; x < data.length; x++) {
				htm += "<option productId='" + data[x].productId + "' productType='" + data[x].productType + "' money='" + data[x].money + "' unitEnum='"
						+ data[x].unitEnum + "'>" + data[x].productName + "</option>";
			}
			htm += "</select></div>";
			$('.content-padding').find('div').remove();
			$('.content-padding').append(htm);
		}
	});
}

function getUpPackageInfo(projectId) {
	var dataVar = [];
	// debugger;
	$.ajax({
		url : 'filter/offlineReserve/getUpPackageInfo',
		type : 'post',
		data : {
			projectId : projectId
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			dataVar = data;
		}
	});

	return dataVar;
}

function clickPackageUpOption(currentThis) {
	debugger;
	var obj = $(currentThis).find("option:selected");
	var favorableMark = obj.attr('favorableMark');
	var objStoryIndex = obj.attr('objStoryIndex');
	if (favorableMark == "true") {
		// 选择了减免最后一个月房租
		// favorableLastMonth
		for (var i = 0; i < stationArr.length; i++) {
			if (stationArr[i].index == objStoryIndex) {
				stationArr[i].upPackageObj = null;
				stationArr[i].upPackageDiscountObj = null;
				stationArr[i].favorableLastMonth = true;
			}
		}
		calculateMethod();
		return;
	}

	var packageName = obj.text();
	var packageType = 5;
	var packageId = obj.attr("packageProductId");
	var packagePrice = obj.attr("ratePriceFee");
	var packageUnit = obj.attr("unit");
	var packageDiscountPrice = obj.attr("discountPrice");
	var discountProductType = obj.attr("discountProductType");
	var discountProductId = obj.attr("discountProductId");
	var defaultVar = obj.attr("default");
	if (defaultVar == "true") {
		for (var i = 0; i < stationArr.length; i++) {
			if (stationArr[i].index == objStoryIndex) {
				stationArr[i].upPackageObj = null;
				stationArr[i].upPackageDiscountObj = null;
				stationArr[i].favorableLastMonth = false;
			}
		}
		calculateMethod();
		return;
	}
	var defaultPackagePrice = $(currentThis).find("option").eq(0).attr('ratePriceFee');
	var subPrice = defaultPackagePrice - packagePrice;
	var $upPackageObj = new upPackageObj(packageId, packageName, packageType, packagePrice, packageUnit, discountProductId, packageDiscountPrice,
			discountProductType);
	console.log(obj.attr('projectId'))
	var data = getUpPackageInfo(obj.attr('projectId'));
	// var data2 = getUpPackageInfoTest(obj.attr('productId'),packageId);
	var $newObj;
	if (packageDiscountPrice == -100 && data.length > 0) {
		$newObj = new upPackageDiscountObj(data[0].productId, data[0].productName, data[0].productType, subPrice, data[0].unit);
	} else {
		$newObj = new upPackageDiscountObj(data[1].productId, data[1].productName, data[1].productType, subPrice, data[1].unit);
	}
	console.log(data)
	// var currentProductId = obj.parent().parent().attr('currentProductId');
	// new
	// upPackageDiscountObj(upPackageId,upPackageName,upPackageType,upPackageDiscountPrice,upPackageUnit)
	console.log($upPackageObj)
	/*
	 * if(data.length>0) var $newObj = new
	 * upPackageDiscountObj(data[0].productId,data[0].productName,data[0].productType,data[0].money,data[0].unit);
	 */
	for (var i = 0; i < stationArr.length; i++) {
		if (stationArr[i].index == objStoryIndex) {
			stationArr[i].favorableLastMonth = false;
			stationArr[i].upPackageObj = $upPackageObj;
			if (data.length > 0)
				stationArr[i].upPackageDiscountObj = $newObj;
		}
	}
	console.log(stationArr)
	calculateMethod();// 智慧包升级之后重新计算价格
	console.log(stationArr)
	console.log($newObj)
}

function getUpPackageInfoTest(productId, packageProductId) {
	var dataVar = [];
	// debugger;
	$.ajax({
		url : 'filter/offlineReserve/getUpPackageInfoTest',
		type : 'post',
		data : {
			productId : productId,
			packageId : packageProductId
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			dataVar = data;
		}
	});

	return dataVar;
}

function createPackageUpInfo(packageIsUpArr) {
	var htm = "";
	debugger;
	var incrementLevel;
	var findUpPackage = $('.content-padding').find('.upPackage');
	for (var j = 0; j < findUpPackage.length; j++) {
		var index = findUpPackage.eq(j).attr('objStoryIndex');
		// 当之前选中的产品取消选择之后，若生成了升级智慧包，则需删除生成的节点
		for (var z = 0; z < stationArr.length; z++) {
			if (stationArr[z].index == index) {
				break;
			}
			if (z == stationArr.length - 1) {
				findUpPackage.eq(j).remove();
				findUpPackage = $('.content-padding').find('.upPackage');
			}
		}
	}
	for (var i = 0; i < packageIsUpArr.length; i++) {
		var mark = true;
		for (var j = 0; j < findUpPackage.length; j++) {
			var index = findUpPackage.eq(j).attr('objStoryIndex');
			if (packageIsUpArr[i].index == index) {
				mark = false;
				break;
			}
		}
		if (mark) {
			var productId = packageIsUpArr[i].productId;
			var IncrementArr = findIncrementProduct(productId);
			for (var n = 0; n < IncrementArr.length; n++) {
				if (IncrementArr[n].incrementLevel == "A" || IncrementArr[n].incrementLevel == "A-")
					IncrementArr[n].incrementLevel = 1;
				if (IncrementArr[n].incrementLevel == "B" || IncrementArr[n].incrementLevel == "B-")
					IncrementArr[n].incrementLevel = 2;
				if (IncrementArr[n].incrementLevel == "C" || IncrementArr[n].incrementLevel == "C-")
					IncrementArr[n].incrementLevel = 3;
				if (IncrementArr[n].incrementLevel == "D" || IncrementArr[n].incrementLevel == "D-")
					IncrementArr[n].incrementLevel = 4;
			}

			var flag = true;
			for (var j = 0; j < IncrementArr.length; j++) {
				if (IncrementArr[j].productId == packageIsUpArr[i].packageId) {
					incrementLevel = IncrementArr[j].incrementLevel;
				}
			}
			if (flag) {
				htm += "<div class='server grey-server upPackage' objStoryIndex='" + packageIsUpArr[i].index + "' incrementLevel='" + incrementLevel
						+ "' packageId='" + packageIsUpArr[i].packageId + "' currentProductId='" + packageIsUpArr[i].productId + "' >"
						+ packageIsUpArr[i].projectName + "  " + packageIsUpArr[i].productName + "  " + packageIsUpArr[i].packageName
						+ "<select class='form-control input-md' onchange='clickPackageUpOption(this)' >";
				for (var j = 0; j < IncrementArr.length; j++) {
					if (IncrementArr[j].incrementLevel == incrementLevel) {
						htm += "<option favorableMark='false' default='true' objStoryIndex='" + packageIsUpArr[i].index + "' incrementLevel='" + incrementLevel
								+ "' projectId='" + packageIsUpArr[i].projectId + "' productId='" + productId + "' packageProductId='"
								+ IncrementArr[j].productId + "' ratePriceFee='" + IncrementArr[j].ratePriceFee + "' unit='" + IncrementArr[j].unit
								+ "' discountPrice='" + IncrementArr[j].discountPrice + "' discountProductType='" + IncrementArr[j].discountProductType
								+ "' discountProductId='" + IncrementArr[j].discountProductId + "'  >保持产品及价格不变</option>";
					}
				}
				if (IncrementArr.length == 0) {
					htm += "<option favorableMark='false' default='true' objStoryIndex='"
							+ packageIsUpArr[i].index
							+ "' incrementLevel='"
							+ incrementLevel
							+ "' projectId='"
							+ packageIsUpArr[i].projectId
							+ "' productId='"
							+ productId
							+ "' packageProductId='null' ratePriceFee='null' unit='null' discountPrice='null' discountProductType='null' discountProductId='null'  >保持产品及价格不变</option>";
				}
				if (judgeIsLastDay(packageIsUpArr[i].endTime)) {
					htm += "<option value='' favorableMark='true' objStoryIndex='" + packageIsUpArr[i].index + "' >减免最后一个月房租</option>";
				}
				htm += "</select></div>";
			}
		}
	}
	$('.content-padding').append(htm);
}

/*
 * function createPackageUpInfo(packageIsUpArr){ var htm = ""; debugger; var
 * incrementLevel; var findUpPackage=$('.content-padding').find('.upPackage');
 * //findUpPackage.remove(); for(var i=0;i<packageIsUpArr.length;i++){ var mark =
 * true; var tag = true; for(var j=0;j<findUpPackage.length&&tag;j++){ var
 * index = findUpPackage.eq(j).attr('objStoryIndex');
 * //当之前选中的产品取消选择之后，若生成了升级智慧包，则需删除生成的节点 for(var z=0;z<stationArr.length;z++){
 * if(stationArr[z].index==index){ break; } if(z==stationArr.length-1){
 * findUpPackage.eq(j).remove(); } } if(index == packageIsUpArr[i].index){
 * for(var x=0;x<stationArr.length;x++){ if(stationArr[x].index==index){ var il =
 * findUpPackage.eq(j).attr('incrementlevel');
 * if(stationArr[x].packageIncrementLevel==il){ //没有重新选择智慧包 mark = false; tag =
 * false; break; }else{ findUpPackage.eq(j).remove(); tag = false;
 * if(stationArr[i].upPackageObj!=null){ stationArr[x].upPackageObj == null;
 * stationArr[x].upPackageDiscountObj = null; } break; } }
 *  }
 *  } } if(mark){ var productId = packageIsUpArr[i].productId; var IncrementArr =
 * findIncrementProduct(productId); console.log(IncrementArr) for(var n=0;n<IncrementArr.length;n++){
 * if(IncrementArr[n].incrementLevel=="A"||IncrementArr[n].incrementLevel=="A-")IncrementArr[n].incrementLevel=1;
 * if(IncrementArr[n].incrementLevel=="B"||IncrementArr[n].incrementLevel=="B-")IncrementArr[n].incrementLevel=2;
 * if(IncrementArr[n].incrementLevel=="C"||IncrementArr[n].incrementLevel=="C-")IncrementArr[n].incrementLevel=3;
 * if(IncrementArr[n].incrementLevel=="D"||IncrementArr[n].incrementLevel=="D-")IncrementArr[n].incrementLevel=4; }
 * 
 * var flag = false; for(var j=0;j<IncrementArr.length;j++){
 * if(IncrementArr[j].productId==packageIsUpArr[i].packageId){ incrementLevel =
 * IncrementArr[j].incrementLevel; if(IncrementArr[j].incrementLevel<3){ flag=
 * true; }else if(IncrementArr[j].incrementLevel==3){ for(var x=0;x<stationArr.length;x++){
 * if(stationArr[x].index==packageIsUpArr[i].index){
 * stationArr[x].favorableLastMonth = true; } } } } } if(flag){ htm+="<div
 * class='server grey-server upPackage'
 * objStoryIndex='"+packageIsUpArr[i].index+"'
 * incrementLevel='"+incrementLevel+"'
 * packageId='"+packageIsUpArr[i].packageId+"'
 * currentProductId='"+packageIsUpArr[i].productId+"'
 * >"+packageIsUpArr[i].projectName+" "+packageIsUpArr[i].productName+"
 * "+packageIsUpArr[i].packageName+"<select class='form-control input-md'
 * onchange='clickPackageUpOption(this)' >"; //htm += "<option value=''
 * favorableMark='true' objStoryIndex='"+packageIsUpArr[i].index+"' >减免最后一个月房租</option>";
 * for(var j=0;j<IncrementArr.length;j++){
 * console.log("incrementLevel"+IncrementArr[j].incrementLevel)
 * console.log(parseInt(incrementLevel)+2) //htm+="<input type='hidden'
 * class='inputVal' incrementLevel
 * productId='"+data[i].incrementProductOutsList[j].productId+"'
 * ratePriceFee='"+data[i].incrementProductOutsList[j].ratePriceFee+"'
 * unit='"+data[i].incrementProductOutsList[j].unit+"'
 * discountPrice='"+data[i].incrementProductOutsList[j].discountPrice+"'
 * discountProductType='"+data[i].incrementProductOutsList[j].discountProductType+"'
 * discountProductId='"+data[i].incrementProductOutsList[j].discountProductId+"'
 * incrementProductName='"+data[i].incrementProductOutsList[j].incrementProductName+"' >"
 * if(IncrementArr[j].incrementLevel>=incrementLevel&&IncrementArr[j].incrementLevel<(parseInt(incrementLevel)+2)){
 * if(IncrementArr[j].incrementLevel==incrementLevel){ htm += "<option
 * favorableMark='false' default='true'
 * objStoryIndex='"+packageIsUpArr[i].index+"'
 * incrementLevel='"+incrementLevel+"'
 * projectId='"+packageIsUpArr[i].projectId+"' productId='"+productId+"'
 * packageProductId='"+IncrementArr[j].productId+"'
 * ratePriceFee='"+IncrementArr[j].ratePriceFee+"'
 * unit='"+IncrementArr[j].unit+"'
 * discountPrice='"+IncrementArr[j].discountPrice+"'
 * discountProductType='"+IncrementArr[j].discountProductType+"'
 * discountProductId='"+IncrementArr[j].discountProductId+"' >保持产品及价格不变</option>";
 * }else{ //htm += "<option favorableMark='false default='false'
 * objStoryIndex='"+packageIsUpArr[i].index+"'
 * incrementLevel='"+incrementLevel+"'
 * projectId='"+packageIsUpArr[i].projectId+"' productId='"+productId+"'
 * packageProductId='"+IncrementArr[j].productId+"'
 * ratePriceFee='"+IncrementArr[j].ratePriceFee+"'
 * unit='"+IncrementArr[j].unit+"'
 * discountPrice='"+IncrementArr[j].discountPrice+"'
 * discountProductType='"+IncrementArr[j].discountProductType+"'
 * discountProductId='"+IncrementArr[j].discountProductId+"'
 * >"+IncrementArr[j].incrementProductName+"</option>"; htm += "<option
 * favorableMark='false default='false'
 * objStoryIndex='"+packageIsUpArr[i].index+"'
 * incrementLevel='"+incrementLevel+"'
 * projectId='"+packageIsUpArr[i].projectId+"' productId='"+productId+"'
 * packageProductId='"+IncrementArr[j].productId+"'
 * ratePriceFee='"+IncrementArr[j].ratePriceFee+"'
 * unit='"+IncrementArr[j].unit+"'
 * discountPrice='"+IncrementArr[j].discountPrice+"'
 * discountProductType='"+IncrementArr[j].discountProductType+"'
 * discountProductId='"+IncrementArr[j].discountProductId+"' >免费升级IT智慧包</option>"; } } }
 * if(judgeIsLastDay(packageIsUpArr[i].endTime)){ htm += "<option value=''
 * favorableMark='true' objStoryIndex='"+packageIsUpArr[i].index+"' >减免最后一个月房租</option>"; }
 * htm += "</select></div>";
 *  } } } $('.content-padding').append(htm); }
 */

function findIncrementProduct(proid) {
	var arr = [];
	$.ajax({
		url : 'filter/offlineReserve/findIncrementProduct',
		type : 'POST',
		data : {
			proid : proid
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			console.log(data.message);
			if (data.message == 'have') {
				arr = data.rows;
			}
		},
		error : function(data) {
		}
	});

	return arr;
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
	$('.promptBox').find('p').text("定金交付成功!")
	$('.promptBox').show();
	$(".b-wrap").removeClass("hidden");
	return;
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

function createOrderPage() {
	debugger;
	var selectedVal = $('#selectStages option:selected').val();
	if (selectedVal != 5) {
		selectStages();
	}// 返回上页继续选定资产后自动如果已经进行分期操作，将会对其进行分期

	var htm = ""
	var spaceSelectedOption = $('#spaceSelected').find('option');
	var spaceType = "";
	$('#orderBodyId').find('tr').remove();
	for (var i = 0; i < stationArr.length; i++) {
		var mark = true;
		for (var j = 0; j < $('.orderDetail').length; j++) {
			if ($('.orderDetail').eq(j).attr('productId') == stationArr[i].id) {
				mark = false;
			}
		}
		// debugger;
		if (mark && stationArr[i].seatArr.length > 0) {
			for (var j = 0; j < spaceSelectedOption.length; j++) {
				if (stationArr[i].type == spaceSelectedOption.eq(j).val()) {
					spaceType = spaceSelectedOption.eq(j).text().trim();
				}
			}
			var seatArrStr = "";
			for (var k = 0; k < stationArr[i].seatArr.length; k++) {
				if (k != stationArr[i].seatArr.length - 1) {
					if ((k + 1) % 4 == 0) {
						seatArrStr += stationArr[i].seatArr[k];
					} else {
						seatArrStr += stationArr[i].seatArr[k] + ",";
					}
				} else {
					seatArrStr += stationArr[i].seatArr[k];
				}
				if ((k + 1) % 4 == 0)
					seatArrStr += "</br>"
			}
			var calculateResult = stationArr[i].calculateResult;
			var calculateResultStr = "";
			if (stationArr[i].productType == 2)
				calculateResultStr = (Math.floor(calculateResult)) + "个会议室券";
			if (stationArr[i].productType == 4)
				calculateResultStr = (Math.floor(calculateResult)) + "张弹性工位劵";
			if (stationArr[i].productType == 1 || stationArr[i].productType == 3)
				calculateResultStr = "￥" + (Math.floor(calculateResult));
			var favourPrice = getDiscountPrice(stationArr[i].price, favourCode, stationArr[i].productType, stationArr[i].id);
			// htm += "<tr class='orderDetail'
			// productId='"+stationArr[i].id+"'><td>"+stationArr[i].projectName+"</td><td>"+stationArr[i].productName+"</td><td>"+spaceType+"</td><td>"+stationArr[i].seatArr+"</td><td>￥"+stationArr[i].price+"/"+stationArr[i].unit+"</td><td>"+stationArr[i].startTime+"到"+stationArr[i].endTime+"</td><td>"+calculateResultStr+"</td></tr>";
			htm += "<tr class='orderDetail' productId='" + stationArr[i].id + "'><td>" + stationArr[i].projectName + "</td><td>" + stationArr[i].productName
					+ "</td><td>" + spaceType + "</td><td>" + seatArrStr + "</td><td>￥" + favourPrice + "/" + stationArr[i].unit + "</td><td>"
					+ stationArr[i].startTime + "到" + stationArr[i].endTime + "</td><td>" + calculateResultStr + "</td></tr>";
			if (stationArr[i].packageName != null) {
				if (stationArr[i].upPackageObj != null) {
					var favourPackagePrice = getDiscountPrice(stationArr[i].upPackageObj.packagePrice, favourCode, stationArr[i].upPackageObj.packageType,
							stationArr[i].upPackageObj.packageId);
					htm += "<tr class='z-tr'><td colspan='6'><div class='z-tr-d'><div class='z-round'></div><div class='z-line'></div>"
							+ "<p class='z-tr-p'><span>--" + stationArr[i].upPackageObj.packageName + "</span><span>" + favourPackagePrice + "/"
							+ stationArr[i].unit + "</span><span>服务费：￥" + Math.floor(stationArr[i].calculatePackageResult) + "</span>"
				} else {
					var favourPackagePrice = getDiscountPrice(stationArr[i].packagePrice, favourCode, stationArr[i].packageType, stationArr[i].packageId);
					htm += "<tr class='z-tr'><td colspan='6'><div class='z-tr-d'><div class='z-round'></div><div class='z-line'></div>"
							+ "<p class='z-tr-p'><span>--" + stationArr[i].packageName + "</span><span>" + favourPackagePrice + "/" + stationArr[i].unit + "/人"
							+ "</span><span>服务费：￥" + Math.floor(stationArr[i].calculatePackageResult) + "</span>"
				}

				if (stationArr[i].packageFavor != 0) {
					var packageFavor = stationArr[i].packageFavor;
					if (packageFavor > 0) {
						packageFavor = Math.floor(packageFavor);// 智慧包的优惠价格
					} else {
						packageFavor = Math.ceil(packageFavor);
					}
					htm += "<span class='yhfw'>减免房租￥" + packageFavor + "</span>"
					if (stationArr[i].telecomSetCost != 0) {
						htm += "<span class='yhfw'>电信设置费￥" + stationArr[i].telecomSetCost + "</span>"
					}
				}

				htm += "</p></div></td></tr>";
			}
			if (stationArr[i].margin != 0 || stationArr[i].disposableCost != 0) {
				htm += "<tr class='z-tr'><td colspan='6'><div class='z-tr-d'><div class='z-round'></div><div class='z-line'></div>"
						+ "<p class='z-tr-p'><span>--保证金</span><span>￥<input type='text' class='marginInput' onMouseOut='modifyMargin()' value="
						+ (stationArr[i].margin) + " ></span>"
				htm += "</p></div></td></tr>";
				if (stationArr[i].disposableCost != 0) {
					htm += "<tr class='z-tr'><td colspan='6'><div class='z-tr-d'><div class='z-round'></div><div class='z-line'></div>";
					htm += "<p class='z-tr-p'><span>--一次性费用</span><span>" + stationArr[i].disposableCostPrice + "/" + stationArr[i].unit + "/m²</span><span>￥"
							+ stationArr[i].disposableCost + "</span>";
					htm += "</p>";
					htm += "</div></td></tr>";
				}
				if (stationArr[i].favorableLastMonth) {
					htm += "<tr class='z-tr'><td colspan='6'><div class='z-tr-d'><div class='z-round'></div><div class='z-line'></div>";
					htm += "<p class='z-tr-p'><span>--减免最后一个月房租</span><span>￥" + stationArr[i].oneMonthMoney + "</span></p>";
					htm += "</div></td></tr>";
				}
			}
		}
	}

	$('#orderBodyId').append(htm);
}

function modifyMargin() {
	var marginTemp = 0
	for (var i = 0; i < $('.marginInput').length; i++) {
		var str = $('.marginInput').eq(i).val();
		var regu = /^[0-9]*$/;
		var re = new RegExp(regu);
		if (!re.test(str)) {
			$('.promptBox').find('p').text("请输入数字！")
			$('.promptBox').show();
			return;
		}
		if (str.indexOf('.') != -1) {
			$('.promptBox').find('p').text("保证金必须为整数！")
			$('.promptBox').show();
			return;
		}
		/*
		 * if(Number($('.marginInput').eq(i).val())<=0){
		 * $('.promptBox').find('p').text("保证金必须>0") $('.promptBox').show();
		 * return; }
		 */
		stationArr[i].margin = Number($('.marginInput').eq(i).val());
		marginTemp += Number(stationArr[i].margin);
	}
	$('.marginP').html("保证金：￥" + Math.floor(marginTemp));

	var selectStagesVal = $('#selectStages option:selected').val();
	if (selectStagesVal != 5) {
		getByStagesData(2);
	} else {
		getByStagesData(1);
	}
}

// 判断是否拥有可升级的智慧包
function judgePackageIsUp() {
	var packageUp = [];
	for (var i = 0; i < stationArr.length; i++) {
		/*
		 * 这是存在智慧包的情况下的判断条件
		 * if(stationArr[i].timeEnough=="yes"&&stationArr[i].existPackage=="yes"&&stationArr[i].volume*stationArr[i].seatArr.length>=1){
		 * packageUp.push(new
		 * ObjPackageUp(stationArr[i].index,stationArr[i].projectId,stationArr[i].projectName,stationArr[i].id,stationArr[i].productName,stationArr[i].packageId,stationArr[i].packageName,stationArr[i].endTime)) }
		 */

		/*
		 * 更改为没有智慧包条件下的判断 判断是否可升级的条件为：订单时间需满足三个月，入住人员为一人次以上（包含一人）
		 */
		if (stationArr[i].timeEnough == "yes" && stationArr[i].volume * stationArr[i].seatArr.length >= 1) {
			packageUp.push(new ObjPackageUp(stationArr[i].index, stationArr[i].projectId, stationArr[i].projectName, stationArr[i].id,
					stationArr[i].productName, stationArr[i].packageId, stationArr[i].packageName, stationArr[i].endTime))
		}

	}
	// 选择一人次条件
	return packageUp;
	if (stationArr.length == 1) {
		if (stationArr[0].timeEnough == "yes" && stationArr[0].existPackage == "yes" && stationArr[0].volume * stationArr[0].seatArr.length >= 1) {
			packageUp.push(new ObjPackageUp(stationArr[0].index, stationArr[0].projectId, stationArr[0].projectName, stationArr[0].id,
					stationArr[0].productName, stationArr[0].packageId, stationArr[0].packageName, stationArr[0].endTime))
		}
		return packageUp;
	}

	for (var i = 0; i < stationArr.length; i++) {
		if (stationArr[i].timeEnough == "yes" && stationArr[i].existPackage == "yes") {
			var num = 0;
			for (var j = 0; j < stationArr.length; j++) {
				var mark = true;
				if (j != i && stationArr[j].timeEnough == "yes" && stationArr[j].existPackage == "yes" && stationArr[i].startTime == stationArr[j].startTime
						&& stationArr[i].endTime == stationArr[j].endTime) {
					if (mark) {
						num += stationArr[i].seatArr.length * stationArr[i].volume;
						mark = false;
					}
					num += stationArr[j].seatArr.length * stationArr[j].volume;
				}
			}
			for (var j = 0; j < stationArr.length; j++) {
				if (j != i && stationArr[j].timeEnough == "yes" && stationArr[j].existPackage == "yes" && stationArr[i].startTime == stationArr[j].startTime
						&& stationArr[i].endTime == stationArr[j].endTime) {
					if (num >= 10) {
						if (packageUp.length == 0) {
							packageUp.push(new ObjPackageUp(stationArr[i].index, stationArr[i].projectId, stationArr[i].projectName, stationArr[i].id,
									stationArr[i].productName, stationArr[i].packageId, stationArr[i].packageName, stationArr[i].endTime))
							packageUp.push(new ObjPackageUp(stationArr[j].index, stationArr[j].projectId, stationArr[j].projectName, stationArr[j].id,
									stationArr[j].productName, stationArr[j].packageId, stationArr[j].packageName, stationArr[j].endTime))
						} else {
							for (var x = 0; x < packageUp.length; x++) {
								if (stationArr[i].id == packageUp[x].productId)
									break;
								if (stationArr[i].id != packageUp[x].productId && x == packageUp.length - 1) {
									packageUp.push(new ObjPackageUp(stationArr[i].index, stationArr[i].projectId, stationArr[i].projectName, stationArr[i].id,
											stationArr[i].productName, stationArr[i].packageId, stationArr[i].packageName, stationArr[i].endTime))
									break;
								}
							}
							for (var x = 0; x < packageUp.length; x++) {
								if (stationArr[j].id == packageUp[x].productId)
									break;
								if (stationArr[j].id != packageUp[x].productId && x == packageUp.length - 1) {
									packageUp.push(new ObjPackageUp(stationArr[j].index, stationArr[j].projectId, stationArr[j].projectName, stationArr[j].id,
											stationArr[j].productName, stationArr[j].packageId, stationArr[j].packageName, stationArr[i].endTime))
									break;
								}
							}
						}

					}
				}
			}
		}
	}
	return packageUp;
}

function ObjPackageUp(index, projectId, projectName, productId, productName, packageId, packageName, endTime) {
	this.index = index;
	this.projectId = projectId;
	this.projectName = projectName;
	this.productId = productId;
	this.productName = productName;
	this.packageId = packageId;
	this.packageName = packageName;
	this.endTime = endTime;
}

// 设置订单编号以及订单生成时间
function orderNoAndTime() {
	debugger;
	var currentDate = new Date();
	$('#orderPageTotal').find('p').eq(0).find('span').text("1457436836782811154");
	$('#orderPageTotal').find('p').eq(1).find('span').text((new Date(currentDate.getTime())).Format("yyyy-MM-dd hh:mm:ss"));
	$('#orderPageTotal').find('p').eq(2).find('span').text("");
	$('#orderPageTotal').find('p').eq(2).hide();
	if (rebateAvtive) {
		$('#orderPageTotal').find('p').eq(2).show();
		$('#orderPageTotal').find('p').eq(2).find('span').text(favourCode);
	}
}

function ObjStory(index, id, projectName, projectId, productName, biaoti, type, seatArr, seatArrId, price, volume, packageType, packageName, packagePrice,
		packageId, packageIncrementLevel, discountProductId, timeEnough, startTime, endTime, unit, unitEnum, packageUnit, existPackage, calculateResult,
		packageFavor, calculatePackageResult, margin, packageDiscountPrice, packageNoId, productType, productArea, disposableCost, discountProductType,
		upPackageObj, upPackageDiscountObj, telecomSetCost, favorableLastMonth, disposableCostPrice, oneMonthMoney) // 声明对象
{
	this.index = index;
	this.id = id;
	this.projectName = projectName;
	this.projectId = projectId;
	this.biaoti = biaoti;// 空间类型名称
	this.type = type;// 空间类型id
	this.productName = productName;
	this.seatArr = seatArr;
	this.seatArrId = seatArrId;
	this.price = price;
	this.volume = volume;
	this.packageType = packageType;
	this.packageName = packageName;
	this.packagePrice = packagePrice;
	this.packageId = packageId;
	this.packageIncrementLevel = packageIncrementLevel;
	this.discountProductId = discountProductId;
	this.timeEnough = timeEnough;
	this.startTime = startTime;
	this.endTime = endTime;
	this.unit = unit;
	this.unitEnum = unitEnum;
	this.packageUnit = packageUnit;
	this.existPackage = existPackage;// 是否存在智慧包
	this.calculateResult = calculateResult;// 计算结果
	this.calculatePackageResult = calculatePackageResult;// 计算智慧包结果
	this.packageFavor = packageFavor;// 智慧包的优惠
	this.margin = margin;// 保证金
	this.packageDiscountPrice = packageDiscountPrice;// 智慧包减免优惠
	this.packageNoId = packageNoId;// 前台用来添加智慧宝时分辨对象的id
	this.productType = productType; // 产品类型
	this.productArea = productArea; // 产品面积
	this.disposableCost = disposableCost; // 一次性费用
	this.discountProductType = discountProductType; //
	this.upPackageObj = upPackageObj; // 智慧包升级之后所选定的智慧包
	this.upPackageDiscountObj = upPackageDiscountObj; // 智慧包升级之后所获取到的减免优惠产品
	this.telecomSetCost = telecomSetCost; // 电信设置费用
	this.favorableLastMonth = favorableLastMonth;
	this.disposableCostPrice = disposableCostPrice;
	this.oneMonthMoney = oneMonthMoney;// 产品单个月的价格
}

function upPackageObj(packageId, packageName, packageType, packagePrice, packageUnit, discountProductId, packageDiscountPrice, discountProductType) {
	this.packageType = packageType;
	this.packagePrice = packagePrice;
	this.packageName = packageName;
	this.packageId = packageId;
	this.packageUnit = packageUnit;
	this.packageDiscountPrice = packageDiscountPrice;
	this.discountProductType = discountProductType;
	this.discountProductId = discountProductId;
}

function upPackageDiscountObj(upPackageId, upPackageName, upPackageType, upPackageDiscountPrice, upPackageUnit) {
	this.upPackageId = upPackageId;
	this.upPackageName = upPackageName;
	this.upPackageType = upPackageType;
	this.upPackageDiscountPrice = upPackageDiscountPrice;
	this.upPackageUnit = upPackageUnit;
}

// 用户注册
function register() {
	$(".no-register").click(function() {
		$('.pageToButton').attr('disabled', true);
		$(".order-right").css("display", "none");
		$(".order-rights").css("display", "block");
	})
};

// 给第二个页面添加数据
function padding2PageData() {
	$('#projectsDiv').find('.projects').remove()
	$('#projectsDiv').find('.page2DataShow').remove()
	var page2Product = $('.page2ProductShow');
	for (var i = 0; i < projectArr.length; i++) {
		var mark = 0;
		var htm = "";
		htm += "<div class='projects'>" + projectArr[i] + "</div><div class='page2DataShow'>";
		for (var j = 0; j < stationArr.length; j++) {
			if (page2Product.length == 0) {
				if (stationArr[j].projectName == projectArr[i] && stationArr[j].seatArr.length > 0) {
					htm += "<div class='page2ProductShow' productId='" + stationArr[j].id
							+ "' class='z-tr-d'><div class='z-round z-p-r'></div><div class='z-line z-p-l'></div>" + "<div class='tl'><b>"
							+ stationArr[j].productName + "(" + stationArr[j].biaoti + ")</b><p>";
					for (var x = 0; x < stationArr[j].seatArr.length; x++) {
						if (x != stationArr[j].seatArr.length - 1) {
							if ((x + 1) % 6 == 0) {
								htm += stationArr[j].seatArr[x];
							} else {
								htm += stationArr[j].seatArr[x] + ",";
							}
						} else {
							htm += stationArr[j].seatArr[x];
						}
						if ((x + 1) % 6 == 0)
							htm += "</br>"
					}

					if (stationArr[j].packageType != null) {
						htm += "</p><span class='yhfw'>" + stationArr[j].packageName + "服务</span></div></div>";
					} else {
						htm += "</p></div></div>";
					}
				}
				mark = 1;
			} else {
				for (var h = 0; h < page2Product.length; h++) {
					if (page2Product.eq(h).attr('productId') != stationArr[j].id) {
						if (stationArr[j].projectName == projectArr[i] && stationArr[j].seatArr.length > 0) {
							htm += "<div class='page2ProductShow' productId='" + stationArr[j].id
									+ "' class='z-tr-d'><div class='z-round z-p-r'></div><div class='z-line z-p-l'></div>" + "<div class='tl'><b>"
									+ stationArr[j].biaoti + "</b><p>";
							for (var x = 0; x < stationArr[j].seatArr.length; x++) {
								if (x != stationArr[j].seatArr.length - 1) {
									htm += stationArr[j].seatArr[x] + ",";
								} else {
									htm += stationArr[j].seatArr[x];
								}
							}

							if (stationArr[j].packageType != null) {
								htm += "</p><span class='yhfw'>" + stationArr[j].packageName + "服务</span></div></div>";
							} else {
								htm += "</p></div></div>";
							}
							mark = 1;
						}

					}
				}
			}

		}
		htm += "</div>";
		if (mark == 1) {
			$('#projectsDiv').append(htm)
		}
	}

}
// 用户注册
function userRegister() {
	ssPhone = $("#phone").val();
	if ($("#phone").val() == "") {
		$('.promptBox').find('p').text("电话号码不能为空！")
		$('.promptBox').show();
		$(".b-wrap").removeClass("hidden");
	}
	// invokeValidateFunction(inputName)
	$.ajax({
		url : 'filter/offlineReserve/userRegister',
		type : 'post',
		data : {
			'userPhone' : $("#phone").val(),
			'userPw' : $("#userpass").val(),
			'userName' : $("#username").val()
		},
		cache : false,
		async : false,
		dataType : 'text',
		success : function(data) {
			getUserInfoByPhone($("#phone").val())
		}
	});
}

function componyRegister() {
	$.ajax({
		url : 'filter/offlineReserve/componyRegister',
		type : 'post',
		data : {
			'companyPhone' : $("#companyPhone").val(),
			'companyName' : $("#companyName").val()
		},
		cache : false,
		dataType : 'json',
		success : function(data) {
			// 注册完成后直接选定公司名称
			if (data.companyId == null) {
				$('.promptBox').find('p').text("注册失败！")
				$('.promptBox').show();
				$(".b-wrap").removeClass("hidden");
			} else {
				$(".seat-alert10").css("margin-top", "-" + parseInt($(".seat-alert8").css("height")) / 2 + "px");
				$(".seat-alert9").hide();
				$(".seat-alert10").show();
				forCompanyAndUser();
				getUserInfoByPhone(ssPhone);
			}

		}
	});
}

function hideAgreement() {
	$('.sure-agreement').hide()
	$(".b-wrap").addClass("hidden");
}

// 隐藏选择座位框
function hideAlert() {
	$(".seat-alert").hide();
}
// tab切换
function changeTab(clickClass, chageColor, changeDiv) {
	$(clickClass).click(function() {
		$(this).addClass(chageColor).siblings().removeClass(chageColor);
		$(changeDiv).eq($(this).index() - 1).removeClass('hidden').siblings(changeDiv).addClass("hidden");
	})
}

function getDays(strDateStart, strDateEnd) {
	var strSeparator = "-"; // 日期分隔符
	var oDate1;
	var oDate2;
	var iDays;
	oDate1 = strDateStart.split(strSeparator);
	oDate2 = strDateEnd.split(strSeparator);
	var strDateS = new Date(oDate1[0], oDate1[1] - 1, oDate1[2]);
	var strDateE = new Date(oDate2[0], oDate2[1] - 1, oDate2[2]);
	iDays = parseInt((strDateE - strDateS) / 1000 / 60 / 60 / 24)// 把相差的毫秒数转换为天数
	return iDays;
}

function monthDiff(startDate, endDate) {
	var months;
	months = (d2.getFullYear() - d1.getFullYear()) * 12;
	months -= d1.getMonth() + 1;
	months += d2.getMonth();
	return months <= 0 ? 0 : months;
}

function formatterDateTime(date) {
	alert(date)
	var datetime = date.getFullYear() + "-"// "年"
			+ ((date.getMonth() + 1) > 10 ? (date.getMonth() + 1) : "0" + (date.getMonth() + 1)) + "-"// "月"
			+ (date.getDate() < 10 ? "0" + date.getDate() : date.getDate()) + " " + (date.getHours() < 10 ? "0" + date.getHours() : date.getHours()) + ":"
			+ (date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes()) + ":"
			+ (date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds());
	return datetime;
}

// 分配订单下拉框
$(function() {
	$(".filling-name").click(function() {
		$(".company-date").show();
	})
	$(".company-date li:not(:last)").click(function() {
		$(".company-date").hide();
		$(".filling-name").text($(this).html());
	})
	$(".company-date li:last-child").click(function() {
		$(".seat-alert8").css("margin-top", "-" + parseInt($(".seat-alert8").css("height")) / 2 + "px");
		$(".seat-alert8").show();
		$(".company-date").hide();
		$(".b-wrap").removeClass("hidden"); // 显示遮盖层
	});
	$(".searchclose").click(function() {
		$(".seat-alert").hide();
		$(".b-wrap").addClass("hidden"); // 显示遮盖层
	});
})
function clickUpDown() {
	$(".filling-name").click(function() {
		$(this).parent().parent().parent().find(".company-date").css('z-index', '999');
		var searchResultBtn = $('.search-result').find('button');
		if (searchResultBtn.hasClass('currentButton')) {
			searchResultBtn.removeClass('currentButton');
		}
		$(this).addClass('currentButton');
		var find = $(this).parent().parent().parent().find(".company-date");
		if (find.css("display") == "none") {
			$(".company-date").hide()
			find.show();
		} else {
			find.hide();
		}
		// 点击其他地方进行隐藏
		var $menu = find;
		$(document).click(function(e) {
			if (!(e.target == $menu[0] || $.contains($menu[0], e.target))) {
				$menu.hide();
			}
		});

	})
	$(".company-date li:not(:last)").click(
			function() {
				$(".company-date").hide();
				var companyNameStr = $(this).html().trim();
				var companyIdStr = $(this).attr('companyid');
				$(this).parent().parent().parent().parent().attr('companyId', companyIdStr);
				var attr = $(this).parent().parent().parent().parent().attr('companyId');
				if ($(this).html().trim() != "+新增公司") {
					$(this).parent().parent().parent().find(".filling-name").html(
							companyNameStr.substring(3, companyNameStr.length - 4) + "<span class='caret'></span>");
				}
				$('.currentSelectUser').removeClass('currentSelectUser');
				// $(this).addClass('currentSelectUser');
			})
	$(".company-date li:last-child").click(function() {
		$(this).addClass('currentSelectUser');
		// 获取所有的公司
		getCompanyInfo(this);
		$(".seat-alert8").css("margin-top", "-" + parseInt($(".seat-alert8").css("height")) / 2 + "px");
		$(".seat-alert8").show();
		$(".company-date").hide();
		$(".b-wrap").removeClass("hidden"); // 显示遮盖层
	});
	$(".searchclose").click(function() {
		$(".seat-alert").hide();
		$(".b-wrap").addClass("hidden"); // 显示遮盖层
	});
}

function getCompanyInfo(t) {
	$
			.ajax({
				url : 'filter/offlineReserve/getCompanyInfo',
				type : 'post',
				cache : false,
				async : false,
				dataType : 'json',
				success : function(data) {
					$('.searchnew').find('tr').remove()
					var companyDateLi = $(t).parent().parent().parent().find('.company-date').find('li');
					var htm = "";
					htm += "<tr><th></th><th>公司名称</th><th>公司编号</th><th></th></tr>"
					for (var i = 0; i < 5; i++) {
						for (var j = 0; j < companyDateLi.length; j++) {
							var companyId = companyDateLi.eq(j).attr('companyId');
							if (companyId == data[i].companyId) {
								htm += "<tr class='person-list companyTr' companyId='"
										+ data[i].companyId
										+ "' ><td><i class='glyphicon glyphicon-user'></i></td><td class='td-name'>"
										+ data[i].companyName
										+ "</td>"
										+ "<td class='td-number'>AD1120134</td><td><button type='button' class='btn btn-default bts' onclick='sureSelectCompany(this)'>已选择</button></td></tr>"
								break;
							}
							if (j == companyDateLi.length - 1) {
								htm += "<tr class='person-list companyTr' companyId='"
										+ data[i].companyId
										+ "' ><td><i class='glyphicon glyphicon-user'></i></td><td class='td-name'>"
										+ data[i].companyName
										+ "</td>"
										+ "<td class='td-number'>AD1120134</td><td><button type='button' class='btn btn-default bts' onclick='sureSelectCompany(this)'>选择</button></td></tr>"
								break;
							}
						}
					}

					$('.searchnew>table').append(htm)
				}
			});
}

function getCompanyInfoByPhone(t, userPhone) {
	$
			.ajax({
				url : 'filter/offlineReserve/getCompanyInfo',
				type : 'post',
				data : {
					"userPhone" : userPhone
				},
				cache : false,
				async : false,
				dataType : 'json',
				success : function(data) {
					debugger;
					$('.searchnew').find('tr').remove();
					var companyDateLi = $('.currentSelectUser').parent().parent().parent().find('.company-date').find('li');
					var htm = "";
					for (var i = 0; i < data.length; i++) {
						for (var j = 0; j < companyDateLi.length; j++) {
							var companyId = companyDateLi.eq(j).attr('companyId');
							if (companyId == data[i].companyId) {
								htm += "<tr class='person-list companyTr' companyId='"
										+ data[i].companyId
										+ "' ><td><i class='glyphicon glyphicon-user'></i></td><td class='td-name'>"
										+ data[i].companyName
										+ "</td>"
										+ "<td class='td-number'>AD1120134</td><td><button type='button' class='btn btn-default bts' onclick='sureSelectCompany(this)'>已选择</button></td></tr>"
								break;
							}
							if (j == companyDateLi.length - 1) {
								htm += "<tr class='person-list companyTr' companyId='"
										+ data[i].companyId
										+ "' ><td><i class='glyphicon glyphicon-user'></i></td><td class='td-name'>"
										+ data[i].companyName
										+ "</td>"
										+ "<td class='td-number'>AD1120134</td><td><button type='button' class='btn btn-default bts' onclick='sureSelectCompany(this)'>选择</button></td></tr>"
							}
						}
					}
					$('.searchnew>table').append(htm)
				}
			});
}

function sureSelectCompany(t) {
	// debugger;
	var companyId = $(t).parent().parent().attr('companyId');
	var companyName = $(t).parent().parent().find('td').eq(1).text().trim();
	if ($(t).text().trim() == "已选择") {
		$('.promptBox').find('p').text("此公司已被选择！")
		$('.promptBox').show();
		$(".b-wrap").removeClass("hidden");
		return;
	}
	// 为选中的公司赋值
	var currentButton = $('.search-result').find('.currentButton');
	currentButton.parent().parent().parent().attr('companyId', companyId);
	var userId = currentButton.parent().parent().parent().attr('userId');
	$(".seat-alert8").hide();
	$(".b-wrap").addClass("hidden"); // 显示遮盖层
	if (window.confirm("确定提交？")) {
		$.ajax({
			url : 'filter/offlineReserve/addCompanyAndUser',
			type : 'post',
			data : {
				'userId' : userId,
				'companyId' : companyId
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				if (data) {
					$('.currentSelectUser').parent().prepend("<li companyid='" + companyId + "'><a>" + companyName + "</a></li>");
					currentButton.html(companyName + "<span class='caret'></span>");
					// 给新生成的li添加点击事件
					$(".company-date li:not(:last)").click(
							function() {
								$(".company-date").hide();
								var companyNameStr = $(this).html().trim();
								var companyIdStr = $(this).attr('companyid');
								$(this).parent().parent().parent().parent().attr('companyId', companyIdStr);
								var attr = $(this).parent().parent().parent().parent().attr('companyId');
								if ($(this).html().trim() != "+新增公司") {
									$(this).parent().parent().parent().find(".filling-name").html(
											companyNameStr.substring(3, companyNameStr.length - 4) + "<span class='caret'></span>");
								}
								$('.currentSelectUser').removeClass('currentSelectUser');
							})
				}
			}
		});
	}
}

function forCompanyAndUser() {
	$(".seat-alert8").hide();
	$(".b-wrap").addClass("hidden"); // 显示遮盖层
	$.ajax({
		url : 'filter/offlineReserve/addCompanyUser',
		type : 'post',
		data : {},
		cache : false,
		dataType : 'json',
		success : function(data) {
		}
	});
}

function invokeValidateFunction(inputName) {
	inputName = inputName.substring(0, 1).toUpperCase() + inputName.substring(1);
	var functionName = "validate" + inputName;
	return eval(functionName + "()");
}

function validateUsername() {
	var bool = true;
	$("#usernameError").css("display", "none");
	var value = $("#username").val();
	if (!value) {// 非空校验
		$("#usernameError").css("display", "");
		$("#usernameError").text("会员名称不能为空！");
		bool = false;
	} else if (value.length < 1) {// 长度校验
		$("#usernameError").css("display", "");
		$("#usernameError").text("会员名称长度必须在1 ~ 20之间！");
		bool = false;
	}
	return bool;
}

function validateUserpass() {
	var bool = true;
	$("#userpassError").css("display", "none");
	var value = $("#userpass").val();
	if (!value) {// 非空校验
		$("#userpassError").css("display", "");
		$("#userpassError").text("密码不能为空！");
		bool = false;
	} else if (value.length < 3) {// 长度校验
		$("#userpassError").css("display", "");
		$("#userpassError").text("密码长度必须在3 ~ 20之间！");
		bool = false;
	}
	return bool;
}

function validateUserpassTwo() {
	var bool = true;
	$("#userpassErrorTwo").css("display", "none");
	var value = $("#userpassTwo").val();
	if (!value) {// 非空校验
		$("#userpassErrorTwo").css("display", "");
		$("#userpassErrorTwo").text("密码不能为空！");
		bool = false;
	} else if (value.length < 3) {// 长度校验
		$("#userpassErrorTwo").css("display", "");
		$("#userpassErrorTwo").text("密码长度必须在3 ~ 20之间！");
		bool = false;
	}
	var val = $("#userpass").val();
	if (val != value) {
		$("#phoneError").css("display", "");
		$("#phoneError").text("两次密码不一致！");
	} else {
		$("#phoneError").css("display", "none");
	}
	return bool;
}

function validatePhone() {
	var bool = true;
	$("#phoneError").css("display", "none");
	var value = $("#phone").val();
	if (!value) {// 非空校验
		$("#phoneError").css("display", "");
		$("#phoneError").text("电话号码不能为空！");
		bool = false;
	} else if (value.length != 11) {// 长度校验
		$("#phoneError").css("display", "");
		$("#phoneError").text("电话号码长度必须为11之间！");
		bool = false;
	}
	return bool;
}

function addFn(dataOne, dataTwo) {

	var dataOneInt = dataOne.toString().split(".")[0];
	var dataOneFloat = "";
	var dataTwoInt = dataTwo.toString().split(".")[0];
	var dataTwoFloat = "";
	var lengthOne = 0;
	var lengthTwo = 0;
	var maxlength = 0;

	if (dataOne.toString().split(".").length == 2) {
		dataOneFloat = dataOne.toString().split(".")[1];
		lengthOne = dataOneFloat.toString().length;

	}
	if (dataTwo.toString().split(".").length == 2) {
		dataTwoFloat = dataTwo.toString().split(".")[1];
		lengthTwo = dataTwoFloat.toString().length;

	}

	maxLength = Math.max(lengthOne, lengthTwo);
	for (var i = 0; i < maxLength - lengthOne; i++) {
		dataOneFloat += "0";
	}
	for (var i = 0; i < maxLength - lengthTwo; i++) {
		dataTwoFloat += "0";
	}

	/**
	 * 对两个数据进行倍数放大 使其都变为整数。因为整数计算 比较精确。
	 */
	var one = dataOneInt + "" + dataOneFloat;
	var two = dataTwoInt + "" + dataTwoFloat;
	// alert("dataOne:"+dataOne+" dataTwo:"+dataTwo +" one:"+one+" two:"+two);
	/**
	 * 数据扩大倍数后，经计算的到结果， 然后在缩小相同的倍数 进而得到正确的结果
	 */
	var result = (Number(one) + Number(two)) / Math.pow(10, maxLength);

	return result;

}

function changeTwoDecimal_f(x) {
	var f_x = parseFloat(x);
	if (isNaN(f_x)) {
		alert('function:changeTwoDecimal->parameter error');
		return false;
	}
	var f_x = Math.round(x * 100) / 100;
	var s_x = f_x.toString();
	var pos_decimal = s_x.indexOf('.');
	if (pos_decimal < 0) {
		pos_decimal = s_x.length;
		s_x += '.';
	}
	while (s_x.length <= pos_decimal + 2) {
		s_x += '0';
	}
	return s_x;
}

function calendarSet() {
	$('#datetimepicker2').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
	$('#datetimepicker3').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
	$('#datetimepicker4').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
	$('#meetingRoomDateInput1').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
	$('#deadline').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
	$('#start-date').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
	$('#datetimepicker5').datetimepicker({
		datepicker : false,
		format : 'H:i',
		step : 60,
	// minTime:''
	});
	$('#datetimepicker6').datetimepicker({
		datepicker : false,
		format : 'H:i',
		step : 60,
	// minTime:'-1970/01/01'
	});
	$('#advanceCheckStartDate').datetimepicker({
		lang : 'ch',
		timepicker : false,
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		minDate : '-1970/01/01',
	});
}
$(function() {
	$("#date-div").click(function(event) {
		var event = event || window.event;
		event.stopPropagation();
		$(".data-month").toggle();
	})
	$(".data-month li").click(function(event) {
		var event = event || window.event;
		event.stopPropagation();
		console.log(1);
		$("#date-div").val($(this).html());
		// showEndDate();
		getCurrentDateAddMonths();
		$(".data-month").hide();
	})
	$("#start-date").click(function() {
		$(".xdsoft_prev").show();
		$(".xdsoft_next").show();
	})
})

function confirmAct() {
	if (confirm('确定要执行此操作吗?')) {
		return true;
	}
	return false;
}

function showEndDate() {
	// debugger;
	var startDate = $("#start-date").val();
	var m = $("#date-div").val().slice(0, $("#date-div").val().length - 2);
	if (m && startDate) {
		var startYear = startDate.slice(0, 4);
		var startMonth = startDate.slice(5, 7);
		var startDay = startDate.slice(8, 10);
		var endYear = Number(startYear);
		var endMonth = Number(startMonth) + Number(m);
		if (Number(startDay) <= 1) {
			endMonth -= 1;
		}
		;
		if (endMonth > 12) {
			endYear = Number(startYear) + parseInt(endMonth / 12);
			if (endMonth >= 24) {
				--endYear;
			}
			if (endMonth % 12 == 0) {
				endMonth = 12;
			} else {
				endMonth = endMonth % 12;
			}
		}
		var day = getDay(endYear, endMonth);
		var endDate = showNum(endYear) + "-" + showNum(endMonth) + "-" + day;
		getFirstAndLastMonthDay(endYear, endMonth);
		$("#endDate").val(endDate);
	}
};

// 日期增加n个月
function getCurrentDateAddMonths() {
	var startTime = $("#start-date").val();
	var months = $("#date-div").val().slice(0, $("#date-div").val().length - 2);

	$.ajax({
		url : 'filter/offlineReserve/addMonths',
		type : 'post',
		data : {
			"startTime" : startTime,
			"months" : months
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			$("#endDate").val(data.dateStr);
		}
	});

}

// 获取一个月的第一天和最后一天
function getFirstAndLastMonthDay(year, month) {
	minDate = year + '-' + month + '-01';
	var day = new Date(year, month, 0);
	maxDate = year + '-' + month + '-' + day.getDate();// 获取当月最后一天日期
	// 给文本控件赋值。同下
}

function judgeIsLastDay(date) {
	var year = date.substring(0, 4);
	var month = date.substring(5, 7);
	var day = new Date(year, month, 0);
	var lastDay = year + '-' + month + '-' + day.getDate();// 获取当月最后一天日期
	if (date == lastDay)
		return true;
	return false;
}

function getDay(y, m) {
	var isy = false;
	if (y % 400 == 0 || (y % 4 == 0 && y % 100 != 0))
		isy = true;
	switch (m) {
	case 1:
	case 3:
	case 5:
	case 7:
	case 8:
	case 10:
	case 12:
		return 31;
	case 4:
	case 6:
	case 9:
	case 11:
		return 30;
	case 2:
		return isy ? 29 : 28;
	}
};

function showNum(num) {
	return num > 9 ? num : "0" + num;
}
$(document).click(function() {
	$(".data-month").hide();
})