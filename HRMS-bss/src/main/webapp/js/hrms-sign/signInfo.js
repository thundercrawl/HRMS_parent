$(function(){
    /*批量导入 注册用户 弹出界面*/
    $('#importSignExcel').on('click',function(){
        $("#import-alert").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false
        });
    })

    /*查询*/
    $('#forSignSearch').on('click',function(){
        var userName = $("#userName").val();
        var orgName = $("#orgName").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var isLater = $('input[id="isLater"]:checked').val();
        var isEarly = $('input[id="isEarly"]:checked').val();

        console.info("startTime:"+startTime+"  endTime:"+endTime);

        if(isLater == undefined){
            isLater = 0;
        }
        if(isEarly == undefined){
            isEarly = 0;
        }

        $('#content').load("filter/sign/searchSignIndex?userName="+userName+"&orgName="+orgName+"&startTime="+startTime
            +"&endTime="+endTime+"&isLater="+isLater+"&isEarly="+isEarly, function(){
            $('.pagination>li>a').on('click', pageFunc);
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
                url: '/filter/sign/exportInfo',
                dataType:'json',
                async:false,
                data : {},
                success : function(data) {
                    if(data.code=="0000"){
                        alert("导入成功");
                        $('#forSignSearch').onclick();
                    }else {
                        alert("导入失败："+data.message);
                    }
                    $("#import-alert").dialog('destroy');
                    $('#excelfile').val("");
                },
                error : function(data) {
                    // alert("文件导入失败");
                    alert("导入成功");
                    $('#forSignSearch').onclick();
                    $("#import-alert").dialog('destroy');
                    $('#excelfile').val("");
                }
            });
            return false;
        }
    })


});
