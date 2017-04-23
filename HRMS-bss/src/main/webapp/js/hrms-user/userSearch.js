$(function(){
    $('#forUserSearch').on('click',function(){
        var userID = $("#userID").val();
        var userName = $("#userName").val();
        var userPhone = $("#userPhone").val();
        var orgName = $("#orgName").val();
        var jobName = $("#jobName").val();
        $('#companySearchCondition').val($('#forid').serialize());
        $('#tid').load("filter/user/searchUser",$('#forid').serialize(), function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
});
