$(function(){
	$('#formParam').val($('#powerform').serialize());
	$('#addPower').on('click',function(){
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:367,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});
		$('#powername').val('');
		$('#desc').val('');
		$('#Fpowername').val('')
		$('#status').val('0');
		$('#powerid').val('0');
	})

	$('#return').on('click',function(){
		$('#addPdialog').dialog('destroy');
	})

	$('.updatePower').on('click',function(){
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:367,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});
		$('#powername').val($(this).attr('powername'));
		$('#desc').val($(this).attr('desc'));
		$('#Fpowername').val($(this).attr('fname'))
		$('#status').val($(this).attr('status'));
		$('#powerid').val($(this).attr('powerid'));
	})

	$('#formcheck').on('click',function(){
		var powername = $('#powername').val();
		var desc = $('#desc').val();
		var Fpowername = $('#Fpowername').val()
		var Fpowerid = $('#fpowerid').val()
		var powerid = $('#powerid').val();
		var page = $('#page').val();
		var pname = 0;
		if(powername.trim()==""){
			$('#Pspan').style = "18px";
			$('#Pspan').html('X');
			$('#Pspan').css("color","red");
			pname = 0;
		}else{
			$('#Pspan').style = "18px";
			$('#Pspan').html('');
			$('#Pspan').css("color","green");
			pname = 1;
		}
		var des=0;
		if(desc.trim()==""){
			$('#descspan').style = "18px";
			$('#descspan').html('X');
			$('#descspan').css("color","red");
			des = 0;
		}else{
			$('#descspan').style = "18px";
			$('#descspan').html('');
			$('#descspan').css("color","green");
			des = 1;
		}
		if(pname==1&&des==1){
			if(Fpowername==""){
				var confim = confirm("您确定设置此权限为父权限？");
				if(confim==true){
					$('#content').load('filter/bssuser/saveOrupdatePower?powername='+encodeURI(powername)+"&desc="+encodeURI(desc)+
							"&Fpowername="+Fpowerid+"&powerid="+powerid+"&page="+page);
					$('#addPdialog').dialog('destroy');
				}
			}else{
				$('#content').load('filter/bssuser/saveOrupdatePower?powername='+encodeURI(powername)+"&desc="+encodeURI(desc)+
						"&Fpowername="+Fpowerid+"&powerid="+powerid+"&page="+page);
				$('#addPdialog').dialog('destroy');
			}
		}
	})

	$('.deletePower').on('click',function(){
		$('#content').load('filter/bssuser/detelePower?powerid='+$(this).attr('powerid')+"&page="+$(this).attr('data-page')+
				"&status="+$(this).attr('status'));
	})

	$('#findPower').on('click',function(){
		var orgname = $('#powerName').val();
		if(orgname==""||orgname=="权限名称"){
			$('#textspan').show();
		}else{
			$('#textspan').hide();
			$('#formParam').val($('#powerform').serialize());
			$('#projectable').load("filter/bssuser/findPower",$('#powerform').serialize(), function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
		}
	})

	$('#powerName').on('focus',function(){
		$('#textspan').hide();
	})
	findallPower();
	downMenu("#Fpowername","#project_ul");
})
function findallPower(){
	$.ajax({
		url :"filter/bssuser/showallPower",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			$('#project_ul').html(str);
			$('#project_ul').html("<li style='color:red' poerid='0'>设置为父权限</li>");
			for(var i=0;i<data.length;i++){
				str = "<li poerid="+data[i].powerid+">"+data[i].powerName+"</li>";
				$('#project_ul').append(str);
			}
			$('.power_ul > li').click(function(){
				downMenu("#fpowerid","#project_ul");
				$('#Fpowername').val($(this).html())
				$('#fpowerid').val($(this).attr('poerid'))
			})
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