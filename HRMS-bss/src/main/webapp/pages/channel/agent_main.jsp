<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">${titleName }</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
							<form id="query_my_agent">
							<input name="page" value="${paginator.page}" id="agentCurpage" type="hidden" value="0">
								<div>
									
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">渠道名称</span> <input type="text"
											class="form-control" placeholder="渠道名称"
											name="channelName" maxlength="32">
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">经纪人/联系人姓名</span> <input type="text"
											class="form-control" placeholder="经纪人/联系人姓名" name="agentName" maxlength="32">
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">经纪人/联系人手机</span> <input type="text"
											class="form-control" placeholder="经纪人/联系人手机"
											name="agentPhone" maxlength="32">
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">经纪人/联系人编号</span> <input type="text"
											class="form-control" placeholder="经纪人/联系人编号"
											name="agentNumber" maxlength="32">
									</div>
									<!-- <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">经纪人状态 </span> <select
											class="form-control" name="status">
											<option value="0">全部</option>
											<option value="1">正常</option>
											<option value="2">失效</option>
										</select>
									</div> -->
									<div class="input-group col-md-1 colLee" style="display: inline-block;">
										<a class="btn btn-primary "
											id="query_my_agent_button" style="border-radius: 4px;">查询
										</a>
									</div>
								</div>
							</form>		
					<input type="hidden" value="" id="query_info_agent">	
					<div id="agent_info_de" style="margin-top: 8px;">
						<jsp:include page="../channel/agent_list.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<script src="${ctx }/js/pagination.js"></script>
<script src="${ctx }/js/channel/agent.js"></script>
