<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <script src="js/configManage/sysAssetConfig.js"></script>
<script src="js/pagination.js"></script>
<div>
	<ul class="breadcrumb">
		<li><a href="javascript:volid(0);" style="text-decoration:none;">系统管理/资产参数配置/资产等级</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form id="queryForm">
						<div class="input-group col-md-3" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">资产等级编号</span>
							<input type="text" class="form-control" placeholder="资产等级编号" id="rankId" name="rankId">
						</div>
						<!-- <div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">操作员</span>
							<input type="text" class="form-control" placeholder="操作员" id="paramNameInput" name="productName">
						</div> -->
						<div class="input-group col-md-5" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">创建时间</span>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readonly placeholder="选择起始时间" id="fromTime" name="fromTime"/>
							<input type="text" class="form-control form_datetime" style="width: 50%;" readonly placeholder="选择终止时间" id="toTime" name="toTime"/>
						</div>
						<%-- <div class="input-group col-md-2" style="display: inline-table;">
							<span class="input-group-addon">资产类型</span>
							<input type="hidden" class="form-control" placeholder="订单状态" id="orderStatus" value="0" name="orderStatus">
							<div class="btn-group form-control" style="padding: 0;">
							<button type="button" class="btn btn-default form-control dropdown-toggle"
								 data-toggle="dropdown"><span>所有</span><span class="caret" style="margin-left: 5px;"></span></button>
							   <ul class="dropdown-menu" role="menu" id="orderStatusUl">
							   	<c:forEach items="${statusMap }" var="status">
							   		<li data-value="${status.key }"><a>${status.value }</a></li>
							   	</c:forEach>
							   </ul>
							</div>
						</div>
						<div class="input-group col-md-2" style="display: inline-table;">
							<span class="input-group-addon">资产等级</span>
							<input type="hidden" class="form-control" placeholder="订单状态" id="orderStatus" value="0" name="orderStatus">
							<div class="btn-group form-control" style="padding: 0;">
							<button type="button" class="btn btn-default form-control dropdown-toggle"
								 data-toggle="dropdown"><span>所有</span><span class="caret" style="margin-left: 5px;"></span></button>
							   <ul class="dropdown-menu" role="menu" id="orderStatusUl">
							   	<c:forEach items="${statusMap }" var="status">
							   		<li data-value="${status.key }"><a>${status.value }</a></li>
							   	</c:forEach>
							   </ul>
							</div>
						</div> --%>
						<%-- <div class="input-group col-md-2" style="display: inline-table;">
							<span class="input-group-addon">订单状态</span>
							<input type="hidden" class="form-control" placeholder="订单状态" id="orderStatus" value="0" name="orderStatus">
							<div class="btn-group form-control" style="padding: 0;">
							<button type="button" class="btn btn-default form-control dropdown-toggle"
								 data-toggle="dropdown"><span>所有</span><span class="caret" style="margin-left: 5px;"></span></button>
							   <ul class="dropdown-menu" role="menu" id="orderStatusUl">
							   	<c:forEach items="${statusMap }" var="status">
							   		<li data-value="${status.key }"><a>${status.value }</a></li>
							   	</c:forEach>
							   </ul>
							</div>
						</div> --%>
						<div class="input-group col-md-1 colLee" style="display: inline-table;">
							<a class="btn btn-primary" id="queryBtn">查询</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display: inline-table;">
							<a class="btn btn-primary" id="addParam">增加</a>
						</div>
					</form>
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="sysAssetConfig.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="forMessage" value="${message}"/>
	<!--/span-->
</div>
<!--/row-->
