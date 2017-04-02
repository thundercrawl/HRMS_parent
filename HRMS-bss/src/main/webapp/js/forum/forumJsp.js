showscene();
$("#testtest").click(function(){
	$('#testtest').hide();
	$('#testtest1').show();
});
$('.sendScene').click(function(){
	var forumId=$("#fonumId").val();
	var content = $('#editor1').val();
	var title = $('#title').val();
	var type = $('#type').val();
	var status = $(this).attr('status');
	var typeid = $('#typeid').val();
//	var cannotDel = $('#cannotDelid').val();
//	var cannotDelid = $('#cannotDel').val();
//	var boardid = $('#boardid').val();
	var timeinfo = $('#timeInfo').val();
	var istop = $('#istop').val();
	var startTime = '';
	var endTime = '';
	var address = '';
	var hold = '';
	var peoplecount = 0;
	var str ="";
	var strId="";
	var picurl = "";
	var flag = 0 ;
	var checkselect = 0;
	if(title == undefined || title.trim()==""){
		alert("帖子标题不能为空！");
		$('#title').focus();
		return ;
	}
//	if(type!="帖子类型"&&type!=""&&cannotDelid!=""&&cannotDelid!="帖子标志"){
	if(type!="帖子类型"&&type!=""){
		if(type=="社区活动"){
			startTime = $('#datetimepickerfrom').val();
			endTime = $('#date').val();
			address = $('#address').val();
			hold = $('#hold').val();
			peoplecount = $('#peoplecount').val();
			var picname = $('#file').val();
			var name = picname.split(".");
			if(startTime > endTime) {
				alert("活动开始时间不能大于结束时间！");
				return;
			}
			if(picname.length>0){
				if(name[1]=="png"||name[1]=="jpg"){
					$('#actpic').on('submit', function() {
						$(this).ajaxSubmit({
							type: 'post', // 提交方式 get/post
							url: "filter/forum/saveActivityPic", // 需要提交的 url
							dataType:'json',
							async:false,
							data: JSON.stringify($('#actpic').serializeArray()),
							success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
								picurl = data[0];
							}, 
							error: function(){
								alert("当前网络有问题,请稍后重试!");
							}
						});
						return false; // 阻止表单自动提交事件
					});
					$('#actpic').submit();
				}else{

					alert("您选择的文件不合法，请选择正确的文件！");
					return;

				}
			}else{
				if(forumId.length>0){
					var picurl_id=$("#picurl_id").val();
					picurl=picurl_id;
				}else{
					alert("您选择的文件不合法，请选择正确的文件！");
					return;
				}
			}
			var Num = /^\d+$/;
			if(!Num.test(peoplecount)||startTime==""||startTime==null||endTime==""||endTime==null){
				flag = 1;

			}else{
				flag = 0;    
				if(picurl==""&&forumId.length==0)
					flag = 1;   
			}
		}
		if(type=="投票贴"){
			for(var i=0;i<$(".select_l").length;i++){
				strId+=$(".select_l").eq(i).attr('data-touid')+"|";
				str+=$(".select_l").eq(i).val()+";";
				if(($(".select_l").eq(i).val()).trim()==""){
					checkselect++;
				}
			}
			if(title.trim()==""){
				checkselect++;
			}
		}
		if(flag==0&&checkselect==0){
			if(forumId.length>0){
				var picId=$(this).attr("data-picId");
				var activiId=$(this).attr("data-activeId");
				$('#content').load('filter/forum/updateforum?forumId='+forumId+'&title='+encodeURI(title)+'&peoplecount='+peoplecount+"&boardid="+1+'&type='+typeid+'&content='+encodeURI(content)+
						'&status='+status+'&statrTime='+startTime+'&endTime='+endTime+'&address='+encodeURI(address)+
						'&hold='+hold+'&str='+encodeURI(str)+'&cannotDel='+
						1+'&timeInfo='+timeinfo+'&istop='+istop+'&picurl='+picurl+'&strId='+strId+'&picId='+picId+"&activiId="+activiId);
			}else{
				$('#content').load('filter/forum/postForum?title='+encodeURI(title)+'&peoplecount='+peoplecount+"&boardid="+1+'&type='+typeid+'&content='+encodeURI(content)+
						'&status='+status+'&statrTime='+startTime+'&endTime='+endTime+'&address='+encodeURI(address)+
						'&hold='+hold+'&str='+encodeURI(str)+'&cannotDel='+
						1+'&timeInfo='+timeinfo+'&istop='+istop+'&picurl='+picurl);
			}
			$('#Scene_t').hide();
		}
	}else{
		alert('请输入帖子的类型或有选项为空哦!');
	}
});
$('#lookScene').on('click',function(){
	var typeid = $('#typeid').val();
	var content = $('#editor1').val();
	var title = $('#title').val();
	var type = $('#type').val();
	if(typeid==3){
		var startTime = $('#datetimepickerfrom').val();
		var endTime = $('#date').val();
		var address = $('#address').val();
		var	hold = $('#hold').val();
		var peoplecount = $('#peoplecount').val();
		$('#activityScene').dialog({ modal:true,autoOpen: true,height:'auto', width:700,resizable:false,
			close:function(){
				$('#activityScene').dialog('destroy');
			}});
		var stime = startTime.split('-');
		var etime = endTime.split('-');
		$('.date-number').html(stime[2]);
		$('.date-date').html(stime[0]+"年"+stime[1]+"月");
		$('.lecture').html(title);
		$('.poster').html(content);
		$('#Stime').html("时间："+stime[0]+"年"+stime[1]+"月"+stime[2]+"日~"+
				etime[0]+"年"+etime[1]+"月"+etime[2]+"日");
		$('#Saddress').html('地址：'+address);
		$('#Shold').html('发起人：'+hold);
		$('.people-number').html('人数：'+peoplecount);
	}
	if(typeid==1||typeid==2){
		var str ="";
		var select = "<input type=\"radio\">";
		if(type=="投票贴"){
			for(var i=0;i<$(".select_l").length;i++){
				str+= select+$(".select_l").eq(i).val();
			}
		}
		$('#stitle').html(title);
		$('#scontent').html(content+str);
		$('#stype').html(type);
		$('#myScene').dialog({ modal:true,autoOpen: true,height:'auto', width:344,resizable:false,
			close:function(){
				$('#myScene').dialog('destroy');
			}});
	}
});

