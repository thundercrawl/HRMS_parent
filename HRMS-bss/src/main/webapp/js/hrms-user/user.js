$(function(){
    var page=0;
    var comid=0;

    /*批量导入 注册用户*/
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
    $('#userCreSure').on('click', function() {
        var userName = $("#userNameInput").val();
        var userPhone = $("#userPhoneInput").val();
        var sex = $('input[name="userSexInput"]:checked').val();
        var userEmail = $("#userEmailInput").val();
        var userCardNumber = $("#userCardInput").val();
        var dataOfBirth = $("#userBirthInput").val();
        var workTime = $("#userWorkInput").val();
        var roleID = /*$('#selectRole option:selected').val();*/$('select[name="selectRole"]').val();
        var isOrgManager = $('input[name="userManagerInput"]:checked').val();
        var orgName = /*$('#selectOrg option:selected').val();*/$('select[name="selectOrg"]').val();
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
                    $("#transfer-alert2").dialog('destroy');
                   /* $('#content').load("filter/user/getAllUser");*/
                    if(data.code != "0000"){
                        alert("创建失败:"+data.message);
                        $("#transfer-alert2").hide();
                    }else {
                        alert("创建成功");
                        /*var userID = $("#userID").val();
                        var userName = $("#userName").val();
                        var userPhone = $("#userPhone").val();
                        var orgName = $("#orgName").val();
                        var jobName = $("#jobName").val();
                        $('#companySearchCondition').val($('#forid').serialize());
                        $('#content').load("filter/user/searchUser?userID="+userID+"&userName="+userName+"&userPhone="+userPhone+"&orgName="+orgName+"&jobName="+jobName+"&page="+pagenum);
                        */
                        $('#forUserSearch').click();
                    }
                },
                error : function(data) {
                    alert("创建失败");
                }
            })
        }
    });

    $('#forUserSearch').on('click',function(){
        var userID = $("#userID").val();
        var userName = $("#userName").val();
        var userPhone = $("#userPhone").val();
        var orgName = $("#orgName").val();
        var jobName = $("#jobName").val();
        $('#companySearchCondition').val($('#forid').serialize());
        /* $('#tid').load("filter/user/searchUserIndex",$('#forid').serialize());*/
        $('#content').load("filter/user/searchUserIndex?userID="+userID+"&userName="+userName+"&userPhone="+userPhone+"&orgName="+orgName+"&jobName="+jobName);
    })

    /*手机号码验证*/
    $('#userPhoneInput').blur(function () {
        var regname = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/;
        if($(this).is("#userPhoneInput")){
            if(!regname.test(this.value)){
                $(this).siblings("span").show();
                alert("请输入正确格式的手机/座机号码");
            }else{
                $(this).siblings("span").hide();
            }
        }

    })

    /*条件查询*/
    $('#forUserSearch').on('click',function(){
        var userID = $("#userID").val();
        var userName = $("#userName").val();
        var userPhone = $("#userPhone").val();
        var orgName = $("#orgName").val();
        var jobName = $("#jobName").val();
        $('#companySearchCondition').val($('#forid').serialize());
        $('#tid').load("filter/user/searchUserIndex",$('#forid').serialize(), function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })


    comChangeQuit=function(){
        $("#transfer-alert3").dialog('destroy');
    }
    $('#workerAdd').on('click', function() {
        $("#transfer-alert2").dialog('destroy');
    });

    $('#backToCompany').on('click', function() {
        $('#content').load("filter/member/companyShow");
    });
    $('#exportComSearch').on('click',function(){
        var companyId=$("#companyId").val();
        var userPhone=$("#userPhone").val();
        var companyAddress=$("#companyAddress").val();
        var companyName=$("#companyName").val();
        window.location.href="filter/exprot/exportCompanyInfo?companyId="+companyId+"&userPhone="+userPhone+"&companyAddress="+companyAddress+"&companyName="+companyName;
    })

    $('#forComSearch').on('click',function(){
        var companyId=$("#companyId").val();
        $('#companySearchCondition').val($('#forid').serialize());
        $('#tid').load("filter/member/getComQuerry",$('#forid').serialize(), function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
    $('#forComMemSearch').on('click',function(){
        var userId=$("#userId").val();
        $('#companyMemberSearchCondition').val($('#forid').serialize());
        $('#tid').load("filter/member/getComMemQuerry",$('#forid').serialize(), function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })

    comDel=function(companyId) {
        if (window.confirm("确定执行操作？")) {
            $.ajax({
                url : 'filter/member/releaseOfcCompanyInfo',
                type : 'POST',
                data : {
                    companyId : companyId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data){
                        $('#content').load("filter/member/companyShow");
                    }else{
                        alert("释放公司失败");
                    }
                },
                error : function(data) {
                    alert("程序出错");
                }
            });
        }

    }

    var imgURL="";
    $('#companyId1').on('submit', function() {
        $(this).ajaxSubmit({
            type: 'post',
            url: 'filter/member/companyGetUrl',
            dataType:'json',
            async:false,
            data : {},
            success : function(data) {
                imgURL=data.assureMoney;
                companyCreSure();
            },
            error : function(data) {
                alert("上传文件失败");
            }
        });

        return false; // 阻止表单自动提交事件
    });
    companyCreSure = function(){
        var comName=$("#companyNameAdd").val();
        var comAddress=$("#companyAddressAdd").val();
        var companyEmail=$("#companyEmailAdd").val();
        var companyPhone=$("#companyPhoneAdd").val();
        var companyBusiness=$("#companyBusinessAdd").val();
        var companyIntroduction=$("#companyIntroductionAdd").val();
        var companyImg=$("#companyImg").val();
        var createerPhone=$("#createerPhoneAdd").val();
        if(companyName==""){
            alert("公司名称不能为空!")
        }else if(createerPhone==""){
            alert("创建人电话不能为空!");
        }else{
            $.ajax({
                url : 'filter/member/companySave',
                type : 'POST',
                data : {
                    companyName:comName,
                    companyAddress:comAddress,
                    companyEmail:companyEmail,
                    companyPhone:companyPhone,
                    companyBusiness:companyBusiness,
                    companyIntroduction:companyIntroduction,
                    page:page,
                    companyImg:imgURL,
                    createerPhone:createerPhone
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    $("#transfer-alert2").dialog('destroy');
                    $('#content').load("filter/member/companyShow");
                    if(data.message=="名称已被注册"){
                        alert("对不起，该名称已被注册！");
                    }else if(data.message=="已加入了公司，无法创建新的公司！"){
                        alert(data.message);
                    }else if(data.message=="成功"){
                        alert("创建成功");
                        var companyId=$("#companyId").val();
                        var userPhone=$("#userPhone").val();
                        var companyAddress=$("#companyAddress").val();
                        var companyName=$("#companyName").val();
                        var pagenum=$("#pagenum").val();
                        pagenum--;
                        $('#content').load("filter/member/companypageShow?companyId="+companyId+"&userPhone="+userPhone+"&companyAddress="+companyAddress+"&companyName="+companyName+"&page="+pagenum);
                    }else{
                        alert("创建失败");
                    }
                },
                error : function(data) {
                    alert("创建失败");
                }
            });

        }


    }




    comChangeSure=function(){
        var comId=$("#comId").val();
        var nickname=$("#nickname").val();
        var comName=$("#comName").val();
        var comAddress=$("#comAddress").val();
        var companyEmail=$("#comEmail").val();
        var companyPhone=$("#comPhone").val();
        var companyBusiness=$("#comBusiness").val();
        var companyIntroduction=$("#comIntroduction").val();
        $.ajax({
            url : 'filter/member/companyChangeInfo',
            type : 'POST',
            data : {
                comid:comId,
                nickname:nickname,
                companyName:comName,
                companyAddress:comAddress,
                companyEmail:companyEmail,
                companyPhone:companyPhone,
                companyBusiness:companyBusiness,
                companyIntroduction:companyIntroduction,
                page:page
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                $("#transfer-alert3").dialog('destroy');
                if(data.message=="名称已被注册"){
                    alert("对不起，该名称已被注册！");
                }else if(data.message=="成功"){
                    alert("修改成功");
                    var companyId=$("#companyId").val();
                    var userPhone=$("#userPhone").val();
                    var companyAddress=$("#companyAddress").val();
                    var companyName=$("#companyName").val();
                    var pagenum=$("#pagenum").val();
                    pagenum--;
                    $('#content').load("filter/member/companypageShow?companyId="+companyId+"&userPhone="+userPhone+"&companyAddress="+companyAddress+"&companyName="+companyName+"&page="+pagenum);
                }else{
                    alert("修改失败");
                }
            },
            error : function(data) {
                alert(data);
            }
        });

    }
    comChange=function(cid){
        var template = Handlebars.compile($("#template").html());
        comid=cid;
        $.ajax({
            url : 'filter/member/getCompanyInfo',
            type : 'POST',
            data : {
                cid : cid
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                $('#transfer-alert3').html(template(data.rows));
                $("#transfer-alert3").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false
                });
            },
            error : function(data) {
            }
        });

    }

    comDetails = function(companyId){
        $('#content').load("filter/member/companyDetailsShow",{"companyId":companyId});
    }
    $("#companyPhoneAdd").blur(function(){
        var regname = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/;
        if($(this).is("#companyPhoneAdd")){
            if(!regname.test(this.value)){
                $(this).siblings("span").show();
                alert("请输入正确格式的手机/座机号码");
            }else{
                $(this).siblings("span").hide();
            }
        }
    });
    $("#createerPhoneAdd").blur(function(){
        var regname = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
        if($(this).is("#createerPhoneAdd")){
            if(!regname.test(this.value)){
                $(this).siblings("span").show();
                alert("请输入正确格式的手机号码");
            }else{
                $(this).siblings("span").hide();
            }
        }
    });

    $("#comName").blur(function(){
        var regname =/^[a-zA-z][a-zA-Z0-9_]{2,9}$/;
        if($(this).is("#comName")){
            if(regname.test(this.value)){
                alert("请输入正确的姓名");
            }else{
            }
        }
    });
    $("#comPhone").blur(function(){
            var regphone = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
            if($(this).is("#comPhone")){
                if(!regphone.test(this.value)){
                    $(this).siblings("span").show();
                    alert("请输入正确格式的手机号码");
                }else{
                    $(this).siblings("span").hide();
                }
            }
        }
    );
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

    function showFileName(){
        var length = document.getElementById("file").files.length;
        for(var i=0;i<length;i++){
            var file = document.getElementById("file").files[i];
            $("#companyImg").val(file.name);
        }
    }
    $('#file').on('change', showFileName);
    memSearch1 = function(nomalCompanyId) {
        $('#content').load("filter/member/memberShow1?nomalCompanyId="+nomalCompanyId);
    }
    memSearch = function(nomalCompanyId) {
        $('#content').load("filter/member/memberShow?nomalCompanyId="+nomalCompanyId);
    }
    companyArea = function(companyId,companyName) {
        $('#content').load("filter/member/areaShow?companyId="+companyId+"&companyName="+companyName);
};


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
                url: 'filter/member/exportInfo',
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
