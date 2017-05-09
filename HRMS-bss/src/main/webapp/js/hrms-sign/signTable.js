$(function() {
    /*查找所在部门*/
    $('.searchUser').on('click',function () {
        var userName = $(this).attr("data-userName");
        $('#content').load("filter/user/searchUserIndex?userName="+userName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
});
