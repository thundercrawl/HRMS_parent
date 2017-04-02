var MR;// 读卡器控件对象
var lastFinger;
var cardid,tempSerial;

// 获取界面上选择的卡类型
function getcardtype() {
	/*
	 * for (i = 0; i < 8; i++) { if (radio[i].checked) return i + 1; }
	 */
	return 3;
}

// 初始化，连接发卡器。固定使用串口 0
function initPort() {
	try {
		if (MR == null) {
			MR = document.getElementById("MReader");
		}
		if (MR != null) {
			ret = MR.OnIniCom(0);
			{
// alert(ret+"---已打开发卡器！");
			}
		}
	} catch (e) {
	}
	return -1;
}

// 连接卡，相当于读卡号
function connect_card() {
	try {
		initPort();
		if (MR == null) {
			MR = document.getElementById("MReader");

		}
		
		if (MR != null) {
			cardtype = getcardtype();
			MR.RS_SetSingAndBlink(1, 1);
			cardid = MR.RS_ReadSerial('0', getcardtype());
			tempSerial = cardid;
			if(cardid.length>=16){
				
				cardid = cardid.substring(8,16);
				document.getElementById("serial").value = cardid;
				
			}
			return false;
		}
	} catch (e) {
	}
	return -1;
}

// 断开卡，不再对卡操作
function disconnect_card() {
	try {
		if (MR == null) {
			MR = document.getElementById("MReader");
		}
		if (MR != null) {
			if (MR.RS_DisConnectCard('0', getcardtype()) == '0') {
			}
		}
	} catch (e) {
	}
	return -1;
}

// 直接向发卡器发送命令。一般不使用，内部调试用
function send_command() {
	try {
		if (MR == null) {
			MR = document.getElementById("MReader");
		}
		if (MR != null) {
			ret = (MR.RS_SendCommand('0', getcardtype(), 'A233', document
					.getElementById("command").value, 300))
			{
				alert(ret);
			}
		}
	} catch (e) {
	}
	return -1;
}

// 检查立方标志
function check_rfcode() {
	try {
		if (MR == null) {
			MR = document.getElementById("MReader");
		}
		if (MR != null) {
			stserial = document.getElementById("serial").value;
			ret = MR.RC_CheckRFCode(0, stserial);
		}
	} catch (e) {
	}
	return -1;
}

// 关闭发卡器，断开连接
function closePort() {
	try {
		MR.CloseCom(0);
	} catch (e) {
	}
}

// 读卡号
function getCardSerial() {
	connect_card();
// tempSerial = MR.RS_ReadSerial('0', getcardtype());
	if (tempSerial != '-1' & tempSerial != '') {
// document.getElementById("serial").value = tempSerial;
	} else {
		alert('读取卡号失败');
	}
}

function disconnect_fm_cpu() {
	tempSerial = MR.FM_DisconnectCard('0');

	document.getElementById("fm_cpu_serial").value = "";
}

function fm_read_cardno() {
	ret = MR.FM_GetCardNo();
	document.getElementById("fm_cpu_cardno").value = ret;
	document.getElementById("fm_cpu_validate").value = MR.ValidBegin + " ~ "
			+ MR.ValidEnd;
}

function fm_read_file() {
	filename = document.getElementById("fm_cpu_filename").value;
	foffset = document.getElementById("fm_cpu_file_offset").value;
	flength = document.getElementById("fm_cpu_file_length").value;
	ret = MR.FM_ReadFile(filename, foffset, flength);
	document.getElementById("fm_cpu_file_text").value = ret;
}

