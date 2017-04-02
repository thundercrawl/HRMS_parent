<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<div class="input-group col-md-1 colLee" style="display: inline-table;">
							<a class="btn btn-primary"  id="returnBtn">返回</a>
				            <input id="oldPage" type="hidden" value="${oldPage.page }">
				            <input id="orderId" type="hidden" value="${orderSearch.orderId }">
				            <input id="companyName" type="hidden" value="${orderSearch.companyName }">
				            <input id="userName" type="hidden" value="${orderSearch.userName }">
				            <input id="status" type="hidden" value="${orderSearch.status }">
				            <input id="orderStartTime" type="hidden" value="${orderSearch.orderStartTime }">
				            <input id="orderEndTime" type="hidden" value="${orderSearch.orderEndTime }">
				            <input id="returnMark" type="hidden" value="${returnMark }">
						</div>
						<div class="input-group col-md-1 colLee" style="display: inline-table;margin-right: 23px">
				            <a class="btn btn-primary"  id="assetManage">资产管理</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display: inline-table;">
				            <a class="btn btn-primary"  id="lookStageData">查看分期信息</a>
						</div>
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="orderDetail.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
