<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>                                                                                           
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>                                                                                                                  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>                                                                                                                 
<div>                                                                                                                                                                            
		<ul class="breadcrumb">                                                                                                                                                      
			<li><a href="javaScript:void(0);">帖子管理</a></li>                                                                                                                        
		</ul>                                                                                                                                                                        
</div>                                                                                                                                                                           
<div class="row">                                                                                                                                                                
	<div class="box col-md-12">                                                                                                                                                    
		<div class="box-inner">                                                                                                                                                                                                              
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">                                                                                                    
				<div>                                                                                                                                           
				<form action="">                                                                                                                                                         
				<div class="input-group col-md-4" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">帖子标题</span>                                                                                                              
                    <input type="text" class="form-control" placeholder="请输入帖子标题" id="forumtitle" value="${forumtitle}">                                                  
                  </div>                                                                                                                                                         
				<div class="input-group col-md-4" style="margin: 2px 0;display: inline-table;">                                                                                          
                    <span class="input-group-addon">公司名称</span>                                                                                                              
                    <input type="text" class="form-control" placeholder="请输入公司名" id="companyname" value="${companyname}">                                                  
                  </div>                                                                                                                                                         
                  <div class="input-group col-md-4" style="margin: 2px 0;display: inline-table;">                                                                                
                    <span class="input-group-addon">用户名</span>                                                                                                                
                    <input type="text" class="form-control" placeholder="请输用户昵称" id="username" value="${username}">                                                        
                  </div>                                                                                                                                                         
<div class="input-group col-md-4" style="margin: 2px 0;display: inline-table;">                                                                                                  
							<span class="input-group-addon">发帖时间</span>                                                                                                                    
							<input type="text" class="form-control form_datetime" style="width: 50%;" readOnly="true"  placeholder="选择起始时间" id="datetimepickerfrom" value="${fromtime}"/>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readOnly="true"  placeholder="选择终止时间" id="datetimepickerto" value="${totime}"/>    
						</div>                                                                                                                                                               
<%-- <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">                                                                                                  
                    <span class="input-group-addon">订单编号</span>                                                                                                              
                    <input type="text" class="form-control" value="${orderid}" placeholder="请输入订单编号" id="ordernumber" >                                                   
                  </div>    --%>                                                                                                                                                      
                                                                                                                                                                                 
<div style="margin: 2px 0;display: inline-table;" class="input-group col-md-3">                                                                                                  
							<span class="input-group-addon">帖子状态</span>                                                                                                                    
							       <select name="unit" id="forumstatus" class="form-control" type="select" >                                                                                
							       <c:if test="${status==4||status==null}">  
							      		<option value="4">全部</option>                                                                                                                     
							       		<option value="0">删除</option>                                                                                                                           
                                        <option value="1">正常</option>                                                                                                          
                                     	<option value="2">锁定</option>                                                                                                          
                                     	<option value="3">草稿</option>                                                                                                         
							       </c:if>                                                                                                                                                     
							       <c:if test="${status==1}">                                                                                                                                  
                                        <option value="1">正常</option> 
                                        <option value="0">删除</option>                                                                                                        
                                     	<option value="2">锁定</option>                                                                                                          
                                     	<option value="3">草稿</option>                                                                                                               
                                    	<option value="4">全部</option>                                                                                                           
							       </c:if>                                                                                                                                                     
							       <c:if test="${status==2}">                                                                                                                                  
                                     	<option value="2">锁定</option> 
                                     	<option value="0">删除</option>                                                                                                           
                                        <option value="1">正常</option>                                                                                                            
							      		<option value="3">草稿</option>                                                                                                                           
							        	<option value="4">全部</option>                                                                                                                         
							       </c:if>                                                                                                                                                     
							       <c:if test="${status==3}">     
							       		<option value="3">草稿</option>  
							       		<option value="0">删除</option>                                                                                                                             
                                        <option value="1">正常</option> 
                                     	<option value="2">锁定</option>                                                                                                          
                                    	<option value="4">全部</option>                                                                                                           
							       </c:if>        
							        <c:if test="${status==0}">     
							        	<option value="0">删除</option>                                                                                                                               
                                        <option value="1">正常</option> 
                                     	<option value="2">锁定</option>                                                                                                          
                                     	<option value="3">草稿</option>                                                                                                               
                                    	<option value="4">全部</option>                                                                                                           
							       </c:if>                                                                                                                                                           
                                                 </select>                                                                                                                       
						                      </div>                                                                                                                                         
<div style="margin: 2px 0;display: inline-table;" class="input-group col-md-3">                                                                                                  
							<span class="input-group-addon">帖子类型</span>                                                                                                                    
							       <select name="unit" id="forumtype" class="form-control" type="select" >                                                                                  
								<c:if test="${type==1}">                                                                                                                                         
								<option value="1">普通贴</option>                                                                                                                                
								<option value="2">投票贴</option>                                                                                                                                
								<option value="3">活动帖</option>                                                                                                                                
								<option value="4">全部</option>                                                                                                                                  
								</c:if>                                                                                                                                                          
								<c:if test="${type==2}">                                                                                                                                         
								<option value="2">投票贴</option>                                                                                                                                
								<option value="1">普通贴</option>                                                                                                                                
								<option value="3">活动帖</option>                                                                                                                                
								<option value="4">全部</option>                                                                                                                                  
								</c:if>                                                                                                                                                          
								<c:if test="${type==3}">                                                                                                                                         
								<option value="3">活动帖</option>                                                                                                                                
								<option value="1">普通贴</option>                                                                                                                                
								<option value="2">投票贴</option>                                                                                                                                
								<option value="4">全部</option>                                                                                                                                  
								</c:if>                                                                                                                                                          
								<c:if test="${type==4||type==null}">                                                                                                                                      
								<option value="4">全部</option>                                                                                                                                  
								<option value="1">普通贴</option>                                                                                                                                
								<option value="2">投票贴</option>                                                                                                                                
								<option value="3">活动帖</option>                                                                                                                                
								</c:if>                                                                                                                                                          
							</select>                                                                                                                                                          
						                      </div>                                                                                                                                         
                                                     
                                                     <div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="findFourms()">查询</a> 
	</div>                                                                                                                            
                                                             
                  <!-- <a href="javaScript:void(0);" class="btn btn-primary" id="deletefourms" style="margin-top: -30px;">删除</a>       -->                                           
                                                                                                                                                                                 
				</form>                                                                                                                                                                  
					<div id="fourm_table" style="margin-top: 4px;">                                                                                                                     
						<jsp:include page="manageForum.jsp"></jsp:include>                                                                                                             
					</div>                                                                                                                                                                 
				</div>                                                                                                                                                                   
			</div>                                                                                                                                                                     
		</div>                                                                                                                                                                       
	</div>                                                                                                                                                                         
	<!--/span-->                                                                                                                                                                   
                                                                                                                                                                                 
</div>                                                                                                                                                                           
<!--/row-->                                                                                                                                                                      
<script src="js/pagination.js"></script>                                                                                                                                         
<script src="js/forum/manageForum.js"></script>                                                                                                                                