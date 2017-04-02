var projectId=0;
var picType=0;

$(function(){
	$('#addProject').on('click',function(){
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:420,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});
		$('#projectName').val("");
		$('#citynameinput').val("");
		$('#address').val("");
		$('#name').val("");
		$('#desc').val("");
		$('#phone').val("");
		$('#projectid').val(0);
		$('#pname').hide();
		$('#citynamespan').hide();
		$('#addresspan').hide();
		$('#namespan').hide();
		$('#phonespan').hide();
		$('#descspan').hide();
		map.clearOverlays();
		map.centerAndZoom(new BMap.Point(121.351723,31.294898), 11);
	})

	$('#return').on('click',function(){
		$('#addPdialog').dialog('destroy');
	});

	$('.updatePro').on('click',function(){
		debugger
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:420,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});
		$('#projectName').val($(this).attr('data-projectname'));
		$('#citynameinput').val($(this).attr('data-cityname'));
		$('#address').val($(this).attr('data-address'));
		$('#name').val($(this).attr('data-name'));
		$('#phone').val($(this).attr('data-phone'));
		$('#projectid').val($(this).attr('data-projectid'));
		$('#desc').val($(this).attr('data-desc'));
		$('#pname').hide();
		$('#citynamespan').hide();
		$('#addresspan').hide();
		$('#namespan').hide();
		$('#phonespan').hide();
		$('#descspan').hide();
		plat=$(this).attr('data-lat');
		plng=$(this).attr('data-lng');
		var point = new BMap.Point(plng,plat);
		var marker = new BMap.Marker(point);  // 创建标注
		map.centerAndZoom(point, 15);
		map.clearOverlays();
		map.addOverlay(marker);
	});

	$('#formcheck').on('click',function(){
		var phone = $('#phone').val();
		var projectname = $('#projectName').val();
		var address = $('#address').val();
		var name = $('#name').val();
		var desc = $('#desc').val();
		var cityid = $('#cityid').val();
		var addflag = 0;
		if($.trim(address)==""){
			$('#addresspan').show();
			addflag = 1;
		}else{
			$('#addresspan').hide();
			addflag = 0
		}
		var nameflag = 0;
		if($.trim(name)==""){
			$('#namespan').show();
			nameflag = 1;
		}else{
			$('#namespan').hide();
			nameflag = 0;
		}
		var reg = /^1[0-9]{10}$/;
		var phflag = 0;
		if (!reg.test(phone)) {
			$('#phonespan').show();
			phflag = 1;
		}else{
			$('#phonespan').hide();
			phflag = 0;
		}
		var projectflag = 0
		if($.trim(projectname)==""){
			$('#pname').show();
			projectflag = 1;
		}else{
			$('#pname').hide();
			projectflag = 0;
		}
		var descNum = 0;
		if($.trim(desc)==""){
			$('#descspan').show();
			descNum = 1;
		}else{
			$('#descspan').hide();
			descNum =0;
		}
		var cityNum = 0;
		if(cityid==0){
			$('#citynamespan').show();
			cityNum = 1;
		}else{
			$('#citynamespan').hide();
			cityNum = 0;
		}
		if(projectflag==0&&phflag==0&&addflag==0&&nameflag==0&&descNum==0&&cityNum==0){
			$('#content').load("filter/project/saveOrupdateProject?projectname="+projectname+"&address="+address
			+"&phone="+phone+"&cityid="+cityid+"&lng="+plng+"&lat="+plat+"&projectid="+$('#projectid').val()+"&name="+name+"&desc="+desc
			+"&page="+$(this).attr('page'));
			$('#addPdialog').dialog('destroy');
		}
	})

	$('.deletePro').on('click',function(){
	    $('#content').load("filter/project/deletePro?projectid="+
		  $(this).attr('data-projectid')+"&page="+$(this).attr('data-page'));
	});

	$('#findproject').click(function(){
		var projectname = $('#findInput').val();
		if(projectname=="项目名称"||projectname==""){
			$('#textspan').show();
		}else{
			$('#projectable').load('filter/project/showPlace?page=0'+"&proname="+projectname);
			$('#textspan').hide();
		}
	});
	
	$('#findInput').on('focus',function(){
		$('#textspan').hide();
	})
	
	function showFileName(){
		var length = document.getElementById("files").files.length;
		for(var i=0;i<length;i++){
			var file = document.getElementById("files").files[i];
			$("#projectimg").val(file.name);
		}
	}
	$('#files').on('change', showFileName);
	
	$('.details').on('click',function(){
		debugger;
		var arr = $(this).attr('data-projectid') 
		$('#content').load('filter/project/details?&projectId='+arr);
	})
	
	$('#exportProject').click(function(){
		var projectName=$('#findInput').val();
		window.open("filter/exprot/exportProjectInfo?proname="+projectName);
	})
	
	$('.addmainPic').click(function(){
		//添加首页大图
		projectId=0;
		picType=1;
		$('.projectpic_url').find("li").remove();
		$('.upload_preview').html("");
		
		//获取原有图片列表
		$.ajax({
			url :"filter/project/findprojectPic",
			type : "POST",
			dataType : 'json',
			data : {type:1,projectId:0},
			success : function(data){
				if(data.length!=0){
					var str = "";
					for(var i=0;i<data.length;i++){
						str = "<li id=\"pic"+data[i].picId+"\"><img src="+data[i].photoUrl+"/>" +
								"<span class=\"file_del\" data-index=\"0\" data-id="+data[i].picId+" title=\"删除\"></span></li>"
						$('.projectpic_url').append(str);
					}
					$("#addProjectPic").dialog({ modal:true,autoOpen: true,height:'auto', width:670,resizable:false,
						close:function(){
							$('#addProjectPic').dialog('destroy');
						}});
				}else{
					alert("当前网络不好，请稍后重试！")
				}
			}
		})
	})
	
	$('.file_del').click(function(){
		var picId = $(this).attr('data-id');
		$.ajax({
			url :"filter/project/delprojectPic",
			type : "POST",
			dataType : 'json',
			data : {picId:picId},
			success : function(data){
				if(data="1"){
					alert("当前网络不好，请稍后重试！");
				}else{
					alert("删除成功！");
					$("#pic"+picId).remove();
				}
			}
		})
	})
	$('.addProPic').click(function(){
		//添加项目大图
		projectId=$(this).attr('data-projectid');
		picType=1;
		$('.projectpic_url').find("li").remove();
		$('.upload_preview').html("");
		//获取原有图片列表
		$.ajax({
			url :"filter/project/findprojectPic",
			type : "POST",
			dataType : 'json',
			data : {type:1,projectId:projectId},
			success : function(data){
				if(data.length!=0){
					var str = "";
					for(var i=0;i<data.length;i++){
						str = "<li id=\"pic"+data[i].picId+"\"><img src="+data[i].photoUrl+"/>" +
								"<span class=\"file_del\" data-index=\"0\" data-id="+data[i].picId+" title=\"删除\"></span></li>"
						$('.projectpic_url').append(str);
					}
					$('.file_del').click(function(){
						var picId = $(this).attr('data-id');
						$.ajax({
							url :"filter/project/delprojectPic",
							type : "POST",
							dataType : 'json',
							data : {picId:picId},
							success : function(data){
								if(data=="1"){
									alert("当前网络不好，请稍后重试！");
								}else{
									alert("删除成功！");
									$("#pic"+picId).remove();
								}
							}
						})
					})
					$("#addProjectPic").dialog({ modal:true,autoOpen: true,height:'auto', width:670,resizable:false,
						close:function(){
							$('#addProjectPic').dialog('destroy');
						}});
				}else{
					alert("当前网络不好，请稍后重试！")
				}
			}
		})
	})
	$('.addSmallProPic').click(function(){
		projectId=$(this).attr('data-projectid');
		picType=2;
		$('.projectpic_url').find("li").remove();
		$('.upload_preview').html("");
		$.ajax({
			url :"filter/project/findprojectPic",
			type : "POST",
			dataType : 'json',
			data : {type:2,projectId:projectId},
			success : function(data){
				if(data.length!=0){
					var str = "";
					for(var i=0;i<data.length;i++){
						str = "<li id=\"pic"+data[i].picId+"\"><img src="+data[i].photoUrl+"/>" +
								"<span class=\"file_del\" data-index=\"0\" data-id="+data[i].picId+" title=\"删除\"></span></li>"
						$('.projectpic_url').append(str);
					}
					$('.file_del').click(function(){
						var picId = $(this).attr('data-id');
						$.ajax({
							url :"filter/project/delprojectPic",
							type : "POST",
							dataType : 'json',
							data : {picId:picId},
							success : function(data){
								if(data=="1"){
									alert("系统繁忙，请稍后重试！");
								}else{
									alert("删除成功！");
									$("#pic"+picId).remove();
								}
							}
						})
					})
					$("#addProjectPic").dialog({ modal:true,autoOpen: true,height:'auto', width:670,resizable:false,
						close:function(){
							$('#addProjectPic').dialog('destroy');
						}});
				}else{
					alert("当前网络不好，请稍后重试！")
				}
			}
		})
		
	})
	$('#picreturn').click(function(){
		$('#addProjectPic').dialog('destroy');
	})
	
	$('#piccheck').click(function(){
		var picname = $('#projectimg').val();
		var name = picname.split(".");
		if(name[1]=="png"||name[1]=="jpg"){
			$('#projectpic').on('submit', function() {
				$(this).ajaxSubmit({
					type: 'post', // 提交方式 get/post
					url: 'filter/project/addprojectPic', // 需要提交的 url
					dataType:'json',
					async:false,
					data: JSON.stringify($('#projectpic').serializeArray()),
					success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
						if(data != 1) {
							var file = $("#files") 
							file.after(file.clone().val("")); 
							file.remove();
							$('#addProjectPic').dialog('destroy');
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
			$('#projectpic').submit();
		}else{
			alert("您选择的文件不合法！")
		}
	})
	
	findAllCity();
	downMenu("#citynameinput","#city_ul");
})

function findAllCity(){
	$.ajax({
		url :"filter/project/findAllCity",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			if(data.length!=0){
				var str = "";
				$('#project_ul').html(str);
				for(var i=0;i<data.length;i++){
					str = "<li data-id="+data[i].cityid+">"+data[i].cityname+"</li>"
					$('#city_ul').append(str);
				}
				$('.city_ul > li').click(function(){
					var name = $(this).html();
					var id = $(this).attr('data-id');
					$('#citynameinput').val(name);
					$('#cityid').val(id);
				})
			}else{
				alert("当前网络不好，请稍后重试！")
			}
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