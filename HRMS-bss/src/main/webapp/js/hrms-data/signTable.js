$(function() {
    function setEcherts() {
        var signDate = $('#signDate').val();

        alert("1231233w:"+signDate);
        console.info(signDate);

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
        var normal = new Array();
        var leave = new Array();
        var business = new Array();
        var later = new Array();
        var early = new Array();
        var noSign = new Array();
        var count = 0;
        if(month_1.hasBill == 1){
            signArray[count] ="1月";
            normal[count] =month_1.normalCount;
            leave[count] =month_1.leaveCount;
            business[count] =month_1.businessCount;
            later[count] =month_1.laterCount;
            early[count] =month_1.earlyCount;
            noSign[count] =month_1.noSignCount;
            count ++;
        }
        if(month_2.hasBill == 1){
            signArray[count] ="2月";
            normal[count] =month_2.normalCount;
            leave[count] =month_2.leaveCount;
            business[count] =month_2.businessCount;
            later[count] =month_2.laterCount;
            early[count] =month_2.earlyCount;
            noSign[count] =month_2.noSignCount;
            count ++;
        }
        if(month_3.hasBill == 1){
            signArray[count] ="3月";
            normal[count] =month_3.normalCount;
            leave[count] =month_3.leaveCount;
            business[count] =month_3.businessCount;
            later[count] =month_3.laterCount;
            early[count] =month_3.earlyCount;
            noSign[count] =month_3.noSignCount;
            count ++;
        }
        if(month_4.hasBill == 1){
            signArray[count] ="4月";
            normal[count] =month_4.normalCount;
            leave[count] =month_4.leaveCount;
            business[count] =month_4.businessCount;
            later[count] =month_4.laterCount;
            early[count] =month_4.earlyCount;
            noSign[count] =month_4.noSignCount;
            count ++;
        }
        if(month_5.hasBill == 1){
            signArray[count] ="5月";
            normal[count] =month_5.normalCount;
            leave[count] =month_5.leaveCount;
            business[count] =month_5.businessCount;
            later[count] =month_5.laterCount;
            early[count] =month_5.earlyCount;
            noSign[count] =month_5.noSignCount;
            count ++;
        }
        if(month_6.hasBill == 1){
            signArray[count] ="6月";
            normal[count] =month_6.normalCount;
            leave[count] =month_6.leaveCount;
            business[count] =month_6.businessCount;
            later[count] =month_6.laterCount;
            early[count] =month_6.earlyCount;
            noSign[count] =month_6.noSignCount;
            count ++;
        }
        if(month_7.hasBill == 1){
            signArray[count] ="7月";
            normal[count] =month_7.normalCount;
            leave[count] =month_7.leaveCount;
            business[count] =month_7.businessCount;
            later[count] =month_7.laterCount;
            early[count] =month_7.earlyCount;
            noSign[count] =month_7.noSignCount;
            count ++;
        }
        if(month_8.hasBill == 1){
            signArray[count] ="8月";
            normal[count] =month_8.normalCount;
            leave[count] =month_8.leaveCount;
            business[count] =month_8.businessCount;
            later[count] =month_8.laterCount;
            early[count] =month_8.earlyCount;
            noSign[count] =month_8.noSignCount;
            count ++;
        }
        if(month_9.hasBill == 1){
            signArray[count] ="9月";
            normal[count] =month_9.normalCount;
            leave[count] =month_9.leaveCount;
            business[count] =month_9.businessCount;
            later[count] =month_9.laterCount;
            early[count] =month_9.earlyCount;
            noSign[count] =month_9.noSignCount;
            count ++;
        }
        if(month_10.hasBill == 1){
            signArray[count] ="10月";
            normal[count] =month_10.normalCount;
            leave[count] =month_10.leaveCount;
            business[count] =month_10.businessCount;
            later[count] =month_10.laterCount;
            early[count] =month_10.earlyCount;
            noSign[count] =month_10.noSignCount;
            count ++;
        }
        if(month_11.hasBill == 1){
            signArray[count] ="11月";
            normal[count] =month_11.normalCount;
            leave[count] =month_11.leaveCount;
            business[count] =month_11.businessCount;
            later[count] =month_11.laterCount;
            early[count] =month_11.earlyCount;
            noSign[count] =month_11.noSignCount;
            count ++;
        }
        if(month_12.hasBill == 1){
            signArray[count] ="12月";
            normal[count] =month_12.normalCount;
            leave[count] =month_12.leaveCount;
            business[count] =month_12.businessCount;
            later[count] =month_12.laterCount;
            early[count] =month_12.earlyCount;
            noSign[count] =month_12.noSignCount;
            count ++;
        }

        var option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['正常考勤','请假人数','出差人数','迟到人数','早退人数','缺勤人数']
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
                    name:'正常考勤',
                    type:'line',
                    stack: '总量',
                    data:normal
                },
                {
                    name:'请假人数',
                    type:'line',
                    stack: '总量',
                    data:leave
                },
                {
                    name:'出差人数',
                    type:'line',
                    stack: '总量',
                    data:business
                },
                {
                    name:'迟到人数',
                    type:'line',
                    stack: '总量',
                    data:later
                },
                {
                    name:'早退人数',
                    type:'line',
                    stack: '总量',
                    data:early
                },
                {
                    name:'缺勤人数',
                    type:'line',
                    stack: '总量',
                    data:noSign
                }
            ]
        };

        $('#signChart').setOption(option);
    }
});
