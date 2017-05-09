$(function(){
    $('#prevision').on('click',function () {
        $('#content').load("filter/wage/getAllBills", function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
})