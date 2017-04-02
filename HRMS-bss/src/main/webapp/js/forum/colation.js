$(function(){
	$('#findScolation').click(function(){
		var sname = $('#findInput').val().trim();
		$('#colationtable').load('filter/forum/showcolation?name='+encodeURI(sname)+'&page=0');
	});
	$('#findInput').focus(function(){
		$('#textspan').hide();
	});
	$('#deleteScolation').click(function(){
		var curCheckBox = document.getElementsByName("check");
		var sname = $('#findInput').val();
	    var page = $('#page').val();
		var idlist = [] ;
		for(var i = 0; i < curCheckBox.length; i++){
			if(curCheckBox.item(i).checked==true){
				idlist+=curCheckBox.item(i).value+";";
			}
		}
		if(idlist.length==0){
			$("#deleteDialog").dialog({
				modal:true,
				autoOpen: true,
				height:'auto',
				width:329,
				resizable:false,
				close:function(){
					$('#deleteDialog').dialog('destroy');
				}});
		}else{
			$("#confirmDialog").dialog({modal:true,
				autoOpen: true,
				height:'auto',
				width:329,
				resizable:false,
				close:function(){
					$('#confirmDialog').dialog('close');
				},
				open:function(){
					$('#confirmDelBtn').on('click', function(){{
						$('#confirmDialog').dialog('close');
						$('#content').load('filter/forum/deletecolation?page='+page+'&finame='+sname+'&listid='+idlist, function(){
						});
					}});
					$('#cancelDelBtn').on('click', function(){{
						$('#confirmDialog').dialog('close');
					}});
				}
			});
			
		}
	});
	$('#deletecheck').click(function(){
		$('#deleteDialog').dialog('destroy');
	});
	$('#addScolations').click(function(){
		$("#addScenes").dialog({
			modal:true,
			autoOpen: true,
			height:'auto',
			width:386,
			resizable:false,
			close:function(){
				$('#addScenes').dialog('destroy');
			}
		});
		$("#scenetxt").val('选择文件(如:敏感词.txt)');
		$('#imgspans').hide();
	});
	$('#backcheck').click(function(){
		$('#addScenes').dialog('destroy');
	});
	function showFileName(){
		var length = document.getElementById("file").files.length;
		for(var i=0;i<length;i++){
			var file = document.getElementById("file").files[i];
			$("#scenetxt").val(file.name);
		}
	}
	$('#file').on('change', showFileName);
	$('#surecheck').click(function(){
		var filename = $('#scenetxt').val();
		var filenames = filename.split(".");
		if(filenames[1]=="txt"){
			$('#imgspans').hide();
			$('#addform').submit();
			$('#addScenes').dialog('destroy');
		}else{
			$('#imgspans').show();
		}
	});
	
	$('#addScolation').click(function(){
		$("#addSdialog").dialog({
			modal:true,
			autoOpen: true,
			height:'auto',
			width:355,
			resizable:false,
			close:function(){
				$('#addSdialog').dialog('destroy');
			}
		});
		$('#imgspan').hide();
		$('#sceneName').val('');
		$('#sceneid').val('0');
	});
	$('#return').click(function(){
		$('#addSdialog').dialog('destroy');
	});
	$('#formcheck').click(function(){
		var sceneName = $('#sceneName').val().trim();
		var page = $('#page').val();
		var id = $('#sceneid').val(); 
		var finame = $('#findInput').val();
		if(sceneName!=""&&sceneName!=null){
		   var namelength = sceneName.split("");
		   if(namelength.length<=10){
			   $('#content').load('filter/forum/saveOrUpdatecolation?name='+encodeURI(sceneName)+"&page="+page+'&sensitiveId='+id+'&finame='+finame);
			   $('#addSdialog').dialog('destroy');
			   $('#imgspan').hide();
			   $('#lengthspan').hide();
		   }else{
			  alert("长度超过指定字数长度!");
		   }
		}else{
			$('#imgspan').show();
		}
	});
});

function check(temp){
	var curCheckBox = document.getElementsByName("check");
	for(var i = 0; i < curCheckBox.length; i++){
		curCheckBox.item(i).checked = temp.checked;
	}
}