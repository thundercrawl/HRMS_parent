$(function(){

    $('#yearInput').datetimepicker({
        format: 'Y',
        autoclose: true,
        minView: 4,
        startView:4,
        linkField: "yearInput",
        linkFormat: "Y-m",
        minuteStep:1,
        inputMask: true
    })

    $("#forSearch").on("click",function () {
        var year = $('#yearInput').val();

        $('#content').load("filter/data/getSign?year="+year);

    })


});
