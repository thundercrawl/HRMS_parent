$(function(){

	var menuJson = $('#hiddenMenuJson').val();
    menuclickFunc = function(){
    	var cmpId = $(this).attr('id');
    	var menuType = $(this).attr('menu-type');
    	if(menuType == 'top') {
    		var len = $(this).parent().children('ul').children('li').length;
    		if(len >= 3){
    			$('#menuConfig').html('');
    			return ;
    		}
    		$('#menuConfig').html('<button class="btn btn-primary" id="parentBtn">新增一级菜单</button> &nbsp;&nbsp;&nbsp;'
								 +'<button class="btn btn-primary" id="viewBtn">新增页面菜单</button>'
								 +'<input type="hidden" value="'+cmpId+'" id="hiddenCmpId">');
    		$('#parentBtn').unbind('click');
    		$('#parentBtn').on('click', parentFunc);
    		$('#viewBtn').unbind('click');
    		$('#viewBtn').on('click', viewFunc);
    	} else if(menuType == 'parent') {
    		$('#menuConfig').html('<button class="btn btn-primary" id="viewBtn">新增页面菜单</button> &nbsp;&nbsp;&nbsp;'
    							 +'<button class="btn btn-danger" id="delBtn">删除菜单</button>'
    							 +'<input type="hidden" value="'+cmpId+'" id="hiddenCmpId">');
    		$('#viewBtn').unbind('click');
    		$('#viewBtn').on('click', viewFunc);
    		$('#delBtn').unbind('click');
    		$('#delBtn').on('click', delFunc);
    	} else if(menuType == 'view') {
    		$('#menuConfig').html('<div class="input-group col-md-6" style="margin: 2px 0;">'
								+ '	<span class="input-group-addon">菜单名称</span>'
								+ '	<input type="text" class="form-control" placeholder="输入菜单名称" id="menuName">'
								+ '</div>'
								+ '<div class="input-group col-md-6" style="margin: 2px 0;">'
								+ '	<span class="input-group-addon">页面链接</span>'
								+ '	<input type="text" class="form-control" placeholder="输入页面链接" id="menuUrl">'
								+ '</div>'
								+ '<button class="btn btn-danger" style="margin:10px" id="delBtn">删除</button>'
								+ '<button class="btn btn-primary" style="margin:10px" id="commitBtn">确定</button>'
								+ '<button class="btn btn-cancel" style="margin:10px" id="cancelBtn">取消</button>'
								+ '<input type="hidden" value="'+cmpId+'" id="hiddenCmpId">');
    		$('#menuName').val($(this).text());
    		$('#menuUrl').val($(this).attr('menu-url'));
    		$('#delBtn').unbind('click');
    		$('#delBtn').on('click', delFunc);
    		$('#commitBtn').unbind('click');
    		$('#commitBtn').on('click', commitFunc);
    		$('#cancelBtn').unbind('click');
    		$('#cancelBtn').on('click', cancelFunc);
    	} else {
    		
    	}
    };
    
    $('.menu').on('click', menuclickFunc);
    
    parentFunc = function(){
    	var cmpId = $('#hiddenCmpId').val();
    	$('#menuConfig').html('<div class="input-group col-md-6" style="margin: 2px 0;">'
				+ '	<span class="input-group-addon">一级菜单</span>'
				+ '	<input type="text" class="form-control" placeholder="输入菜单名称" id="parentName">'
				+ '</div>'
				+ '<div class="input-group col-md-6" style="margin: 2px 0;">'
				+ '	<span class="input-group-addon">菜单名称</span>'
				+ '	<input type="text" class="form-control" placeholder="输入菜单名称" id="menuName">'
				+ '</div>'
				+ '<div class="input-group col-md-6" style="margin: 2px 0;">'
				+ '	<span class="input-group-addon">页面链接</span>'
				+ '	<input type="text" class="form-control" placeholder="输入页面链接" id="menuUrl">'
				+ '</div>'
				+ '<button class="btn btn-primary" style="margin:10px" id="commitBtn">确定</button>'
				+ '<button class="btn btn-cancel" style="margin:10px" id="cancelBtn">取消</button>'
				+ '<input type="hidden" value="'+cmpId+'" id="hiddenCmpId">');
    	$('#commitBtn').unbind('click');
		$('#commitBtn').on('click', commitFunc);
    	$('#cancelBtn').unbind('click');
		$('#cancelBtn').on('click', cancelFunc);
    };
    
    viewFunc = function(){
    	var cmpId = $('#hiddenCmpId').val();
    	$('#menuConfig').html('<div class="input-group col-md-6" style="margin: 2px 0;">'
				+ '	<span class="input-group-addon">菜单名称</span>'
				+ '	<input type="text" class="form-control" placeholder="输入菜单名称" id="menuName">'
				+ '</div>'
				+ '<div class="input-group col-md-6" style="margin: 2px 0;">'
				+ '	<span class="input-group-addon">页面链接</span>'
				+ '	<input type="text" class="form-control" placeholder="输入页面链接" id="menuUrl">'
				+ '</div>'
				+ '<button class="btn btn-primary" style="margin:10px" id="commitBtn">确定</button>'
				+ '<button class="btn btn-cancel" style="margin:10px" id="cancelBtn">取消</button>'
				+ '<input type="hidden" value="'+cmpId+'" id="hiddenCmpId">');
    	$('#commitBtn').unbind('click');
		$('#commitBtn').on('click', commitFunc);
		$('#cancelBtn').unbind('click');
		$('#cancelBtn').on('click', cancelFunc);
    };
    
    delFunc = function() {
    	$('#delConfirm').dialog({
    		title : '您确定删除此菜单？',
			resizable : false,
			width : '250px',
			top:'250px',
			modal : true,
			// 隐藏默认的关闭按钮
			open : function(event, ui) {
				$(".ui-dialog-titlebar-close", $(this).parent()).hide();
				$('#removeMenu').unbind('click');
				$('#removeMenu').on('click', function(){
					var cmpId = $('#hiddenCmpId').val();
					if($('#'+cmpId).parent().parent().children('li').length <= 1) {
						$('#'+cmpId).parent().parent().parent().remove();
					} else {
						$('#'+cmpId).parent().remove();
					}
					$('#delConfirm').dialog('destroy');
					$('#mask').show();
					var menuCfg = genMenuJson();
		    		var menuCfgStr = JSON.stringify(menuCfg);
		    		console.log(menuCfgStr);
					$.ajax({
		    			type: "POST",
		                 url: 'filter/sys/updateMenu',
		                 dataType: "json",
		                 data : {'menuCfg':menuCfgStr},
		                 complete: function(jqXHR){
		                     console.log(jqXHR.status);
		                     $('#mask').hide();
		                     if(jqXHR.status == 200) {
		                    	 
		                     }
		                 },
		                 success: function(data){
		                	 rdata = data;
		                	 $('#menuConfig').html('');
		                 }
		              });
				});
				$('#cancelRemove').unbind('click');
				$('#cancelRemove').on('click', function(){
					$('#delConfirm').dialog('destroy');
				});
			}
		});
    };
    
    commitFunc = function() {
    	var parentName = $('#parentName').val();
    	var menuName = $('#menuName').val();
		var menuUrl = $('#menuUrl').val();
		var cmpId = $('#hiddenCmpId').val();
		if(parentName != undefined && parentName.trim() == '') {
			alert('菜单名称不能为空');
			return;
		}
		if(menuName.trim() == '') {
			alert('菜单名称不能为空');
			return;
		}
		if((parentName != undefined && parentName.trim().length > 10) || menuName.trim().length > 10) {
			alert('菜单名称过长');
			return;
		}
		if(menuUrl.trim() == '') {
			alert('页面链接不能为空');
			return;
		}
		
		$('#mask').show();
		//更改树状结构
		var menuType = $('#'+cmpId).attr('menu-type');
		if(menuType == 'view') {
			$('#'+cmpId).html(menuName);
			$('#'+cmpId).attr('old-menu-url', $('#'+cmpId).attr('menu-url'));
			$('#'+cmpId).attr('menu-url', menuUrl);
		} else if(menuType == 'parent') {
			var len = $('#'+cmpId).parent().children('ul').children('li').length;
			$('#'+cmpId).parent().children('ul').append('<li id="newAdd">'
	                        + '<span class="menu" menu-type="view" menu-url="'+menuUrl+'" id="subMenu_'+len+'">'+menuName+'</span>'
	                        + '</li>');
		} else if(menuType == 'top') {
			var parentLen = $('#'+cmpId).parent().children('ul').children('li').length;
			if(parentName != undefined) {
				$('#'+cmpId).parent().children('ul').append('<li id="newAdd" class="parent_li">'
		                	+ '<span class="badge badge-success menu" menu-type="parent" id="parentMenu_'+parentLen+'">'+parentName+'</span>'
				            + '<ul>'
				            + '	<li>'
		                    + '	<span class="menu" menu-type="view" menu-url="'+menuUrl+'" id="subMenu_'+parentLen+'_0">'+menuName+'</span>'
		                    + '	</li>'
		                    + '</ul>'
				            + '</li>');
			} else {
				$('#'+cmpId).parent().children('ul').append('<li id="newAdd">'
	                        + '<span class="menu" menu-type="view" menu-url="'+menuUrl+'" id="parentMenu_'+parentLen+'" >'+menuName+'</span>'
	                        + '</li>');
			}
		} else {
			return;
		}
		$('.menu').each(function(){
			$(this).unbind('click');
			$(this).on('click', menuclickFunc);
		});
		var menuCfg = genMenuJson();
		var menuCfgStr = JSON.stringify(menuCfg);
		console.log(menuCfgStr);
		$.ajax({
			type: "POST",
             url: 'filter/sys/updateMenu',
             dataType: "json",
             data : {'menuCfg':menuCfgStr},
             complete: function(jqXHR){
                 console.log(jqXHR.status);
                 $('#mask').hide();
                 if(jqXHR.status == 200) {
                	 
                 }
             },
             success: function(data){
            	 rdata = data;
            	 if(data.status == 1) {
            		 $('#menuConfig').html('');
            		 menuJson = menuCfgStr;
            		 $('#hiddenMenuJson').val(menuCfgStr);
            	 } else {
            		 alert(data.message);
            		 if(menuType == 'view') {
            			 $('#'+cmpId).attr('menu-url', $('#'+cmpId).attr('old-menu-url'));
            		 } else {
            			$('#newAdd').remove(); 
            		 }
            	 }
             }
          });
    };
    
    cancelFunc = function() {
    	$('#menuConfig').html('');
    };
    
    genMenuJson = function() {
    	var json = {};
    	var buttons=[];
    	var i = 0;
    	$('#topMenu').children('ul').children('li').each(function(){
    		var button = {};
    		button['name']=$(this).children('span').text();
    		var type = $(this).children('span').attr('menu-type');
    		if(type == 'view') {
    			button['type']='view';
    			button['url']=$(this).children('span').attr('menu-url');
    			button['sub_button']=[];
    		}
    		if(type == 'click') {
    			button['type']='view';
    			button['key']=$(this).children('span').attr('menu-key');
    			button['sub_button']=[];
    		}
    		if(type == 'parent') {
    			var sub_buttons = [];
    			var j = 0;
    			$(this).children('ul').children('li').each(function(){
    				var sub_button = {};
    				sub_button['name']=$(this).children('span').text();
    	    		var type = $(this).children('span').attr('menu-type');
    	    		if(type == 'view') {
    	    			sub_button['type']='view';
    	    			sub_button['url']=$(this).children('span').attr('menu-url');
    	    			sub_button['sub_button']=[];
    	    		}
    	    		if(type == 'click') {
    	    			sub_button['type']='view';
    	    			sub_button['key']=$(this).children('span').attr('menu-key');
    	    			sub_button['sub_button']=[];
    	    		}
    	    		sub_buttons[j ++] = sub_button;
    			});
    			button['sub_button']=sub_buttons;
    		}
    		buttons[i ++] = button;
    	});
    	json['button'] = buttons;
    	console.log(json);
    	return json;
    };

});