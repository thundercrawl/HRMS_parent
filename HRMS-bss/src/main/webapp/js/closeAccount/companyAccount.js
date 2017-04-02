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