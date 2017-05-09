$(function(){
    $('#monthParam').datetimepicker({
        format: 'Y-m',
        autoclose: true,
        minView: 0,
        linkField: "monthParam",
        linkFormat: "Y-m",
        minuteStep:1,
        minView:3,
        startView:3,
        inputMask: true
    });

    /*查询*/
    $('#forBillSearch').on('click',function(){
        var date = $("#monthParam").val();
        var userName = $("#userNameInput").val();
        var userPhone = $("#userPhoneInput").val();
        var orgName = $("#orgNameInput").val();
        $('#content').load("filter/wage/searchFinanceBillIndex?date="+date+"&userName="+userName
            +"&userPhone="+userPhone+"&orgName="+orgName, function(){
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
