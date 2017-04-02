$(function(){
	$('.editPsw').on('click',function(){
		var adminPwd=$('#newPsw').val();
		$('#page-body').load("filter/personal/updatePsw?adminPwd="+adminPwd);
	});
	  $("#oldPsw").blur(function(){
          var oldPsw=$("#oldPsw").val();
          $.ajax({
              url:"filter/personal/checkPsw",
              data:{
            	  oldPsw:oldPsw
            	  }, 
              cache : false,
      		  dataType : 'json',
              success:function(data){
            	  if(data.message==1)
            		  $("#oldPswSpan").html("<font color=\"green\" size=\"2\">  密码正确</font>");
            	  else
            		  $("#oldPswSpan").html("<font color=\"#FF6A6A\" size=\"2\">  密码错误</font>");
                    
                  },
              error : function(data) {
      			}
          });
     });
	  $("#newPsw").blur(function(){
		  var newPsw=$("#newPsw").val();
          var num=$("#newPsw").val().length;
          var oldPsw=$("#oldPsw").val();
          if(oldPsw==newPsw){
        	  $("#newPswSpan").html("<font color=\"#FF6A6A\" size=\"2\">  密码不能与原密码相同</font>");        
          }else{
          if(num<6){
               $("#newPswSpan").html("<font color=\"#FF6A6A\" size=\"2\">  密码过短</font>");                
          }else{
          if(num>18){
               $("#newPswSpan").html("<font color=\"#FF6A6A\" size=\"2\">  密码过长</font>");                 
          }else{
              $("#newPswSpan").html("<font color=\"green\" size=\"2\"> 密码可用</font>");                
          }}}
      }) ;
	  $("#newPsw1").blur(function(){
          var tmp=$("#newPsw").val();
          var num=$("#newPsw1").val().length;
          if($("#newPsw1").val()!=tmp){
              $("#newPsw1Span").html("<font color=\"#FF6A6A\" size=\"2\">  和上面不一致</font>");                 
          }
          else{
              if(num>=6&&num<=18){
                  $("#newPsw1Span").html("<font color=\"green\" size=\"2\">  输入正确</font>");                    
              }                 
              else{
                  $("#newPsw1Span").html("<font color=\"#FF6A6A\" size=\"2\">  输入错误</font>");                           
              }                
          }
      });
	  $("#reback").on('click',function(){
		  var pageString=$("#pageString").val();
		  $('#page-body').load("filter/personal/"+pageString);
	  })
})
