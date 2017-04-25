function showPersonMessage(userID){
    $.ajax({
        type: 'POST',
        url: "/filter/user/showPersonMessage",
        data: {
            userID: userID
        },
        dataType: 'json',
        async: false,
        success: function (data) {
            console.info(data);
            if("0000".equals(data.code)){
                alter("开发中")
            }else{
                alter(data.message);
            }
            /*if (data. == '1') {
                // window.location.href = "filter/user/";
                //window.location.href = "filter/offlineReserve/toOfflineReserve";

                alter()
            } else {

            }*/
        }
    })
}

$(function() {
    var userId ;
    var userIDS = $("#userID").val();
    var userNameS = $("#userName").val();
    var userPhoneS = $("#userPhone").val();
    var orgNameS = $("#orgName").val();
    var jobNameS = $("#jobName").val();


    $('.alter').on('click', function() {
        userId = $(this).attr("data-userID");
        $("#transfer-alert1").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    });
    $('#alterUserQuit').on('click', function() {
        $('#transfer-alert1').dialog('destroy');
    });
    $('#alterUserSure').on('click', function() {
        var userName = $("#alterUserNameInput").val();
        var userPhone = $("#alterUserPhoneInput").val();
        var userEmail = $("#alterUserEmailInput").val();
        var userBirth = $("#alterUserBirthInput").val();
        var userSex = $('input[name="sex"]:checked').val();
        var sure=confirm("是否确认修改");
        console.info(userName+" "+userPhone+" "+userEmail+" "+userBirth+" "+userSex);
        if(sure){
            $.ajax({
                url : '/filter/user/updateUser',
                type : 'POST',
                data : {
                    "userID":userId,
                    "userName":userName,
                    "userSex":userSex,
                    "birthOfDate":userBirth,
                    "userEmail":userEmail,
                    "userPhone":userPhone
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code=="0000"){
                        alert("更新用户信息成功");
                        /*$('#content').load(
                            "filter/user/searchUser?userID="
                            + userIDS + "&userName="
                            + userNameS+ "&userPhone="
                            + userPhoneS+ "&orgName="
                            + orgNameS+ "&jobName="
                            + jobNameS);
                        ;*/
                        $('#transfer-alert1').dialog('destroy');
                        $('#tid').load("filter/user/searchUser",$('#forid').serialize(), function(){
                            $('.pagination>li>a').on('click', pageFunc);
                        });
                    }else{
                        alert("更新用户信息失败"+data.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    });

    $(".resetPwd").on("click",function(){

        var userId= $(this).attr("data-userID");
        var sure=confirm("是否确认重置密码");
        if(sure){
            $.ajax({
                url : '/filter/user/resetPwd',
                type : 'POST',
                data : {
                    "userID":userId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code=="0000"){
                        alert("重置密码成功");
                    }else{
                        alert("重置密码失败"+data.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    })
});
