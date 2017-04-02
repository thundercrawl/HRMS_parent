<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">储物柜在租记录</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">大储物柜编号</span> <input type="text"
								class="form-control" placeholder="请输入大储物柜编号" id="code"
								value="${code}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">小储物柜编号</span> <input type="text"
								class="form-control" placeholder="请输入小储物柜编号"
								id="cabinetdetailid" value="${cabinetdetailid}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">公司名称</span> <input type="text"
								class="form-control" placeholder="请输入公司名称" id="companyname"
								value="${companyname}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">会员名称</span> <input type="text"
								class="form-control" placeholder="请输入会员名称" id="username"
								value="${username}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">所属项目</span> <select name="unit"
								id="projectid" class="form-control" type="select">
								<c:if test="${projectid==null||projectid==''}">
									<option value="">全部</option>
									<c:forEach items="${projectlist}" var="p">
										<option value="${p.projectid}">${p.projectname}</option>
									</c:forEach>
								</c:if>
								<c:if test="${projectid!=null&&projectid!=''}">
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid==projectid}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid!=projectid}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<option value="">全部</option>
								</c:if>
							</select>
						</div>
					<%-- 	<div class="input-group col-md-5"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">租用时间</span> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择起始时间"
								id="datetimepickerstartfrom" value="${fromstarttime}" /> <input
								type="text" class="form-control form_datetime"
								style="width: 50%;" readOnly="true" placeholder="选择结束时间"
								id="datetimepickerstartto" value="${tostarttime}" />
						</div> --%>
						<!--                   <div class="input-group col-md-5" style="margin: 2px 0;display: inline-table;"> -->
						<!-- 							<span class="input-group-addon">到期时间</span> -->
						<%-- 							<input type="text" class="form-control form_datetime" style="width: 50%;" readOnly="true"  placeholder="选择到期时间" id="datetimepickerend" value="${endtime}"/> --%>
						<!-- 						</div> -->
						
						
						<div class="input-group col-md-1 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary"
						onclick="findcabinetshire()" style="margin-left: 14px;">查询</a>
	</div>
					</form>
					
					<div id="cabinet_table" style="margin-top: 8px;">
						<jsp:include page="cabinethire.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
