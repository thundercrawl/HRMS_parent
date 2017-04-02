var pic = 0;
var meetingroomId;
$(function(){
	$('#formParam').val($('#meetingfrom').serialize());
	$('#addMeeting').click(function(){
		$("#addMdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:358,resizable:false,
			close:function(){
				$('#addMdialog').dialog('destroy');
			}});
		$('#meetingroomId').val('');
		$('#rank_select').val('');
		$('#rank_id').val('0');
		$('#houseNumber').val('');
		$('#floorInfo').val('');
		$('#areaInfo').val('');
		$('#capacity').val('');
		$('#description').val('');
		$('#select').val("");
		$('#flood').val("");
		$('#meetingarea').val('');
		$('#meetingid').val('0');
		$('#meetspan').hide();
		$('#rankimg').hide();
		$('#numberspan').hide();
		$('#floorspan').hide();
		$('#areaspan').hide();
		$('#descspan').hide();
		$('#Areatspan').hide();
		$('#capspan').hide();
		$('#proimg').hide();
		$('#floodimg').hide();
	})
	$('#return').on('click',function(){
		$('#addMdialog').dialog('destroy');
	});
	$('#formcheck').on('click',function(){
		var meetingroomId = $('#meetingroomId').val();
		var rank_select = $('#rank_id').val();
		//alert(rank_select);
		var houseNumber = $('#houseNumber').val();
		var floorInfo = $('#flood').val();
		var areaInfo = $('#areaInfo').val();
		var capacity = $('#capacity').val();
		var description = $('#description').val();
		var page = $('#page').val();
		var meetingid = $('#meetingid').val();
		var status = $('#status').val();
		var meetingarea = $('#meetingarea').val();
		var projectid = $('#projectid').val();
		var reg = /^\d+(\.\d{2})?$/ ;
		var mrflag=1;
		var rankflag=1;
		if(meetingroomId==""){
			$('#meetspan').show();
			mrflag = 1;
		}else{
			$('#meetspan').hide();
			mrflag = 0;
		}
		if(rank_select==0){
			$('#rankimg').show();
			rankflag = 1;
		}else{
			$('#rankimg').hide();
			rankflag = 0;
		}
		var hnflag = 1;
		if(houseNumber==""){
			$('#numberspan').show();
			hnflag = 1;
		}else{
			$('#numberspan').hide();
			hnflag = 0;
		}
		var fiflag=1;
		if(floorInfo==""||!reg.test(floorInfo)){
			$('#floodimg').show();
			fiflag = 1;
		}else{
			$('#floodimg').hide();
			fiflag = 0;
		}
		var aiflag = 1;
		if(areaInfo==""){
			$('#areaspan').show();
			aiflag = 1;
		}else{
			$('#areaspan').hide();
			aiflag = 0;
		}
		var cpflag = 1;
		if(capacity==""||!reg.test(capacity)){
			$('#capspan').show();
			cpflag = 1;
		}else{
			$('#capspan').hide();
			cpflag = 0;
		}
		var dcflag = 1;
		if(description==""){
			$('#descspan').show();
			dcflag = 1;
		}else{
			$('#descspan').hide();
			dcflag = 0;
		}
		var maflag = 1;
		if(!reg.test(meetingarea)){
			$('#Areatspan').show();
			maflag=1;
		}else{
			$('#Areatspan').hide();
			maflag=0;
		}
		var proNum = 0;
		if(projectid==0){
			$('#proimg').show();
			proNum = 1;
		}else{
			$('#proimg').hide();
			proNum = 0;
		}
		if(mrflag==0&&hnflag==0&&fiflag==0&&aiflag==0&&cpflag==0&&dcflag==0&&maflag==0&&proNum==0&&rankflag==0){
			$('#content').load("filter/project/addMeeting?meetingid="+meetingid+"&houseNum="+houseNumber+
					"&flood="+floorInfo+"&areainfo="+areaInfo+"&content="+capacity+"&desc="+description+"&page="+page+
					"&meetingname="+meetingroomId+"&status="+status+"&projectid="+projectid+"&meetingarea="+meetingarea
					+"&rankSelect="+rank_select,
					function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
			$('#addMdialog').dialog('destroy');
		}
	})
	$('.updateMeeting').click(function(){
		$("#addMdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:358,resizable:false,
			close:function(){
				$('#addMdialog').dialog('destroy');
			}});
		$('#meetingroomId').val($(this).attr('data-rname'));
		$('#rank_id').val($(this).attr('data-rankId'));
		$('#rank_select').val($(this).attr('data-rankDescribe'));
		
		$('#houseNumber').val($(this).attr('data-hn'));
		$('#flood').val($(this).attr('data-finfo'));
		$('#areaInfo').val($(this).attr('data-ainfo'));
		$('#capacity').val($(this).attr('data-cap'));
		$('#description').val($(this).attr('data-desc'));
		$('#status').val($(this).attr('data-status'));
		$('#meetingid').val($(this).attr('data-meetingid'));
		$('#meetingarea').val($(this).attr('area'));
		$('#projectid').val($(this).attr('projectid'));
		$('#select').val($(this).attr('projectname'));
		$('#rankimg').hide();
		$('#meetspan').hide();
		$('#numberspan').hide();
		$('#floorspan').hide();
		$('#areaspan').hide();
		$('#descspan').hide();
		$('#Areatspan').hide();
		$('#capspan').hide();
		$('#proimg').hide();
		$('#floodimg').hide();
	})
	$('.delete').click(function(){
		if(confirm("确认删除？")){
			$.ajax({
				url :"filter/project/deleteMeetingAjax",
				type : "POST",
				dataType : 'json',
				data : {
					meetingid:$(this).attr('data-id'),
					status:$(this).attr('data-status'),
					page:$(this).attr('page'),
					projectid:$('#projectid').val()},
			    	success : function(data){
					if(data.status=='1'){
						var projectid = data.data.projectid;
						$('#projectable_meet').load("filter/project/deleteMeetingLoad?"+
								"status="+data.data.status+"&page="+data.data.page+"&projectid="+projectid,
								function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
						/*var projectid = $('#findprojectid').val();
						$('#projectable_meet').load("filter/project/deleteMeetingLoad?"+
								"status="+$(this).attr('data-status')+"&page="+$(this).attr('page')+"&projectid="+projectid,
								function(){
							$('.pagination>li>a').on('click', pageFunc);
						});*/
					}else{
						alert(data.message);
					}
				}
			})
		}
		
	})

	$('#rname').focus(function(){
		$('#textspan').hide();
	})
	
/*-----------------------------------------------------*/
	function showFileName(){
		var length = document.getElementById("files").files.length;
		for(var i=0;i<length;i++){
			var file = document.getElementById("files").files[i];
			$("#projectimg").val(file.name);
		}
	}
	$('#files').on('change', showFileName);
		    

  showRank();
  $('.addMeetingPic').click(function(){
		$("#addmeetingPic").dialog({ modal:true,autoOpen: true,height:'auto', width:355,resizable:false,
			close:function(){
				 document.getElementByIdx("imgFile").outerHTML = '  <input type="file" id="files" name="imgFile" style="width:262px;height:37px;opacity: 0;z-index:999;position: absolute;left: 22%;top:10px;" >' ;  
				$('#addmeetingPic').dialog('destroy');
			}});
	})
	
	$('#returnpic').click(function(){
		$('#addmeetingPic').dialog('destroy');
	})
	
   $('#formPic').click(function(){
	  var picname = $('#projectimg').val();
		var name = picname.split(".");
		if(name[1]=="png"||name[1]=="jpg"){
			$('#Meetingform').on('submit', function() {
				$(this).ajaxSubmit({
					type: 'post', // 提交方式 get/post
					url: 'filter/project/addmeetingPic', // 需要提交的 url
					dataType:'json',
					async:false,
					data: JSON.stringify($('#Meetingform').serializeArray()),
					success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
						if(data != 1) {
							var file = $("#files") 
							file.after(file.clone().val("")); 
							file.remove();
							$(".alert-mask").hide();
							$("#prpjectpic").hide();
							alert("保存成功")
						} else {
						    alert("保存失败")	
						}
					}, 
					error: function(){
						alert("当前网络有问题,请稍后重试!")
					}
				});
				return false; // 阻止表单自动提交事件
			});
			$('#Meetingform').submit();
		}else{
			alert("您选择的文件不合法！")
		}
  })
  /*-----------------*/

	downMenu("#flood","#flood_ul");

  downMenu("#rank_select", "#rank_select_url");
  $("#flood").click(function(){
		if($("#flood").val()==""&&$("#select").val()==""){
			$("#flood_ul").hide();
			alert("请先选择项目")
		}
		$("#select_ul").hide();
	});
	$("#rank_select").click(function(){
		$("#rank_select_url").hide();
	});
})


