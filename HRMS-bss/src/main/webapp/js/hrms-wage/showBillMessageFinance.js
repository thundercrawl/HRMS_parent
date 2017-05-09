$(function(){
    $('#prevision').on('click',function () {
        $('#content').load("filter/wage/getAllFinanceBills", function(){
            $('.pagination>li>a').on('click', pageFunc);
        });
    })
})