$('#peoplecount').on('blur',function(){
	var peoplecounts = $('#peoplecount').val();
	var Num = /^\d+$/;
	if(!Num.test(peoplecounts)){
		$('#countspan').show();
	}
});
$('#peoplecount').on('focus',function(){
	$('#countspan').hide();
});
downMenu("#type","#zt-drow");
downMenu("#cannotDel","#cannotDel_ul");
downMenu("#Top","#idtop_ul");
$('#cannotDel_ul > li').click(function(){
	var id = $(this).attr('dataid');
	var text = $(this).text();
	$('#cannotDel').val(text);
	$('#cannotDelid').val(id);
});
$('#idtop_ul > li').click(function(){
	var id = $(this).attr('dataid');
	var text = $(this).text();
	$('#Top').val(text);
	$('#istop').val(id);
});
function showscene(){
	$("#editor1").text($("#textarea_con").val());
	var forumType_f=$("#forumType_f").val();
	var forumTypeName_f=$("#forumTypeName_f").val();
	$.ajax({
		url :"filter/forum/showForum",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			var firstLi = data.length > 0 ? data[0].typeNum : '';
			var firstLiText = data.length > 0 ? data[0].typeValue : '';
			var activityLi = '';
			for(var i=0;i<data.length;i++){
				str="<li data-id="+data[i].typeNum+">"+data[i].typeValue+"</li>";
				$('#zt-drow').append(str);

				if(forumType_f.length>0&&forumTypeName_f.length>0){
					activityLi=forumType_f;
				}else{
					if(data[i].typeValue == '社区活动') {
						activityLi = data[i].typeNum;
					}
				}
			}
			if(forumType_f.length>0&&forumTypeName_f.length>0){
				$('#typeid').val(activityLi == '' ? firstLi : activityLi);
				$('#type').val(activityLi == '' ? firstLiText : forumTypeName_f);
			}else{
				$('#typeid').val(activityLi == '' ? firstLi : activityLi);
				$('#type').val(activityLi == '' ? firstLiText : '社区活动');
			}
			typeid = $('#typeid').val();
			if(typeid=="2"){
				$('#Scene_t').show();
				$('#activity').hide();
			}else if(typeid=="3"){
				$('#Scene_t').hide();
				$('#activity').show();
			}else{
				$('#Scene_t').hide();
				$('#activity').hide();
			}
			$('#zt-drow > li').on('click',function(){
				var text = $(this).text();
				var typeid = $(this).attr('data-id');
				$('#type').val(text);
				$('#typeid').val(typeid);
				if(typeid=="2"){
					$('#Scene_t').show();
					$('#activity').hide();
				}else if(typeid=="3"){
					$('#Scene_t').hide();
					$('#activity').show();
				}else{
					$('#Scene_t').hide();
					$('#activity').hide();
				}

			});
		},
	});
}
var flag=3;
var forumId1=$("#fonumId").val();
if(forumId1.length>0){
	flag=parseInt($("#votesize").val())+1;
}
$('#addSelect').on('click',function(){
	var str = "<li style=\"float: left;padding: 0 10px;\"><label style=\"margin-right: 10px;font-weight: normal;\">选项"+flag+"<input type=\"text\" class=\"select_l\"></label></li>";
	if(flag<=10){
		$('#Scene_select').append(str);
	}
	flag++;
});
$('#datetimepickerfrom').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});;
$('#date').datetimepicker({
	lang: 'ch',
	timepicker: false,
	format: 'Y-m-d',
	formatDate: 'Y-m-d',
});
function downMenu(clickClass,dropMenu){
	$(clickClass).click(function(event){
		event=event||window.event;
		event.stopPropagation();
		$(dropMenu).toggle();
	});
	$(dropMenu).click(function(){
		$(dropMenu).toggle();
	});
	$(document).click(function(e){
		$(dropMenu).hide();
	});
}
/*---------------------------*/
function showFileName(){
	var length = document.getElementById("file").files.length;
	for(var i=0;i<length;i++){
		var file = document.getElementById("file").files[i];
		$("#activitys").val(file.name);
	}
}
$(function(){
	$('#file').on('change',function(){
		showFileName();
	});
	/*-----------帖子详情返回--------------*/
	$(".returnforum").on('click',function(){
		var page=$(this).attr("data-page");
		var forumtitle=$(this).attr("data-forumtitle");
		var username=$(this).attr("data-username");
		var companyname=$(this).attr("data-companyname");
		var fromtime=$(this).attr("data-fromtime");
		var totime=$(this).attr("data-totime");
		var status=$(this).attr("data-status");
		var type=$(this).attr("data-type");
		$('#content').load('filter/forum/returnforum?page='+page+"&fourmtitle="+encodeURI(forumtitle)+"&username="+encodeURI(username)+"&companyname="+encodeURI(companyname)+"&fromtime="+fromtime+"&totime="+totime+"&status="+status+"&type="+type);
	});
});
/*---------------------------*/


