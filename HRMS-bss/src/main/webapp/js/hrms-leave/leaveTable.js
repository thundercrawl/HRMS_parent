$(function() {
    /*查找审批人*/
    $('.searchApproveUser').on('click',function () {
        var approveUserName = $(this).attr("data-param");
        $('#content').load("filter/user/searchUserIndex?userName="+approveUserName, function(){
            $('.pagination>li>a').on('click', pageFunc);
        });

    })
});
