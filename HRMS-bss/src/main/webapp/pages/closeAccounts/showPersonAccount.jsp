<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>                                                                                           
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>                                                                                                                  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>         
<div>                                                                                                                                                                            
		<ul class="breadcrumb">                                                                                                                                                      
			<li><a href="javaScript:void(0);">个人账单</a></li>                                                                                                                        
		</ul>                                                                                                                                                                        
</div>                                                                                                                                                                           
<div class="row">                                                                                                                                                                
	<div class="box col-md-12">                                                                                                                                                    
		<div class="box-inner">                                                                                                                                                      
			<div class="box-header well" data-original-title=""></div>                                                                                                                 
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">                                                                                                    
				<div>                                                                                                                                           
				<form action="">                                                                                                                                                         
				<%-- <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">帖子标题</span>                                                                                                              
                    <input type="text" class="form-control" placeholder="请输入帖子标题" id="forumtitle" value="${forumtitle}">                                                  
                  </div>            --%>                                                                                                                                              
				<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">公司名称</span>   
                    <input type="text" class="form-control" placeholder="请输入公司名" id="companyname" value="${companyName}">     
                    <input type="hidden" value="" id="hiddenperson">                                             
                  </div>                                                                                                                                                         
				  <input type="text" hidden="true" value="${companyName}" id="company">
				 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">手机号</span>   
                    <input type="text" class="form-control" placeholder="请输入手机号" id="userPhone" value="">    
                  </div>                                                                                                                                                        
				  <input type="text" hidden="true" value="${phone}" id="phone">
				  <div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="finduserprder">查询</a>    
	</div>
							                                                                                                                                                      
                                                          
<!--                   <a href="javaScript:void(0);" class="btn btn-primary" onclick="closeCompanyAccount()" style="margin-top: -30px;">结账</a>   -->                                      
				</form>                                                                                                                                                                  
					<div id="fourm_table" style="margin-top: 8px;">                                                                                                                     
						<jsp:include page="personAccount.jsp"></jsp:include>                                                                                                             
					</div>                                                                                                                                                                 
				</div>                                                                                                                                                                   
			</div>                                                                                                                                                                     
		</div>                                                                                                                                                                       
	</div>                                                                                                                                                                         
	<!--/span-->                                                                                                                                                                   
                                                                                                                                                                                 
</div>                                                                                                                                                                           
<!--/row-->                                                                                                                                                                      
<script src="js/pagination.js"></script> 