function showRank(){
	$.ajax({
		url :"filter/project/selectAssetRank",
		type : "POST",
		dataType : 'json',
		data : {assetName:'会议室'},
		success : function(data){
			var str2 = "";
			$('#rank_select_url').html(str2);
			for(var i=0;i<data.length;i++){
				str2 = "<li data-id="+data[i].rankId+">"+data[i].rankDescribe+"</li>";
				$('#rank_select_url').append(str2);
			}
			$("#rank_select_url > li").click(function(){
				$('#rank_select').val($(this).text());
				$('#rank_id').val($(this).attr('data-id'));
			})
			downMenu("#rank_select", "#rank_select_url");
			
		}
	})
}

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

function lock(assetid,lockstatus){
	var btnvalue=$('#lock-'+assetid).val();
	if(btnvalue=="锁定"){
	$.ajax({
		url : 'filter/project/lock',
		type : 'POST',
		data : {
			assetid : assetid,
			type: 2
		},
		cache : false,
		dataType : 'json',
		success : function(data) {
			if(data.result=="success"){
				alert("锁定成功")
				$('#lock-'+assetid).val("解锁");
			}else if(data.result=="notFind"){
				alert("资产不存在")
			}else{
				alert("锁定失败")
			}
		},
		error : function(data) {
			alert(error);
		}
	});
	}else if(btnvalue=="解锁"){
		$.ajax({
			url : 'filter/project/unlock',
			type : 'POST',
			data : {
				assetid : assetid,
				type: 2
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				if(data.result=="success"){
					alert("解锁成功")
					$('#lock-'+assetid).val("锁定");
				}else{
					alert("解锁失败")
				}
			},
			error : function(data) {
				alert(error);
			}
		});
		}
}