var assetType = "";
var prise;
var companyid;
var companyName = "";
$(function() {
	$('#mohucompany').focus();
	add_bill();
	$.ajax({
		url : 'filter/bookorder/findSpaceAssetEnumer',
		type : 'POST',
		data : {
			spaceId : 8
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data.message == 'success') {
				var template = Handlebars.compile($("#spaceId").html());
				$('#assetType').html(template(data.rows));
			}
		},
		error : function(data) {
		}
	});

	assetType = $("#assetType").val();
	searchproduct(assetType);

	// 页面初始化默认选择项目，以及筛选出对应的产品
	var initProjectId = $('#projectId').find("option:selected").val();
	screenProduct(initProjectId);

});
$('.reDatetimepicker').datetimepicker({
	lang : 'ch',
	timepicker : false,
	format : 'Y-m-d',
	formatDate : 'Y-m-d',
});
$("#add_book").on('click', function() {
	$('#content').load("filter/bookorder/addBill");
});
// 点击项目，筛选出对应的产品开始
function screenProduct(t) {
	var assetType = $("#assetType").val();
	searchproduct(assetType);
	var index;// 默认选中的索引值
	var option = $('#productId>option');
	for (var i = 0; i < option.length; i++) {
		$("#productId").find("option").eq(i).attr("selected",false);
		if (option.eq(i).attr('projectId') != t) {
			option.eq(i).remove();
		}else{
			if (typeof (index) == "undefined")
				index = i;
		}
	}
	$("#productId").find("option").eq(0).attr("selected",true);
}
// 点击项目，筛选出对应的产品结束
function add_bill() {
	companyName = $("#mohucompany").val();
	$.ajax({
		url : 'filter/bookorder/searchCompany',
		type : 'POST',
		data : {
			companyName : companyName
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data.message == 'success') {
				var template = Handlebars.compile($("#companyoption").html());
				$('#companyId').html(template(data.rows));
				companyid = $('#companyId').val();
				serchuserbycomid(companyid);
				$("#companyId").change(function() {
					companyid = $(this).val();
					serchuserbycomid(companyid);
				});
			}
		},
		error : function(data) {
		}
	});
}
$("#mohucompany").blur(function() {
	add_bill();
});

$("#mohuuser").blur(function() {
	var userPhone = $("#mohuuser").val();
	if (userPhone == "" || userPhone == null) {
		serchuserbycomid(companyid);
	} else {
		$.ajax({
			url : 'filter/bookorder/searchUser',
			type : 'POST',
			data : {
				userPhone : userPhone,
				companyId : companyid
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					var template = Handlebars.compile($("#useroption").html());
					$('#userPhone').html(template(data.rows));
				}
			},
			error : function(data) {
			}
		});
	}

});

$("#bookCount").blur(function() {
	var bookCount = $("#bookCount").val();
	$("#fee").val(Number(bookCount) * Number(prise));
});
$("#assetType").on("change", function() {
	assetType = $("#assetType").val();
	searchproduct(assetType);
});

$("#formcheck_sure").on(
		"click",
		function() {
			var judge = true;
			var companyId = $("#companyId").val();
			var userPhone = $("#userPhone").val();
			var productType = $("#assetType").val();
			var productId = $("#productId").val();
			var bookCount = $("#bookCount").val();
			var fee = $("#fee").val();
			var effectTime = $("#effectTime").val();
			var lapsedTime = $("#lapsedTime").val();
			var status = $("#status").val();
			var creg = new RegExp(/^(-)?[1-9][0-9]*$/);
			if (companyId == null || companyId == "") {
				judge = false;
				$("#cocha").show();
			} else {
				$("#cocha").hide();
			}
			if (userPhone == null || userPhone == "") {
				judge = false;
				$("#uscha").show();
			} else {
				$("#uscha").hide();
			}
			if (productType == null || productType == "") {
				judge = false;
				$("#ascha").show();
			} else {
				$("#ascha").hide();
			}
			if (productId == null || productId == "") {
				judge = false;
				$("#prcha").show();
			} else {
				$("#prcha").hide();
			}
			if (!creg.test(bookCount)) {
				judge = false;
				$("#bocha").show();
			} else {
				$("#bocha").hide();
			}
			if (fee == null || fee == "") {
				judge = false;
				$("#fecha").show();
			} else {
				$("#fecha").hide();
			}
			if (effectTime == null || effectTime == "") {
				judge = false;
				$("#efcha").show();
			} else {
				$("#efcha").hide();
			}
			if (lapsedTime == null || lapsedTime == "") {
				judge = false;
				$("#lacha").show();
			} else {
				$("#lacha").hide();
			}
			var companyName = $("#companyId").find("option:selected").attr("data-name");
			var phone = $("#userPhone").find("option:selected").attr("data-name");
			var assetType = $("#assetType").find("option:selected").attr("data-name");
			var productId = $("#productId").find("option:selected").attr("data-name");
			var statusName = $("#status").find("option:selected").attr("data-name");
			if (judge) {
				var text = confirm("             公司名称：" + companyName + String.fromCharCode(10) + "             会员帐号： " + phone + String.fromCharCode(10)
						+ "             产品类型： " + assetType + String.fromCharCode(10) + "              产    品  ： " + productId + String.fromCharCode(10)
						+ "              数    量  ： " + bookCount + String.fromCharCode(10) + "             生效时间： " + effectTime + String.fromCharCode(10)
						+ "             失效时间： " + lapsedTime + String.fromCharCode(10) + "             结清状态： " + statusName + String.fromCharCode(10) + ""
						+ String.fromCharCode(10) + "" + "             请核对所填的信息是否正确");
				if (text == true) {
					$(".alert-cha").css("display", "none");
					var data = $("#bookinfo").serialize();
					$.ajax({
						url : 'filter/bookorder/saveBookInfo',
						type : 'POST',
						data : data,
						cache : false,
						async : false,
						dataType : 'json',
						success : function(data) {
							alert(data.message);
						},
						error : function(data) {
							alert(data.message);
						}
					});
				}
			}

		});

$("#return_esc").on("click", function() {
	$('#item_dialog').dialog('destroy');
});

function searchproduct(assetType) {
	$.ajax({
		url : 'filter/bookorder/findProduct',
		type : 'POST',
		data : {
			spaceId : 8,
			productType : assetType
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data.message == 'success') {
				var template = Handlebars.compile($("#product").html());
				$('#productId').html(template(data.rows));
				prise = $('#productId>.proclass').eq(0).attr("data-value");
				var bookCount = $("#bookCount").val();
				if (bookCount != null && bookCount != "" & prise != null && prise != "") {
					$("#fee").val(Number(bookCount) * Number(prise));
				}
				$("#productId").change(function(t) {
					prise = $(this).find("option:selected").attr("data-value");
					var bookCount = $("#bookCount").val();
					if (bookCount != null && bookCount != "") {
						$("#fee").val(Number(bookCount) * Number(prise));
					}
				});
			}
		},
		error : function(data) {
		}
	});
}
function serchuserbycomid(companyid) {
	$.ajax({
		url : 'filter/bookorder/searchUserBycomId',
		type : 'POST',
		data : {
			companyId : companyid
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(data) {
			if (data.message == 'success') {
				var template = Handlebars.compile($("#useroption").html());
				$('#userPhone').html(template(data.rows));
			}
		},
		error : function(data) {
		}
	});
}
