<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">蓝牙开门记录</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="" id="forid">
					<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">会员名称</span> <input type="text"
								class="form-control" placeholder="请输入会员名全称" id="userName"
								value="${userName }">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">会员手机号</span> <input type="text"
								class="form-control" placeholder="请输入会员手机号" id="userPhone"
								value="${userPhone }">
						</div>
						
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">公司名称</span> <input type="text"
								class="form-control" placeholder="请输入公司名全称" id="companyName"
								value="${ companyName}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">门编号</span> <input type="text"
								class="form-control" placeholder="请输入完整门编号" id="doorName"
								value="${doorName }">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">所属项目</span> <select name="unit"
								id="project" class="form-control" type="select">
								<c:if test="${projectId==null||projectId==''}">
									<option value="">全部</option>
									<c:forEach items="${projectlist}" var="p">
										<option value="${p.projectid}">${p.projectname}</option>
									</c:forEach>
								</c:if>
								<c:if test="${projectId!=null&&projectId!=''}">
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid==projectId}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid!=projectId}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<option value="">全部</option>
								</c:if>
							</select>
						</div> 
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
						</div>
						
						<div class="input-group col-md-5"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">开门起止时间</span> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择起始时间" id="startTime"
								value="${startTime}" /> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择终止时间" id="endTime"
								value="${endTime}" />
						</div>  		
						
						
						<div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="findbluetooth"
						onclick="findbluetooth()" style="margin-left: 14px;">查询</a>
	</div>
						
					</form>
					<input type="hidden" value="" id="bluetoothCondition">
					<div id="cabinet_table" style="margin-top: 4px;">
						<jsp:include page="bluetoothdoor.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!--/row-->
<script src="js/pagination.js"></script>