function fm_send_card() {
	cardtype = document.getElementById("fm_cpu_cardtype").value;
	validbgn = document.getElementById("fm_cpu_validbegin").value;
	validend = document.getElementById("fm_cpu_validend").value;
	chargeruleid = document.getElementById("fm_cpu_chargeruleid").value;
	clublist = document.getElementById("fm_cpu_clublist").value;
	ret = MR.FM_SendUserCard(cardtype, validbgn, validend, chargeruleid,
			clublist);
	if (ret == 0)
		alert("发卡成功");
	else
		alert("发卡失败: " + ret);
}
$(function() {
	
	$('#orderSearch').on(
			'click',
			function() {
				var orderNum = $("#orderNum").val();
				$('#orderSearchCondition').val($('#forid').serialize());
				$('#tid').load("filter/readCard/getCard",
						$('#forid').serialize(), function() {
							$('.pagination>li>a').on('click', pageFunc);
						});
			})

	toReadCard = function() {
		var cardNum = $('#serial').val();
		$('#forIn').load("filter/readCard/showResoveCard?cardNum=" + cardNum);
	}

	$(".alldiv").click(function() {
		$(".checkTt").each(function() {
			this.checked = $(".alldiv").prop("checked");
		});
	});

	$('#forLost').on('click', function() {
		$('#forIn').load("filter/readCard/showLostCard");
	});
	doorRest = function() {
		var flag=0;
		var grantType = 1;
		var password = "000000";
		var cardRest = Handlebars.compile($("#cardRest").html());
		var door = "";
		$("input[name='tt']:checked").each(function() {
			door = door + ($(this).val()) + ",";
		});
		var phoneNum = $('#phoneNum').val();
		var cardNum = $('#serial').val();
		var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		if(grantType==1){
		if(!myreg.test(phoneNum)){ 
        alert('请输入有效的手机号码！'); 
        return false; 
		}
		var creg = new RegExp(/^[0-9a-zA-Z]{8}$/);
		if(!creg.test(cardNum)){ 
	        alert('请输入合法的卡号(8位数字、字母)！'); 
	        return false; 
			}
		if(door==""){
			alert("请至少选择一个门");
			 return false; 
		}
		flag=1;
		}
		if(flag==1){
		$.ajax({
			url : "filter/readCard/cardForMan",
			data : {
				door : door,
				cardNum : cardNum,
				phoneNum : phoneNum,
				password : password,
				grantType :grantType
			},
			type : 'POST',
			dataType : "json",
			success : function(data) {
				$('#forRestCard').html(cardRest(data.rows));

			},
			error : function(XMLResponse) {
			}
		});
	}
	}
		
	doorBossRest = function(grandType) {
		var flag=0;
		var door = "";
		$("input[name='tt']:checked").each(function() {
			door = door + ($(this).val()) + ",";
		});
		var phoneNum = $('#phoneNum').val();
		var cardNum = $('#serial').val();
		var startTime = $('#startTime').val();
		var endTime = $('#endTime').val();
		var passwd = $('#passwd').val();
		var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
		var reg = new RegExp(/^\d{6}$/);
		var creg = new RegExp(/^[0-9a-zA-Z]{8}$/);
		var companyId=$('#companyId').val();
		
		console.log(tag);
		if(companyId==""){
			alert("公司名输入有误。请从下拉框中选择已有公司！");
			flag=0;
		}
		if(grandType==1){
			if(door==""){
				alert("请至少选择一个门");
				return false;
			}if(!myreg.test(phoneNum)){ 
		        alert('请输入有效的手机号码！'); 
		        return false;
				}if(startTime==""){
				alert("请选择起始时间");
				return false;
			}if(endTime==""){
				alert("请选择结束时间");
				return false;
			}
			if(!creg.test(cardNum)){ 
		        alert('请输入合法的卡号(8位数字、字母)！'); 
		        return false;
				}
			flag=1;
		}
		if(grandType==2){
			if(door==""){
				alert("请至少选择一个门");
				return false;
			}if(!myreg.test(phoneNum)){ 
		        alert('请输入有效的手机号码！'); 
		        return false;
				}if(startTime==""){
				alert("请选择起始时间");
				return false;
			}if(endTime==""){
				alert("请选择结束时间");
				return false;
			}if(!reg.test(passwd)){ 
		        alert('请输入合法的密码(6位数字)'); 
		        return false;
				}
			flag=1;
		}
		if(grandType==3){
			if(door==""){
				alert("请至少选择一个门");
				return false;
			}/*
				 * if(!myreg.test(phoneNum)){ alert('请输入有效的手机号码！'); return
				 * false; }
				 */// 不需要手机号码的校验
			if(startTime==""){
				alert("请选择起始时间");
				return false;
			}if(endTime==""){
				alert("请选择结束时间");
				return false;
			}
			flag=1;
		}
		if(grandType==4){
			if(door==""){
				alert("请至少选择一个门");
				return false;
			}if(!myreg.test(phoneNum)){ 
		        alert('请输入有效的手机号码！'); 
		        return false;
				}if(startTime==""){
				alert("请选择起始时间");
				return false;
			}if(endTime==""){
				alert("请选择结束时间");
				return false;
			}if(!reg.test(passwd)){ 
		        alert('请输入合法的密码(6位数字)'); 
		        return false;
				}if(!creg.test(cardNum)){ 
		        alert('请输入合法的卡号(8位数字、字母)！'); 
		        return false; 
				}
				flag=1;
		}
		if(grandType==5){
			if(door==""){
				alert("请至少选择一个门");
				return false;
			}if(!myreg.test(phoneNum)){ 
		        alert('请输入有效的手机号码！'); 
		        return false;;
				}if(startTime==""){
				alert("请选择起始时间");
				return false;
			}if(endTime==""){
				alert("请选择结束时间");
				return false;
			}if(!creg.test(cardNum)){ 
		        alert('请输入合法的卡号(8位数字、字母)！'); 
		        return false; 
				}
			flag=1;
		}
		if(grandType==6){
			if(!reg.test(passwd)){ 
		        alert('请输入合法的密码(6位数字)'); 
		        return false;
				}
			if(door==""){
				alert("请至少选择一个门");
				return false;
			}if(!myreg.test(phoneNum)){ 
		        alert('请输入有效的手机号码！'); 
		        return false;
				}if(startTime==""){
				alert("请选择起始时间");
				return false;
			}if(endTime==""){
				alert("请选择结束时间");
				return false;
			}if(passwd==""){
				alert("请输入密码");
				return false;
			}
			flag=1;
		}
		if(grandType==7){
			if(!reg.test(passwd)){ 
		        alert('请输入合法的密码(6位数字)'); 
		        return false;
				}
			if(door==""){
				alert("请至少选择一个门");
				return false;
			}if(!myreg.test(phoneNum)){ 
		        alert('请输入有效的手机号码！'); 
		        return false;
				}if(!creg.test(cardNum)){ 
		        alert('请输入合法的卡号(8位数字、字母)！'); 
		        return false;
				}if(startTime==""){
				alert("请选择起始时间");
				return false;
			}if(endTime==""){
				alert("请选择结束时间");
				return false;
			}
			flag=1;
		}
/*
 * if(door==""){ alert("请至少选择一个门"); flag=0; }if(phoneNum==""){ alert("请输入手机号");
 * flag=0; }if(cardNum==""){ alert("请读卡"); flag=0; }if(startTime==""){
 * alert("请选择起始时间"); flag=0; }if(endTime==""){ alert("请选择结束时间"); flag=0;
 * }if(passwd==""){ alert("请输入密码"); flag=0; }
 */if(flag==1){
			$('.black-shadow').show();
		$.ajax({
			url : "filter/readCard/forAdminDoorAgent",
			data : {
				door : door,
				cardNo : cardNum,
				phoneNum : phoneNum,
				startTime:startTime,
				endTime:endTime,
				passwd:passwd,
				grandType:grandType,
				companyId:companyId,
				tag:tag
				
			},
			type : 'POST',
			dataType : "json",
			success : function(data) {
				alert(data.errorMsg);
				$('.black-shadow').hide();
			},
			error : function(data) {
				alert(data.errorMsg);
				$('.black-shadow').hide();
			}
		});
		}
}
	// 手机号和公司名称切换
	$(".choose-one").eq(1).hide(); 
	for(var i=0;i<$(".choose-classifys").length;i++){
		$(".choose-classifys").eq(i).click(function(){
			$(".choose-one").hide();
			$(".choose-one").eq($(this).index()).show();
			if($(this).index()==0){
				tag=1;				
			}
			if($(this).index()==1){
				tag=2;
			}
		})
	}
	// 下拉框
	$(".change-name1").click(function(){
		$(".change-list1").toggle();
	});
	$(".change-list1 >li").click(function(){
		var Html=$(this).html();
		$(".change-name1").html(Html);
		$(".change-list1").hide();
		
	});
	$(".change-list1 >li").blur(function(){
		$(".change-list1").hide();
	});
	
	$('#bossSearch').on(
			'click',
			function() {
				var a=$("#changeName").find("p").html();
				$('#bossSearchCondition').val($('#forBossId').serialize());
				$('#bossId').load("filter/readCard/getBossDoor",
						$('#forBossId').serialize(), function() {
							$('.pagination>li>a').on('click', pageFunc);
						});
			})
			
			$('.reDatetimepicker').datetimepicker({
				lang: 'ch',
				timepicker: false,
				format: 'Y-m-d',
				formatDate: 'Y-m-d',
			});

});
