$(function(){
//置为水贴、取消水贴事件
$('.change_forum').on('click',function(){
	var a = /^(\d{4})-(\d{2})-(\d{2})$/;
	var fromtime=document.getElementById("datetimepickerfrom").value; //起始时间
	var totime=document.getElementById("datetimepickerto").value; //截止时间
	var username=document.getElementById("username").value; //用户名
	var companyname=document.getElementById("companyname").value;//公司名
	var status=document.getElementById("forumstatus").value; //帖子状态
	var types=document.getElementById("forumtype").value; //帖子类型
	var forumtitle=document.getElementById("forumtitle").value; //帖子标题
	var forumId = $(this).attr('orderid');
	var page = $(this).attr('page');
	var confirms = confirm("确定置为水帖？");
	if(confirms==true){
		if (fromtime!=null&&fromtime!=""&&totime!=null&&totime!=""&&!a.test(document.getElementById("datetimepickerfrom").value)&&!a.test(document.getElementById("datetimepickerto").value)) { 
			alert("日期格式不正确!"); 
			}else{
				$('#content').load('filter/forum/change_forum?forumId='+forumId+'&cannotDel=0&page='+page+"&fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types);
			} 
	}
});

$('.cancel_change_forum').on('click',function(){
	var a = /^(\d{4})-(\d{2})-(\d{2})$/;
	var fromtime=document.getElementById("datetimepickerfrom").value; //起始时间
	var totime=document.getElementById("datetimepickerto").value; //截止时间
	var username=document.getElementById("username").value; //用户名
	var companyname=document.getElementById("companyname").value;//公司名
	var status=document.getElementById("forumstatus").value; //帖子状态
	var types=document.getElementById("forumtype").value; //帖子类型
	var forumtitle=document.getElementById("forumtitle").value; //帖子标题
	var forumId = $(this).attr('orderid');
//	var cannotdel = $(this).attr('cannotdel');
	var page = $(this).attr('page');
	var confirms = confirm("确定置为正常帖？");
	if(confirms==true){
		if (fromtime!=null&&fromtime!=""&&totime!=null&&totime!=""&&!a.test(document.getElementById("datetimepickerfrom").value)&&!a.test(document.getElementById("datetimepickerto").value)) { 
			alert("日期格式不正确!"); 
			}else{
				$('#content').load('filter/forum/change_forum?forumId='+forumId+'&cannotDel=1&page='+page+"&fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types);
			} 
	}
});
//删除帖子
$('.delete_forum').on('click',function(){
	var fromtime=document.getElementById("datetimepickerfrom").value; //起始时间
	var totime=document.getElementById("datetimepickerto").value; //截止时间
	var username=document.getElementById("username").value; //用户名
	var companyname=document.getElementById("companyname").value;//公司名
	var status=document.getElementById("forumstatus").value; //帖子状态
	var types=document.getElementById("forumtype").value; //帖子类型
	var forumtitle=document.getElementById("forumtitle").value; //帖子标题
	var forumId=$(this).attr("orderid");
	var page=$(this).attr('page');
	var confirms = confirm("确定删除本帖？");
	if(confirms==true){
		$('#content').load('filter/forum/deleteforum?forumId='+forumId+'&cannotDel=0&page='+page+"&fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types);
	}

	
});
$('.is_topforum').on('click',function(){
	var fromtime=document.getElementById("datetimepickerfrom").value; //起始时间
	var totime=document.getElementById("datetimepickerto").value; //截止时间
	var username=document.getElementById("username").value; //用户名
	var companyname=document.getElementById("companyname").value;//公司名
	var status=document.getElementById("forumstatus").value; //帖子状态
	var types=document.getElementById("forumtype").value; //帖子类型
	var forumtitle=document.getElementById("forumtitle").value; //帖子标题
	var forumId=$(this).attr("orderid");
	var page=$(this).attr('page');
	$('#content').load('filter/forum/istopforum?forumId='+forumId+'&cannotDel=0&page='+page+"&fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types);

	
});
$('.not_topforum').on('click',function(){
	var fromtime=document.getElementById("datetimepickerfrom").value; //起始时间
	var totime=document.getElementById("datetimepickerto").value; //截止时间
	var username=document.getElementById("username").value; //用户名
	var companyname=document.getElementById("companyname").value;//公司名
	var status=document.getElementById("forumstatus").value; //帖子状态
	var types=document.getElementById("forumtype").value; //帖子类型
	var forumtitle=document.getElementById("forumtitle").value; //帖子标题
	var forumId=$(this).attr("orderid");
	var page=$(this).attr('page');
	$('#content').load('filter/forum/nottopforum?forumId='+forumId+'&cannotDel=0&page='+page+"&fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types);
	
});
$('.modify_forum').on('click',function(){
	var forumId=$(this).attr("orderid");
	$('#content').load('filter/forum/modifyforum?forumId='+forumId);
	
});
$('.forum_detail').on('click',function(){
	var fromtime=document.getElementById("datetimepickerfrom").value; //起始时间
	var totime=document.getElementById("datetimepickerto").value; //截止时间
	var username=document.getElementById("username").value; //用户名
	var companyname=document.getElementById("companyname").value;//公司名
	var status=document.getElementById("forumstatus").value; //帖子状态
	var types=document.getElementById("forumtype").value; //帖子类型
	var forumtitle=document.getElementById("forumtitle").value; //帖子标题
	var page=$(this).attr('page');
	var forumId=$(this).attr("orderid");
	$('#content').load('filter/forum/forumdetail?forumId='+forumId+'&cannotDel=0&page='+page+"&fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+types);
	
});

});