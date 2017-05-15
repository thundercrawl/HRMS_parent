$(function(){

  /*  $('.datetimepicker').datetimepicker({
        format: 'Y-m-d H:i',
        autoclose: true,
        minView: 0,
        linkField: "startTime",
        linkFormat: "Y-m-d H:i",
        minuteStep:1,
        inputMask: true
    });*/

    $('#startTime1').datetimepicker({
        format: 'Y-m-d',
        autoclose: true,
        minView: 0,
        linkField: "startTime1",
        linkFormat: "Y-m-d",
        minuteStep:1,
        inputMask: true
    });
    $('#endTime1').datetimepicker({
        format: 'Y-m-d',
        autoclose: true,
        minView: 0,
        linkField: "endTime1",
        linkFormat: "Y-m-d",
        minuteStep:1,
        inputMask: true
    });


    /*弹出请假申请界面*/
    $('#addLeave').on('click',function () {
        $("#transfer-upLeave").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    })
    /*关闭请假申请界面*/
    $('#upLeaveQuit').on('click', function() {
        $('#transfer-upLeave').dialog('destroy');
    });

    /*提交请假申请*/
    $('#upLeaveSure').on('click', function() {
        var startTime = $("#startTime1").val();
        var endTime = $("#endTime1").val();
        var leaveContent = $("#leaveContent1").val();

        var flag = true;
        if(startTime == null || startTime=="" ||endTime == null || endTime=="" ){

            console.info("startTime:"+startTime+" endTime:"+endTime);
            flag = false;
            alert("信息填写不完整!");
        }

        if(flag){
            $.ajax({
                url : '/filter/leave/upLeaveApprove',
                type : 'POST',
                data : {
                    "startTime":startTime+" 00:00:00",
                    "endTime":endTime+" 00:00:00",
                    "leaveContent":leaveContent
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code != "0000"){
                        alert("提交失败:"+data.message);
                    }else {
                        alert("提交成功");
                        $("#transfer-upLeave").dialog('destroy');
                        $('#forOrgSearch').click();
                    }
                },
                error : function(data) {
                    alert("提交失败");
                    $("#transfer-upLeave").dialog('destroy');
                }
            })
        }
    });

    /*查询*/
    $('#forLeaveSearch').on('click',function(){
        var leaveCode = $("#leaveCode").val();
        // var leaveStatus = $('select[name="leaveStatus"]').val();
        var leaveStatus = $('#leaveStatusIn').val();

        $('#content').load("filter/leave/searchLeaveIndex?leaveCode="+leaveCode+"&leaveStatus="+leaveStatus, function(){
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
