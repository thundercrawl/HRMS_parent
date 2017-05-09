$(function(){
    /*查询*/
    $('#forWageSearch').on('click',function(){
        var userName = $("#userName").val();
        var userPhone = $("#userPhone").val();
        var orgName = $("#orgName").val();
        $('#content').load("filter/wage/searchWageIndex?userName="+userName+"&userPhone="+userPhone+"&orgName="+orgName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
    /*弹出导入Excel界面*/
    $('#importWageExcel').on('click',function(){
        $("#import-alert").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false
        });
    })

    $('#excel_form').on('submit', function() {
        var f_content = excel_form.file.value;
        var fileext=f_content.substring(f_content.lastIndexOf("."),f_content.length)
        fileext=fileext.toLowerCase()
        if (fileext!='.xls'&&fileext!='.xlsx'){
            alert("对不起，导入数据格式必须是xls格式或xlsx格式文件，请您调整格式后重新上传，谢谢 ！");
            return false;
        }  else{
            $(this).ajaxSubmit({
                type: 'post',
                url: '/filter/wage/exportInfo',
                dataType:'json',
                async:false,
                data : {},
                success : function(data) {
                    if(data.message=="success"){
                        alert("导入成功");
                    }else if(data.message=="fail"){
                        alert("导入失败");
                    }
                    $("#import-alert").dialog('destroy');
                    $('#excelfile').val("");
                },
                error : function(data) {
                    alert("文件导入失败");
                    $("#import-alert").dialog('destroy');
                    $('#excelfile').val("");
                }
            });
            return false;
        }
    })


    $(this).siblings('span').css('display')=='block'?
        $(this).siblings('span').addClass('active1'):
        $(this).siblings('span').removeClass('active1');
    $(".user-form >div >span").hasClass('active1')?(
            $(".btn1-users").attr('readonly','readonly'),
                $(".btn1-users").css('cursor','not-allowed'),
                $('#btn-users').css('background','#ccc')
        ):(
            $(".btn1-users").removeAttr('readonly'),
                $(".btn1-users").css('cursor','pointer'),
                $('#btn-users').css('background','#2aadff')

        );


});
