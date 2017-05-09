$(function(){
    /*批量导入 注册用户 弹出界面*/
    $('#importUserExcel').on('click',function(){
        $("#import-alert").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false
        });
    })

    /*创建用户*/
    $('#userCreate').on('click', function() {
        $("#transfer-alert2").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
        });
    });
    $('#userCreQuit').on('click', function() {
        $('#transfer-alert2').dialog('destroy');
    });
    /*创建用户*/
    $('#userCreSure').on('click', function() {
        var userName = $("#userNameInput").val();
        var userPhone = $("#userPhoneInput").val();
        var sex = $('input[name="userSexInput"]:checked').val();
        var userEmail = $("#userEmailInput").val();
        var userCardNumber = $("#userCardInput").val();
        var dataOfBirth = $("#userBirthInput").val();
        var workTime = $("#userWorkInput").val();
        var roleID = $('select[name="selectRole"]').val();
        var isOrgManager = $('input[name="userManagerInput"]:checked').val();
        var orgName = $('select[name="selectOrg"]').val();
        var jobName = $("#jobNameInput").val();

        var flag = true;
        if(userName == null || userName=="" ||userPhone == null || userPhone=="" || sex == null || sex=="" ||
            userEmail == null || userEmail==""||userCardNumber == null || userCardNumber=="" || dataOfBirth == null || dataOfBirth==""||
            workTime == null || workTime=="" || roleID == null || roleID==""||isOrgManager == null || isOrgManager=="" ||
            orgName == null || orgName==""||jobName == null || jobName==""
        ){
            flag = false;
            alert("信息填写不完整!");
        }

        if(flag){
            $.ajax({
                url : '/filter/user/createUser',
                type : 'POST',
                data : {
                    userName:userName,
                    userPhone:userPhone,
                    sex:sex,
                    userEmail:userEmail,
                    userCardNumber:userCardNumber,
                    dataOfBirth:dataOfBirth,
                    workTime:workTime,
                    roleID:roleID,
                    isOrgManager:isOrgManager,
                    orgName:orgName,
                    jobName:jobName
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                   /* $('#content').load("filter/user/getAllUser");*/
                    if(data.code != "0000"){
                        alert("创建失败:"+data.message);
                    }else {
                        // $("#transfer-alert2").hide();
                        $("#transfer-alert2").dialog('destroy');
                        alert("创建成功");
                        $('#forUserSearch').click();
                    }
                },
                error : function(data) {
                    alert("创建失败");
                }
            })
        }
    });

    /*查询*/
    $('#forUserSearch').on('click',function(){
        var userID = $("#userID").val();
        var userName = $("#userName").val();
        var userPhone = $("#userPhone").val();
        var orgName = $("#orgName").val();
        var jobName = $("#jobName").val();
        $('#companySearchCondition').val($('#forid').serialize());
        /*$('#content').load("filter/user/searchUserIndex",$('#companySearchCondition').val(),function() {
            $('.pagination>li>a').on('click', pageFunc());
        });*/
        $('#content').load("filter/user/searchUserIndex",$('#forid').serialize(), function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })

    /*手机号码验证*/
    $('#userPhoneInput').blur(function () {
        var regphone = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
        if($(this).is("#userPhoneInput")){
            if(!regphone.test(this.value)){
                $(this).siblings("span").show();
                alert("请输入正确格式的手机号码");
            }else{
                $(this).siblings("span").hide();
            }
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
                url: '/filter/user/exportInfo',
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


});
