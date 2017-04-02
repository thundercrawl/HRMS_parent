$(function() {
	$('#formParam').val($('#usergroup').serialize());
	$('#addUser').on('click', function() {
		$("#addUserdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 344,
			resizable : false,
			close : function() {
				$('#addUserdialog').dialog('destroy');
			}
		});
		$('#contactName').val('');
		$('#companyName').val('');
		$('#contactPhone').val('');
		$('#contactEmail').val('');
		$('#contactAddress').val('');
		$('#typeMessage').val('账单联系人');
		$('#statusMessage').val('');
		$('#contactId').val(0);

		$('#unamespan').hide();
		$('#companyspan').hide();
		$('#dressspan').hide();
		$('#phonespan').hide();
		$('#emailspan').hide();
	})

	$('#return').on('click', function() {
		$('#addUserdialog').dialog('destroy');
	})
	$("body").delegate(".updatePro", "click", function() {
		$("#updateUserdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 344,
			resizable : false,
			close : function() {
				$('#updateUserdialog').dialog('destroy');
			}
		});
		$('#UserName').val($(this).attr('data-contactName'));
		$('#Phone').val($(this).attr('data-contactPhone'));
		$('#Email').val($(this).attr('data-contactEmail'));
		$('#Address').val($(this).attr('data-contactAddress'));
		$('#companyIds').val($(this).attr('data-companyId'));
		$('#contactIds').val($(this).attr('data-contactId'));
		$('#types').val($(this).attr('data-type'));
	})
	$('#returnUser').on('click', function() {
		$('#updateUserdialog').dialog('destroy');
	})
	$('#formcheck').on(
			'click',
			function() {
				debugger;
				var username = $('#username').val();
				var companyId = $('#companyId').val();
				var dress = $('#dress').val();
				var phone = $('#phone').val();
				var email = $('#email').val();
				var typess = $('#typess').val();
				var type = $('#type').val();
				var N = $('#contactUserName').val();
				var P = $('#contactUserPhone').val();
				var E = $('#contactUserEmail').val();
				var C = $('#contactCompanyName').val();

				var page = $('#page').val();
				var name = 0;

				if (username.trim() == "") {
					$('#unamespan').show();
					name = 0;
				} else {
					$('#unamespan').hide();
					name = 1;
				}

				var phflag = 0;
				var ph = /^(1[0-9]{10})$/;
				if (!ph.test(phone)) {
					$('#phonespan').show();
					phflag = 0;
				} else {
					$('#phonespan').hide();
					phflag = 1;
				}

				var em = 1;
				if (email.trim() != "") {
					var emails = /\w@\w*\.\w/;
					if (!emails.test(email)) {
						$('#emailspan').show();
						em = 0;
					} else {
						$('#emailspan').hide();
						em = 1;
					}
				}

				if (phflag == 1 && em == 1 && name == 1) {
					var cc = "filter/secContact/saveContact?contactName="
							+ username + "&companyId=" + companyId
							+ "&contactAddress=" + dress + "&phone=" + phone
							+ "&eMail=" + email + "&type=" + typess + "&page="
							+ page + "&STYPE=" + type + "&N=" + N + "&P=" + P
							+ "&E=" + E + "&C=" + C;
					while (cc.indexOf(" ") != -1) {
						cc = cc.replace(" ", "+");
					}
					console.log(cc);
					$('#content').load(cc);
					$('#addUserdialog').dialog('destroy');
				}
			})
	$('.deleteUser').click(function(){
		var N = $('#contactUserName').val();
		var P = $('#contactUserPhone').val();
		var E = $('#contactUserEmail').val();
		var C = $('#contactCompanyName').val();
		var T = $('#type').val();
		$('#content').load('filter/secContact/changeContactStatus?contactId='
								+ $(this).attr('data-contactId')
								+ "&page=" + $(this).attr('data-page')
								+ "&status="
								+ $(this).attr('data-status') + "&N="
								+ N + "&P=" + P + "&E=" + E + "&C=" + C
								+ "&T=" + T);
	});
	/*$("body").delegate(
			".deleteUser",
			"click",
			function() {
				debugger;
				var N = $('#contactUserName').val();
				var P = $('#contactUserPhone').val();
				var E = $('#contactUserEmail').val();
				var C = $('#contactCompanyName').val();
				var T = $('#type').val();
				$('#content')
						.load(
								'filter/secContact/changeContactStatus?contactId='
										+ $(this).attr('data-contactId')
										+ "&page=" + $(this).attr('data-page')
										+ "&status="
										+ $(this).attr('data-status') + "&N="
										+ N + "&P=" + P + "&E=" + E + "&C=" + C
										+ "&T=" + T);
			})
*/
	$('#findproject').click(
			function() {
				var username = $('#contactUserName').val();
				$('#formParam').val($('#usergroup').serialize());
				$('#projectable').load("filter/secContact/findContact",
						$('#usergroup').serialize(), function() {
							$('.pagination>li>a').on('click', pageFunc);
						});
				$('#textspan').hide();
			})
	$('#userName').on('focus', function() {
		$('#textspan').hide();
	})

	$('#updateUser').on(
			'click',
			function() {
				debugger;
				var username = $('#UserName').val();
				var phone = $('#Phone').val();
				var email = $('#Email').val();
				var address = $('#Address').val();
				var contactId = $('#contactIds').val();
				var companyId = $('#companyIds').val();
				var types = $('#types').val();
				var type = $('#type').val();
				var page = $('#pages').val();
				var name = 0;
				var N = $('#contactUserName').val();
				var P = $('#contactUserPhone').val();
				var E = $('#contactUserEmail').val();
				var C = $('#contactCompanyName').val();

				if (username.trim() == "") {
					$('#Unamespan').show();
					name = 0;
				} else {
					$('#Unamespan').hide();
					name = 1;
				}
				var phflag = 0;
				var ph = /^(1[0-9]{10})$/;
				if (!ph.test(phone)) {
					$('#Phonespan').show();
					phflag = 0;
				} else {
					$('#Phonespan').hide();
					phflag = 1;
				}

				var em = 1;
				if (email.trim() != "") {
					var emails = /\w@\w*\.\w/;
					if (!emails.test(email)) {
						$('#Emailspan').show();
						em = 0;
					} else {
						$('#Emailspan').hide();
						em = 1;
					}
				}

				if (phflag == 1 && em == 1 && name == 1) {
					var cc = 'filter/secContact/updateContact?contactName='
							+ username + "&contactAddress=" + address
							+ "&phone=" + phone + "&eMail=" + email
							+ "&contactId=" + contactId + "&page=" + page
							+ "&companyId=" + companyId + "&type=" + types
							+ "&STYPE=" + type + "&N=" + N + "&P=" + P + "&E="
							+ E + "&C=" + C;
					while (cc.indexOf(" ") != -1) {
						cc = cc.replace(" ", "+");
					}
					console.log(cc);
					$('#content').load(cc);
					$('#updateUserdialog').dialog('destroy');
				}
			})

	$("body").delegate(".adduserorg", "click", function() {
		$("#orgdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 344,
			resizable : false,
			close : function() {
				$('#orgdialog').dialog('destroy');
			}
		});
		$('#olderorgid').val($(this).attr('data-orgid'));
		$('#userorgid').val($(this).attr('data-userid'));
	})
})

function downMenu(clickClass, dropMenu) {
	$(clickClass).click(function(event) {
		event = event || window.event;
		event.stopPropagation();
		$(dropMenu).toggle();
	});
	$(dropMenu).click(function() {
		$(dropMenu).toggle();
	});
	$(document).click(function(e) {
		$(dropMenu).hide();
	});
}
