/*function checkAll( obj){
	var curCheckBox = document.getElementsByName("promotions");
	for(var i = 0; i < curCheckBox.length; i++){
	curCheckBox.item(i).checked = obj.checked;
	}
	}
$('#datetimepickerfrom').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
$('#datetimepickerto').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});

function findFourms(){
	var a = /^(\d{4})-(\d{2})-(\d{2})$/;
	var b=/^\d+$/;
	var fromtime=document.getElementById("datetimepickerfrom").value; //起始时间
	var totime=document.getElementById("datetimepickerto").value; //截止时间
	var username=document.getElementById("username").value; //用户名
	var companyname=document.getElementById("companyname").value;//公司名
	var status=document.getElementById("forumstatus").value; //帖子状态
	var types=document.getElementById("forumtype").value; //帖子类型
	var forumtitle=document.getElementById("forumtitle").value; //帖子标题
	if (fromtime!=null&&fromtime!=""&&totime!=null&&totime!=""&&!a.test(document.getElementById("datetimepickerfrom").value)&&!a.test(document.getElementById("datetimepickerto").value)) { 
		alert("日期格式不正确!"); 
		}else{
			$('#content').load("filter/forum/manageForum?fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types);
		} 
};*/

$(function(){
	$(".showuserBillcheck").on("click",function(){
		var userid=$(this).attr("userid");
		var billMonth=$(this).attr("billmonth");
		var companyId=$(this).attr("data-companyId");
		var flagsec=$(this).attr("data-flag");
		$('#content').load("filter/account/closePersonAccount?companyId="+companyId+"&billMonth="+billMonth+"&userId="+userid+"&flagsec="+flagsec);
	});
	
	$(".closePersonAccount").on("click",function(){
		var userid=$(this).attr("userid");
		var billMonth=$(this).attr("billmonth");
		var companyId=$(this).attr("data-companyId");
		var flagsec=0;
		$('#content').load("filter/account/closePersonAccount?companyId="+companyId+"&billMonth="+billMonth+"&userId="+userid+"&flagsec="+flagsec);

	});
	$(".closePersonAccountsec").on("click",function(){
		var userid=$(this).attr("userid");
		var billMonth=$(this).attr("billmonth");
		var companyId=$(this).attr("data-companyId");
		var flagsec=1;
		$('#content').load("filter/account/closePersonAccount?companyId="+companyId+"&billMonth="+billMonth+"&userId="+userid+"&flagsec="+flagsec);
	});
	$("#queryoneperson").on("click",function(){1111
		var companyId=$("#companyId option:selected").val();
		var fromtime=$("#datetimepickerfrom").val();
		var userPhone=$("#userPhone").val();//用户名
		$("#hiddenperson").val(companyId);
		$('#selectcomp').dialog('destroy');
		$.ajax({
			url:"filter/account/findcompanymenmber",
			dataType:"json",
			type:"POST",
			data:{
				"companyId":companyId,
				"userPhone":userPhone
			},cache:false,
			success:function(data){
				if(data.message=="true"){
					var departmentList4 = Handlebars.compile($("#userselect").html());
					$('#seleUserId').html(departmentList4(data.lists));
					$("#selcetcompuser").dialog({ modal:true,autoOpen: true,height:'auto', width:390,resizable:false,
						close:function(){
							$('#selcetcompuser').dialog('destroy');
						}});
				}else{
					$('#selcetcompuser').dialog('destroy');
					alert("结账失败");
				}
			},error : function(data) {
				
			}
		});
		
		
		//$('#content').load("filter/account/closePersonAccount?companyName="+encodeURI(companyName)+"&billMonth="+billMonth+"&userId="+userId);
	
	});
	$("#escqueryperson").on("click",function(){
		$('#selectcomp').dialog('destroy');
	});
	
	$("#queryuserId").on("click",function(){
		var companyId=$("#hiddenperson").val();
		var userId=$("#seleUserId option:selected").val();
		$('#selcetcompuser').dialog('destroy');
		$('#fourm_table').load("filter/account/showPersonAccountFir?companyId="+companyId+"&userId="+userId, function(){
		$('.pagination>li>a').on('click', pageFunc);
	});
	});
	$("#escuserId").on("click",function(){
		$('#selcetcompuser').dialog('destroy');
	});
})