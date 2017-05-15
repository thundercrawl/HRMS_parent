$(function(){
    var wageId;
    var userId;
    $('.updateWage').on('click',function () {
        wageId = $(this).attr("data-wageId");
        userId = $(this).attr("data-userId");

        $.ajax({
            url : '/filter/wage/findWageDetail',
            type : 'POST',
            data : {
                "userId":userId
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code=="0000"){
                    $('#baseWageInput').val(data.data.baseWage);
                    $('#subsidyPhoneInput').val(data.data.subsidyPhone);
                    $('#subsidyOtherInput').val(data.data.subsidyOther);
                    $('#subsidyOtherDescInput').val(data.data.subsidyOtherDesc);

                    $("#transfer-alertWage").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
                    });

                }else{
                    alert("查询用户信息失败"+data.message);
                }
            },
            error:function(data){
                alert("网络异常");
            }
        })

    })

    /*cancel*/
    $('#alterWageQuit').on('click', function() {
        $('#transfer-alertWage').dialog('destroy');
    });
    /*确认修改*/
    $('#alterWageSure').on('click', function() {
        var baseWage = $('#baseWageInput').val();
        var subsidyPhone = $('#subsidyPhoneInput').val();
        var subsidyOther = $('#subsidyOtherInput').val();
        var subsidyOtherDesc = $('#subsidyOtherDescInput').val();

        console.info("subsidyOtherDescInput:"+subsidyOtherDesc);

        var sure=confirm("请确认修改信息:基本工资="+baseWage+",话费补贴="+subsidyPhone+",其他补贴="+subsidyOther);
        if(sure){
            $.ajax({
                url : '/filter/wage/updateUserWage',
                type : 'POST',
                data : {
                    "baseWage":baseWage,
                    "subsidyPhone":subsidyPhone,
                    "subsidyOther":subsidyOther,
                    "subsidyOtherDesc":subsidyOtherDesc,
                    "wageId":wageId
                },
                cache : false,
                dataType : 'json',
                success : function(data) {
                    if(data.code=="0000"){
                        alert("调整用户薪资成功");
                        $('#transfer-alertWage').dialog('destroy');
                        $('#content').load("filter/wage/getAllWages",$('#forid').serialize(), function(){
                            $('.pagination>li>a').on('click', pageFunc);
                        });
                    }else{
                        alert("调整用户薪资失败"+data.message);
                    }
                },
                error:function(data){
                    alert("网络异常");
                }
            });
        }
    });
})