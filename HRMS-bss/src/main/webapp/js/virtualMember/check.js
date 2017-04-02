$(function() {

	tes=function(){
		var qq = document.getElementById("memberName").value;
		reg = /^[\u4E00-\u9FA5]{2,4}$/;

		if (!reg.test(qq)) {

			document.getElementById('t').innerHTML = '会员名应该2-4个中文！';

		} else {

			document.getElementById('t').innerHTML = '用户名符合规范！';

		}

	}

});