<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>                                                                                           
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>                                                                                                                  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                                                                                                                 
<div>                                                                                                                                                                            
		<ul class="breadcrumb">                                                                                                                                                      
			<li><a href="javaScript:void(0);">公司账单</a></li>                                                                                                                        
		</ul>                                                                                                                                                                        
</div>                                                                                                                                                                           
<div class="row">                                                                                                                                                                
	<div class="box col-md-12">                                                                                                                                                    
		<div class="box-inner">                                                                                                                                                      
			<div class="box-header well" data-original-title=""></div>                                                                                                                 
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">                                                                                                    
				<div>                                                                                                                                           
				<form action="">                                                                                                                                                         
				<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">公司名称</span>   
                      <input type="hidden" value="" id="hiddencompa">  
                       <input type="hidden" value="" id="hiddencompaid">                                                                                                              
                    <input type="text" class="form-control" placeholder="请输入公司名" id="companyname" value="${companyName}">    
                  </div>                                                                                                                                                         
				  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">手机号码</span>   
                      <input type="hidden" value="" id="hiddencompa">  
                       <input type="hidden" value="" id="hiddencompaid">                                                                                                              
                    <input type="text" class="form-control" placeholder="请输入手机号码" id="userPhone" value="${userPhone}">    
                  </div> 
				    <%-- <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">姓名</span>   
                      <input type="hidden" value="" id="hiddencompa">  
                       <input type="hidden" value="" id="hiddencompaid">                                                                                                              
                    <input type="text" class="form-control" placeholder="请输入姓名" id="userName" value="${userPhone}">    
                  </div>  --%>
				  <div class="input-group col-md-1 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" onclick="findAccounts()">查询</a>  
		<!--   <a href="javaScript:void(0);" class="btn btn-primary" onclick="findFirstAccounts()">查询首付款</a> -->  
	</div>
	<div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="closeCompanyAccount()">结账</a> 
	</div>
						                                                                                                                          
                                                          
                                                                                                                                                                                 
				</form>                                                                                                                                                                  
					<div id="fourm_table" style="margin-top: 8px;">                                                                                                                     
						<jsp:include page="companyAccount.jsp"></jsp:include>                                                                                                             
					</div>                                                                                                                                                                 
				</div>                                                                                                                                                                   
			</div>                                                                                                                                                                     
		</div>                                                                                                                                                                       
	</div>                                                                                                                                                                         
	<!--/span-->                                                                                                                                                                   
                                                                                                                                                                                 
</div>                                                                                                                                                                           
<!--/row-->                                                                                                                                                                      
<script src="js/pagination.js"></script>                                                                                                                                         
<script src="js/closeAccount/showCompanyAccount.js"></script>                                                                                                                                