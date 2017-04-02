<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="">
                 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                  <span class="input-group-addon">会员编号</span>
                    <input type="text" class="form-control" placeholder="会员编号为纯数字" id="userId" name="userId">
                  </div> 
                  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">公司编号</span>
                    <input type="text" class="form-control" placeholder="公司编号" id="companyId" name="companyId">
                   </div>
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">提交时间</span>
                    <input type="text" class="form-control form_datetime" placeholder="查询起始时间" readOnly="true" style="width: 50%;" id="submitTime" name="submitTime" />
                    <input type="text" class="form-control form_datetime" placeholder="查询终止时间" readOnly="true" style="width: 50%;" id="endTime" name="endTime" />
                   </div>           
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                   <span class="input-group-addon">类型</span>
							       <select name="unit" id="complainType" name="complainType" class="form-control" type="select" value="${type}">
								<c:if test="${complainType==null||complainType==''}">
								<option value="0">全部</option>
							       <option value="1">投诉</option>
                                       <option value="2">建议</option>
							    </c:if>
								<c:if test="${complainType==1}">
							       <option value="1">投诉</option>
                                       <option value="2">建议</option>
							      <option value="0">全部</option>
							    </c:if>
							    <c:if test="${complainType==2}">
                                       <option value="2">建议</option>
							       <option value="1">投诉</option>
                                   <option value="0">全部</option>
							    </c:if>
							</select>
                 	</div>
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;"> 
                   <span class="input-group-addon">类型子类</span>
							       <select name="unit" id="complainTypeSub" name="complainTypeSub" class="form-control" type="select" >
								<c:if test="${complainTypeSub==null||complainTypeSub==''}">
								<option value="0">全部</option>
							       <option value="1">交通</option>
                                       <option value="2">住宿</option>
                                     <option value="3">工作环境</option>       
							    </c:if>
								<c:if test="${complainTypeSub==1}">
							       <option value="1">交通</option>
                                       <option value="2">住宿</option>
                                     <option value="3">工作环境</option>        
							       <option value="0">全部</option>
							    </c:if>
							    <c:if test="${complainTypeSub==2}">
                                       <option value="2">住宿</option>
							       <option value="1">交通</option>
                                     <option value="3">工作环境</option>       
                                      <option value="0">全部</option>
							    </c:if>
							    <c:if test="${complainTypeSub==3}">
                                     <option value="3">工作环境</option> 
							       <option value="1">交通</option>
                                       <option value="2">住宿</option>
                                     <option value="0">全部</option>
							    </c:if>
							</select>
                    </div>
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">状态</span>
							    <select name="unit" id="status" name="status" class="form-control" type="select" >
								<c:if test="${status==null||status==''}">
								<option value="0">全部</option>
							       <option value="1">未处理</option>
                                       <option value="2">处理中</option>
                                     <option value="3">已处理</option>       
							    </c:if>
								<c:if test="${status==1}">
							       <option value="1">未处理</option>
                                       <option value="2">处理中</option>
                                     <option value="3">已处理</option>
                                     <option value="0">全部</option>       
							    </c:if>
							    <c:if test="${status==2}">
                                       <option value="2">处理中</option>
							       <option value="1">未处理</option>
                                     <option value="3">已处理</option>
                                     <option value="0">全部</option>       
							    </c:if>
							    <c:if test="${status==3}">
                                     <option value="3">已处理</option>       
							       <option value="1">未处理</option>
                                       <option value="2">处理中</option>
							    	<option value="0">全部</option>
							    </c:if>
							</select>
                  </div>
                  
                  <div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="forSugSearch" onclick="findSuggestions()">查询</a>
                </div>
	
                 </form>
					<div id="complaintAndSuggestions" style="margin-top: 8px;">
						<jsp:include page="complaintAndSuggestions.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<script src="js/complaintAndSuggestions/complaintAndSuggestions.js"></script>
<script src="js/pagination.js"></script>
