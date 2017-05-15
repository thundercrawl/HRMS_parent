$(function() {
    var orgId ;

    /*弹出添加成员界面*/
    $('.addMember').on('click',function () {
        orgId = $(this).attr("data-orgID");
        $("#transfer-inputMember").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    })
    /*关闭添加成员界面*/
    $('#inputMemberQuit').on('click', function() {
        $('#transfer-inputMember').dialog('destroy');
    });
    /*请求用户列表*/
    $('#inputMemberSure').on('click', function() {
        var userName = $("#memberNameInput").val();

        $.ajax({
            url : '/filter/org/findAllUserName',
            type : 'POST',
            data : {
                "userName":userName
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code == "0000"){
                    $('#transfer-inputMember').dialog('destroy');
                    var arr;
                    if(! $.isArray(data.data)){
                        arr = $.parseJSON(data.data);
                    }else{
                        arr= (data.data);
                    }
                    var html = "";
                    $.each(arr,function (index,o) {
                        html += '<option value="'+o.userId+' ">'+o.userName+'</option>';
                    })
                    $('#selectTab').html(html);
                    $("#transfer-addMember").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
                    });
                }else{
                    alert("请求失败："+data.message);
                }

            },
            error : function (data) {
                console.info(data);
                alert("网络错误")
            }
        });

    });

    /*关闭选择成员界面*/
    $('#addMemberQuit').on('click', function() {
        $('#transfer-addMember').dialog('destroy');
    });
    /*添加成员到部门*/
    $('#addMemberSure').on('click', function() {
        var userId = $('select[name="userIdSelect"]').val();
        var isManager = $('input[name="isManager"]:checked').val();
        var jobName = $("#addMemberJobName").val();
        var flag = true;
        if(jobName == null || $.trim(jobName) == ""){
            alert("职位不能为空");
            flag = false;
        }
        if(flag && confirm("确认添加到部门")){
            $.ajax({
                url : '/filter/org/addMember',
                type : 'POST',
                data : {
                    "userId":userId,
                    "jobName":jobName,
                    "isManager":isManager,
                    "orgId":orgId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code=="0000"){
                        $('#transfer-addMember').dialog('destroy');
                        alert("添加成功");
                    }else{
                        alert("添加失败："+data.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    });

    /*查找创建者*/
    $('.searchCreateUser').on('click',function () {
        var userName = $(this).attr("data-param");
        $('#content').load("filter/user/getUserFromOrg?userName="+userName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });

    })
    /*查找部门经理*/
    $('.searchOrgManager').on('click',function () {
        var userName = $(this).attr("data-param");

        $('#content').load("filter/user/getUserFromOrg?userName="+userName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
    /*查找上级部门*/
    $('.searchParentOrg').on('click',function () {
        var orgName = $(this).attr("data-param");
        $('#content').load("filter/org/searchOrgIndex?orgName="+orgName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })

    /*查找部门成员*/
    $('.searchMember').on('click',function () {
        var orgName = $(this).attr("data-orgName");
        $('#content').load("filter/user/getUserFromOrg?orgName="+orgName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })


    /*弹出修改部门信息框*/
    $('.alterOrg').on('click',function () {
        orgId = $(this).attr("data-orgID");
        $("#transfer-alertOrg").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    })
    /*关闭修改部门信息框*/
    $('#alterUserQuit').on('click', function() {
        $('#transfer-alertOrg').dialog('destroy');
    });
    /*修改部门信息*/
    $('#alterUserSure').on('click', function() {
        var orgName = $("#orgNameInputA").val();
        var parentOrgId = $('select[name="parentOrgA"]').val();
        var orgDesc = $('#orgDescInputA').val();

        $.ajax({
            url : '/filter/org/updateOrg',
            type : 'POST',
            data : {
                "orgId":orgId,
                "orgName":orgName,
                "parentOrgId":parentOrgId,
                "orgDesc":orgDesc

            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code == "0000"){
                    $('#transfer-alertOrg').dialog('destroy');
                    alert("修改部门信息成功");
                }else{
                    alert(data.message);
                }

            },
            error:function () {
                alert("网络错误");
            }
        });

    });

    /*删除部门*/
    $('.deleteOrg').on('click',function () {
        var orgId = $(this).attr("data-orgID");
        if(confirm("确认删除部门")){
            $.ajax({
                url : '/filter/org/deleteOrg',
                type : 'POST',
                data : {
                    "orgId":orgId

                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code == "0000"){
                        alert("删除部门成功");
                    }else{
                        alert("删除部门失败:"+data.message);
                    }

                },
                error:function () {
                    alert("网络错误");
                }
            });
        }
    })
});
