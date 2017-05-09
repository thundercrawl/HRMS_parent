$(function(){
    /*弹出创建部门界面*/
    $('#addOrg').on('click',function () {
        $("#transfer-createOrg").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    })
    /*关闭创建部门界面*/
    $('#createOrgQuit').on('click', function() {
        $('#transfer-createOrg').dialog('destroy');
    });

    /*创建部门*/
    $('#createOrgSure').on('click', function() {
        var orgName = $("#orgNameInput").val();
        var parentOrgId = $('select[name="parentOrg"]').val();
        var desc = $("#orgDescInput").val();

        var flag = true;
        if(orgName == null || orgName=="" ||parentOrgId == null || parentOrgId=="" || desc == null || desc=="" ){
            flag = false;
            alert("信息填写不完整!");
        }

        if(flag){
            $.ajax({
                url : '/filter/org/createOrg',
                type : 'POST',
                data : {
                    orgName:orgName,
                    parentOrgId:parentOrgId,
                    desc:desc
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code != "0000"){
                        alert("创建失败:"+data.message);
                    }else {
                        $("#transfer-alert2").dialog('destroy');
                        alert("创建成功");
                        $('#forOrgSearch').click();
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
    $('#forOrgSearch').on('click',function(){
        var orgId = $("#orgIdS").val();
        var orgName = $("#orgNameS").val();
        var parentOrgId = $("#parentOrgIdS").val();
        var parentOrgName = $("#parentOrgNameS").val();

        console.info("orgId:"+orgId+" orgName:"+orgName+" parentOrgId:"+parentOrgId+" parentOrgName:"+parentOrgName);

        $('#content').load("filter/org/searchOrgIndex?orgId="+orgId+"&orgName="+orgName+"&parentOrgId="+parentOrgId+"&parentOrgName="+parentOrgName, function(){
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
