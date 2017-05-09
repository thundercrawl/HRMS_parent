$(function(){
    $('#updatePwd').on('click',function(){
        $("#transfer-updatePwd").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false
        });
    })

    $('#updatePwdCancel').on('click',function(){
        $("#transfer-updatePwd").dialog("destroy");
    })

    $('#updatePwdSure').on('click',function () {
        var oldPwd = $('#oldPwdInput').val();
        var newPwd = $('#newPwdInput').val();
        var newPwd2 = $('#newPwd2Input').val();

        var check = true;

        if(oldPwd == null || oldPwd == "" ||
        newPwd == null || newPwd == "" ||
        newPwd2 == null || newPwd2 == ""){
            alert("请输入完整信息！")
            check = false;
        }
        if(check){
            if(confirm("确认修改密码？")){
                $.ajax({
                    url : '/filter/personal/updatePwd',
                    type : 'POST',
                    data : {
                        oldPwd:oldPwd,
                        newPwd:newPwd
                    },
                    cache : false,
                    dataType : 'json',
                    success : function(data) {
                        $("#transfer-alert2").dialog('destroy');
                        if(data.code != "0000"){
                            alert("修改密码失败:"+data.message);
                        }else {
                            alert("修改密码成功");
                        }
                    },
                    error : function(data) {
                        alert("修改密码失败");
                    }
                })
            }
        }
    })

    $('#oldPwd').blur(function () {
        var regPwd = /^[a-zA-Z0-9]{6,16}$/;
        if($(this).is("#oldPwdInput")){
            if(!regPwd.test(this.value)){
                $(this).siblings("span").show();
            }else{
                $(this).siblings("span").hide();
            }
        }
    })
    $('#newPwd').blur(function () {
        var regPwd = /^[a-zA-Z0-9]{6,16}$/;
        if($(this).is("#newPwdInput")){
            if(!regPwd.test(this.value)){
                $(this).siblings("span").show();
            }else{
                $(this).siblings("span").hide();
            }
        }
    })
    $('#newPwd2').blur(function () {
        if(! $(this).is("#newPwd2Input").equals($('#newPwdInput').val())){
            if(!regphone.test(this.value)){
                $(this).siblings("span").val("两次输入的密码不一致")
                $(this).siblings("span").show();
            }else{
                $(this).siblings("span").hide();
            }
        }
    })

});
