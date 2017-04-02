<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">门卡授权记录</a></li>
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
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">订单编号</span> <input type="text"
								class="form-control" placeholder="请输入订单编号" id="orderid"
								value="${orderid}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">卡号</span> <input type="text"
								class="form-control" placeholder="请输入卡号" id="cardnumber"
								value="${cardnumber}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">门信息</span> <select name="unit"
								id="doorid" class="form-control" type="select">
								<c:if test="${doorid==null||doorid==''}">
									<option value="">全部</option>
									<c:forEach items="${doorlist}" var="p">
										<optgroup label="项目:${p.projectName}">
											<c:forEach items="${p.doorout}" var="d">
												<option value="${d.doorId}">楼层:${d.floorInfo}&nbsp;门牌号:${d.doorNumber}</option>
											</c:forEach>
										</optgroup>
									</c:forEach>
								</c:if>
								<c:if test="${doorid!=null&&doorid!=''}">
									<c:forEach items="${doorlist}" var="p">
										<c:forEach items="${p.doorout}" var="d">
											<c:if test="${d.doorId==doorid}">
												<option value="${d.doorId}" style="display: none;">楼层:${d.floorInfo}&nbsp;门牌号:${d.doorNumber}</option>
											</c:if>
										</c:forEach>
									</c:forEach>
									<c:forEach items="${doorlist}" var="p">
										<optgroup label="项目:${p.projectName}"></optgroup>
										<c:forEach items="${p.doorout}" var="d">
											<option value="${d.doorId}">楼层:${d.floorInfo}&nbsp;门牌号:${d.doorNumber}</option>
										</c:forEach>
									</c:forEach>
									<option value="">全部</option>
								</c:if>
							</select>
						</div>
						<div class="input-group col-md-5"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">使用时间</span> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择起始时间" id="datetimepickerfrom"
								value="${datetimepickerfrom}" /> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择终止时间" id="datetimepickerto"
								value="${datetimepickerto}" />
						</div>
						<div class="input-group col-md-5"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">授权时间</span> <input type="text"
								class="form-control form_datetime" style="width: 50%;"
								readOnly="true" placeholder="选择授权时间" id="datetimepickercreate"
								value="${datetimepickercreate}" />
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">公司</span> <select name="unit"
								id="companyid" class="form-control" type="select">
								<c:if test="${companyid==null||companyid==''}">
									<option value="">全部</option>
									<c:forEach items="${companylist}" var="p">
										<option value="${p.companyId}">${p.companyName}</option>
									</c:forEach>
								</c:if>
								<c:if test="${companyid!=null&&companyid!=''}">
									<c:forEach items="${companylist}" var="p">
										<c:if test="${p.companyId==companyid}">
											<option value="${p.companyId}">${p.companyName}</option>
										</c:if>
									</c:forEach>
									<c:forEach items="${companylist}" var="p">
										<c:if test="${p.companyId!=companyid}">
											<option value="${p.companyId}">${p.companyName}</option>
										</c:if>
									</c:forEach>
									<option value="">全部</option>
								</c:if>
							</select>
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">状态</span> <select name="unit"
								id="status" class="form-control" type="select">
								<c:if test="${status==null||status==''}">
									<option value="">全部</option>
									<option value="2">挂失或回收</option>
									<option value="4">已授权</option>
								</c:if>
								<c:if test="${status!=null&&status!=''}">
									<c:if test="${status==2}">
										<option value="2">挂失或回收</option>
										<option value="4">已授权</option>
										<option value="">全部</option>
									</c:if>
									<c:if test="${status==4}">
										<option value="4">已授权</option>
										<option value="2">挂失或回收</option>
										<option value="">全部</option>
									</c:if>
								</c:if>
							</select>
						</div>
						
						<div class="input-group col-md-1 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary"
						onclick="finddoorcard()" style="margin-left: 14px;">查询</a>
	</div>
						
					</form>
					
					<div id="cabinet_table" style="margin-top: 4px;">
						<jsp:include page="doorcard.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!--/row-->
<script src="js/pagination.js"></script>
