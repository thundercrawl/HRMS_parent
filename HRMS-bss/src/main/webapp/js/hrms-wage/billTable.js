$(function(){
    $('.showDetail').on('click',function () {
        var billId = $(this).attr("data-billId");
        $('#content').load("filter/wage/showBillMessageFinance?billId="+billId);
    })
})