$(function() {
    var userId ;

    /*查看用户详细信息*/
    $('.showPersonalPage').on('click',function () {
        var user = $(this).attr("data-userId");
        $('#content').load("filter/personal/personalMessage?userId="+user);
    })

    /*弹出修改用户信息界面*/
    $('.alter').on('click', function() {
        userId = $(this).attr("data-userID");
        $("#transfer-alert1").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    });
    /*cancel*/
    $('#alterUserQuit').on('click', function() {
        $('#transfer-alert1').dialog('destroy');
    });
    /*确认修改用户信息*/
    $('#alterUserSure').on('click', function() {
        var userName = $("#alterUserNameInput").val();
        var userPhone = $("#alterUserPhoneInput").val();
        var userEmail = $("#alterUserEmailInput").val();
        var userBirth = $("#alterUserBirthInput").val();
        var userSex = $('input[name="sex"]:checked').val();
        var sure=confirm("是否确认修改");
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

    /*重置密码*/
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
                        alert("重置密码失败："+data.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    })

    /*解禁用户*/
    $(".unlockUser").on("click",function(){

        var userId= $(this).attr("data-userID");
        var sure=confirm("是否确认解禁");
        if(sure){
            $.ajax({
                url : '/filter/user/unlockUser',
                type : 'POST',
                data : {
                    "userID":userId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    console.info(data);
                    if(data.code=="0000"){
                        alert("解禁成功");
                        $('#content').load("filter/user/searchUserIndex?",$('#forid').serialize(),function(){
                            $('.pagination>li>a').on('click', pageFunc);
                        });
                    }else{
                        alert("解禁失败："+data.message);
                    }
                },
                error:function(data){
                    console.info(data);
                    alert("网络异常");
                }
            });
        }
    })
    /*禁用用户*/
    $(".lockUser").on("click",function(){

        var userId= $(this).attr("data-userID");
        var sure=confirm("是否确认禁用");
        if(sure){
            $.ajax({
                url : '/filter/user/lockUser',
                type : 'POST',
                data : {
                    "userID":userId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    var data1 = $.parseJSON(data);
                    if(data1.code=="0000"){
                        alert("禁用成功");
                        $('#content').load("filter/user/searchUserIndex?",$('#forid').serialize(),function(){
                            $('.pagination>li>a').on('click', pageFunc);
                        });
                    }else{
                        alert("禁用失败："+data1.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    })
    /*删除用户*/
    $(".deleteUser").on("click",function(){

        var userId= $(this).attr("data-userID");
        var sure=confirm("是否确认删除该用户");
        if(sure){
            $.ajax({
                url : '/filter/user/deleteUser',
                type : 'POST',
                data : {
                    "userID":userId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code=="0000"){
                        alert("删除成功");
                        $('#content').load("filter/user/searchUserIndex?",$('#forid').serialize(),function(){
                            $('.pagination>li>a').on('click', pageFunc);
                        });
                    }else{
                        alert("删除失败："+data.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    })

    /*移出部门*/
    $(".deleteFromOrg").on("click",function(){

        var userId= $(this).attr("data-userID");
        var orgId= $(this).attr("data-orgId");

        console.info("orgId:"+orgId+" userId:"+userId);

        var sure=confirm("是否确认把该用户移出部门");
        if(sure){
            $.ajax({
                url : '/filter/user/deleteFromOrg',
                type : 'POST',
                data : {
                    "orgID":orgId,
                    "userID":userId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code=="0000"){
                        alert("移除成功");
                        $('#content').load("filter/user/searchUserIndex?",$('#forid').serialize(),function(){
                            $('.pagination>li>a').on('click', pageFunc);
                        });
                    }else{
                        alert("移除失败："+data.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    })

    /*查找所在部门*/
    $('.searchOrg').on('click',function () {
        var orgName = $(this).attr("data-orgName");
        $('#content').load("filter/org/searchOrgIndex?orgName="+orgName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
});
