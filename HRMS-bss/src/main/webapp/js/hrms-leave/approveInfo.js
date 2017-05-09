$(function(){
    /*查询*/
    $('#forApproveSearch').on('click',function(){
        var leaveCode = $("#leaveCode").val();

        $('#content').load("filter/leave/searchApproveIndex?leaveCode="+leaveCode, function(){
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
