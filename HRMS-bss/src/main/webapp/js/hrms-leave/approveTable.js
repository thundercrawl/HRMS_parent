$(function() {
    /*查找审批人*/
    $('.searchApproveUser').on('click',function () {
        var approveUserName = $(this).attr("data-param");
        $('#content').load("filter/user/searchUserIndex?userName="+approveUserName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })

    var leaveId;
    $('.showApprove').on('click',function () {
        leaveId = $(this).attr("data-leaveId");
        $.ajax({
            url : '/filter/leave/showApproveDetail',
            type : 'POST',
            data : {
                "leaveId":leaveId
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code=="0000"){
                    console.info(data.data);
                    console.info(data.data.userName);

                    $('#userName').text(data.data.userName);
                    $('#userPhone').text(data.data.userPhone);
                    $('#orgName').text(data.data.orgName);
                    $('#jobName').text(data.data.jobName);
                    $('#leaveCodeD').text(data.data.leaveCode);
                    $('#startTime').text(data.data.startTime);
                    $('#endTime').text(data.data.endTime);
                    $('#upTime').text(data.data.upTime);
                    $('#leaveContent').text(data.data.leaveContent);

                    $("#transfer-showApprove").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
                    });
                }else{
                    alert("请求信息失败"+data.message);
                }
            },
            error:function(data){
                alert("网络异常");
            }
        });
    })

    $('#approvePass').on('click',function () {
        $.ajax({
            url : '/filter/leave/passApprove',
            type : 'POST',
            data : {
                "leaveId":leaveId
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code=="0000"){
                    alert("审核成功");
                    $("#transfer-showApprove").dialog("destroy");
                    var leaveCode = $("#approveCode").val();
                    $('#content').load("filter/leave/searchApproveIndex?leaveCode="+leaveCode, function(){
                        $('.pagination>li>a').on('click', pageFunc);
                    });
                }else{
                    alert("审核失败"+data.message);
                }
            },
            error:function(data){
                alert("网络异常");
            }
        });

    })

    $('#approveReject').on('click',function () {
        $.ajax({
            url : '/filter/leave/rejectApprove',
            type : 'POST',
            data : {
                "leaveId":leaveId
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code=="0000"){
                    alert("审核成功");
                    $("#transfer-showApprove").dialog("destroy");
                    var leaveCode = $("#approveCode").val();
                    $('#content').load("filter/leave/searchApproveIndex?leaveCode="+leaveCode, function(){
                        $('.pagination>li>a').on('click', pageFunc);
                    });
                }else{
                    alert("审核失败"+data.message);
                }
            },
            error:function(data){
                alert("网络异常");
            }
        });

    })

    $('#approveQuit').on('click',function () {
        $("#transfer-showApprove").dialog("destroy");
    })


    $('.pass').on('click',function () {
        var leaveId = $(this).attr("data-leaveId");
        $.ajax({
            url : '/filter/leave/passApprove',
            type : 'POST',
            data : {
                "leaveId":leaveId
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code=="0000"){
                    alert("审核成功");
                    var leaveCode = $("#approveCode").val();
                    $('#content').load("filter/leave/searchApproveIndex?leaveCode="+leaveCode, function(){
                        $('.pagination>li>a').on('click', pageFunc);
                    });
                }else{
                    alert("审核失败"+data.message);
                }
            },
            error:function(data){
                alert("网络异常");
            }
        });

    })

    $('.reject').on('click',function () {
        var leaveId = $(this).attr("data-leaveId");
        $.ajax({
            url : '/filter/leave/rejectApprove',
            type : 'POST',
            data : {
                "leaveId":leaveId
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code=="0000"){
                    alert("审核成功");
                    var leaveCode = $("#approveCode").val();
                    $('#content').load("filter/leave/searchApproveIndex?leaveCode="+leaveCode, function(){
                        $('.pagination>li>a').on('click', pageFunc);
                    });
                }else{
                    alert("审核失败"+data.message);
                }
            },
            error:function(data){
                alert("网络异常");
            }
        });

    })
});
