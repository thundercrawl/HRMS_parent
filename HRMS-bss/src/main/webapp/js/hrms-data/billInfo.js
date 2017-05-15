$(function(){
    $('#yearInput').datetimepicker('setStartDate', new Date());
    $('#yearInput').on("click",function () {
        $(this).datetimepicker({
            format: 'Y',
            autoclose: true,
            minView: 4,
            startView:4,
            linkField: "yearInput",
            linkFormat: "Y",
            minuteStep:1,

            inputMask: true
        })
    })
    $('#yearInput').on("blur",function () {
        $(this).datetimepicker("remove")
    })

    $("#forSearch").on("click",function () {
        var year = $('#yearInput').val();

        $.ajax({
            url : '/filter/data/searchBill',
            type : 'POST',
            data : {
                "year":year
            },
            cache : false,
            dataType : 'json',
            success : function(data) {
                if(data.code == "0000"){
                    setEcharts(data.data);
                }else {
                    alert("查询数据失败");
                }
            },
            error : function (data) {
                alert("网络错误");
            }
        })

    })


    function  setEcharts(signDate1) {

        var signDate = $.parseJSON(signDate1);

        var month_1 = signDate.month_1;
        var month_2 = signDate.month_2;
        var month_3 = signDate.month_3;
        var month_4 = signDate.month_4;
        var month_5 = signDate.month_5;
        var month_6 = signDate.month_6;
        var month_7 = signDate.month_7;
        var month_8 = signDate.month_8;
        var month_9 = signDate.month_9;
        var month_10 = signDate.month_10;
        var month_11 = signDate.month_11;
        var month_12 = signDate.month_12;

        var signArray = new Array();
        var baseWage = new Array();
        var subsidy = new Array();
        var subsidyIns = new Array();
        var leaveDeduction = new Array();
        var businessSubsidy = new Array();
        var signDeduction = new Array();
        var subBill = new Array();
        var count = 0;

        if(month_1.hasBill == 1){
            signArray[count] ="1月";
            baseWage[count] =month_1.baseWage;
            subsidy[count] =month_1.subsidy;
            subsidyIns[count] =month_1.subsidyIns;
            leaveDeduction[count] =month_1.leaveDeduction;
            businessSubsidy[count] =month_1.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_2.hasBill == 1){
            signArray[count] ="2月";
            baseWage[count] =month_2.baseWage;
            subsidy[count] =month_2.subsidy;
            subsidyIns[count] =month_2.subsidyIns;
            leaveDeduction[count] =month_2.leaveDeduction;
            businessSubsidy[count] =month_2.businessSubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_3.hasBill == 1){
            signArray[count] ="3月";
            baseWage[count] =month_3.baseWage;
            subsidy[count] =month_3.subsidy;
            subsidyIns[count] =month_3.subsidyIns;
            leaveDeduction[count] =month_3.leaveDeduction;
            businessSubsidy[count] =month_3.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_4.hasBill == 1){
            signArray[count] ="4月";
            baseWage[count] =month_4.baseWage;
            subsidy[count] =month_4.subsidy;
            subsidyIns[count] =month_4.subsidyIns;
            leaveDeduction[count] =month_4.leaveDeduction;
            businessSubsidy[count] =month_4.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_5.hasBill == 1){
            signArray[count] ="5月";
            baseWage[count] =month_5.baseWage;
            subsidy[count] =month_5.subsidy;
            subsidyIns[count] =month_5.subsidyIns;
            leaveDeduction[count] =month_5.leaveDeduction;
            businessSubsidy[count] =month_5.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_6.hasBill == 1){
            signArray[count] ="6月";
            baseWage[count] =month_6.baseWage;
            subsidy[count] =month_6.subsidy;
            subsidyIns[count] =month_6.subsidyIns;
            leaveDeduction[count] =month_6.leaveDeduction;
            businessSubsidy[count] =month_6.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_7.hasBill == 1){
            signArray[count] ="7月";
            baseWage[count] =month_7.baseWage;
            subsidy[count] =month_7.subsidy;
            subsidyIns[count] =month_7.subsidyIns;
            leaveDeduction[count] =month_7.leaveDeduction;
            businessSubsidy[count] =month_7.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_8.hasBill == 1){
            signArray[count] ="8月";
            baseWage[count] =month_8.baseWage;
            subsidy[count] =month_8.subsidy;
            subsidyIns[count] =month_8.subsidyIns;
            leaveDeduction[count] =month_8.leaveDeduction;
            businessSubsidy[count] =month_8.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_9.hasBill == 1){
            signArray[count] ="9月";
            baseWage[count] =month_9.baseWage;
            subsidy[count] =month_9.subsidy;
            subsidyIns[count] =month_9.subsidyIns;
            leaveDeduction[count] =month_9.leaveDeduction;
            businessSubsidy[count] =month_9.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_10.hasBill == 1){
            signArray[count] ="10月";
            baseWage[count] =month_10.baseWage;
            subsidy[count] =month_10.subsidy;
            subsidyIns[count] =month_10.subsidyIns;
            leaveDeduction[count] =month_10.leaveDeduction;
            businessSubsidy[count] =month_10.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_11.hasBill == 1){
            signArray[count] ="11月";
            baseWage[count] =month_11.baseWage;
            subsidy[count] =month_11.subsidy;
            subsidyIns[count] =month_11.subsidyIns;
            leaveDeduction[count] =month_11.leaveDeduction;
            businessSubsidy[count] =month_11.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }
        if(month_12.hasBill == 1){
            signArray[count] ="12月";
            baseWage[count] =month_12.baseWage;
            subsidy[count] =month_12.subsidy;
            subsidyIns[count] =month_12.subsidyIns;
            leaveDeduction[count] =month_12.leaveDeduction;
            businessSubsidy[count] =month_12.businesssubsidy;
            signDeduction[count] =month_1.signDeduction;
            subBill[count] = month_1.subBill;
            count ++;
        }

        var option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['基本工资','补贴','五险一金','请假扣除款','出差补贴款','考勤扣除款','总额']
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: true},
                    magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : signArray
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:'基本工资',
                    type:'line',
                    stack: '总量',
                    data:baseWage
                },
                {
                    name:'补贴',
                    type:'line',
                    stack: '总量',
                    data:subsidy
                },
                {
                    name:'五险一金',
                    type:'line',
                    stack: '总量',
                    data:subsidyIns
                },
                {
                    name:'请假扣除款',
                    type:'line',
                    stack: '总量',
                    data:leaveDeduction
                },
                {
                    name:'出差补贴款',
                    type:'line',
                    stack: '总量',
                    data:businessSubsidy
                },
                {
                    name:'考勤扣除款',
                    type:'line',
                    stack: '总量',
                    data:signDeduction
                }
                ,
                {
                    name:'总额',
                    type:'line',
                    stack: '总量',
                    data:subBill
                }
            ]
        };
        var myChart =echarts.init(document.getElementById('billChart'));
        myChart.setOption(option);
    }

});
