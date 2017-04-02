function findwecmediarycustomer(){
	var exp=/^\d+$/;
	var s=$('#salesman').val();
	if(!exp.test(s)&&s!=null&&s!=''){
	    	alert("请输入数字");
	}else if(exp.test(s)||s==''||s==null){
	$('#content').load('filter/wec/WecMediaryCustomer?page=0&salesman='+s);
}}