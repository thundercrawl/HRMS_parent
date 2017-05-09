$(function(){
    /*弹出出差申请界面*/
    $('#addBusiness').on('click',function () {
        $("#transfer-upBusiness").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    })
    /*关闭出差申请界面*/
    $('#upBusinessQuit').on('click', function() {
        $('#transfer-upBusiness').dialog('destroy');
    });

    /*提交出差申请*/
    $('#upBusinessSure').on('click', function() {
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var leaveContent = $("#leaveContent").val();

        var flag = true;
        if(startTime == null || startTime=="" ||endTime == null || endTime=="" || leaveContent == null || leaveContent=="" ){
            flag = false;
            alert("信息填写不完整!");
        }

        if(flag){
            $.ajax({
                url : '/filter/leave/upBusinessApprove',
                type : 'POST',
                data : {
                    "startTime":startTime,
                    "endTime":endTime,
                    "leaveContent":leaveContent
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code != "0000"){
                        alert("提交失败:"+data.message);
                    }else {
                        $("#transfer-upBusiness").dialog('destroy');
                        alert("提交成功");
                        $('#forBusinessSearch').click();
                    }
                },
                error : function(data) {
                    alert("创建失败");
                    $("#transfer-alert2").dialog('destroy');
                }
            })
        }
    });

    /*查询*/
    $('#forBusinessSearch').on('click',function(){
        var leaveCode = $("#leaveCode").val();
        var leaveStatus = $('select[name="leaveStatus"]').val();

        $('#content').load("filter/leave/searchBusinessIndex?leaveCode="+leaveCode+"&leaveStatus="+leaveStatus, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
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
