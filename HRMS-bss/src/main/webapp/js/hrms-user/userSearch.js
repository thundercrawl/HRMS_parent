$(function(){
    $('#forUserSearch').on('click',function(){
        var userID = $("#userID").val();
        var userName = $("#userName").val();
        var userPhone = $("#userPhone").val();
        var orgName = $("#orgName").val();
        var jobName = $("#jobName").val();
        $('#companySearchCondition').val($('#forid').serialize());
       /* $('#tid').load("filter/user/searchUserIndex",$('#forid').serialize());*/
        var pagenum=$("#pagenum").val();
        pagenum--;
        $('#content').load("filter/user/searchUserIndex?userID="+userID+"&userName="+userName+"&userPhone="+userPhone+"&orgName="+orgName+"&jobName="+jobName+"&page="+pagenum);
    })
});
