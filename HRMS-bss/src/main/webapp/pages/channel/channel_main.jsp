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
							<form id="query_my_channel">
							<input name="page" value="${paginator.page}" id="channelCurpage" type="hidden">
								<div>
									
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">渠道名称</span> <input type="text"
											class="form-control" placeholder="渠道名称"
											name="channelName" maxlength="32">
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">联系电话</span> <input type="text"
											class="form-control" placeholder="联系电话"
											name="channelPhone" maxlength="32">
									</div>
									<div class="input-group col-md-3" style="display: inline-table;">
										<span class="input-group-addon">渠道类型</span> <select
											class="form-control" name="type">
											<option value="0">全部</option>
											<option value="1">中介</option>
											<option value="2">第三方团体</option>
											<option value="3">第三方个人</option>
											<option value="4">内部员工</option>
										</select>
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">起始时间</span> <input
											type="text" class="form-control reDatetimepicker" 
											name="createStartTime" ReadOnly="true">
									</div>
									<div class="input-group col-md-3"	style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">结束时间</span> 
										<input	type="text" class="form-control reDatetimepicker"
											 name="createEndTime" ReadOnly="true">
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">渠道状态 </span> <select
											class="form-control" name="status">
											<option value="0">全部</option>
											<option value="1">正常</option>
											<option value="2">失效</option>
										</select>
									</div>
									<div class="input-group col-md-1 colLee" style="display: inline-block;">
										<a class="btn btn-primary "
											id="query_my_channel" style="border-radius: 4px;">查询
										</a>
									</div>
									<div class="input-group col-md-1 colLee">
						<a href="javaScript:void(0);" class="btn btn-primary shiny"
							id="add_channel_info">添加</a>
					</div>
								</div>
							</form>		
					<input type="hidden" value="" id="query_info_channel">	
					<div id="channel_info_de" style="margin-top: 8px;">
						<jsp:include page="../channel/channel_list.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!--添加渠道 开始  -->
<div id="add_Pdialog_pro" style="display: none;">
	<form action="" style="margin-right: 30px;">
		<table>
			<tr>
			</tr>
			<tr>
				<td>渠道名称</td>
				<td><input type="text" id="channel_Name" maxlength="32"  placeholder="必填"/> <span
					id="spanchannel_Name"
					style="display: none; color: red; font-size: 8px">X</span></td>
			</tr>
			<tr>
				<td>渠道联系电话</td>
				<td><input type="text" id="channel_phone" maxlength="32"  placeholder="必填"/> <span
					id="spanchannel_phone"
					style="display: none; color: red; font-size: 12px">X</span></td>
			</tr>
			<!-- <tr>
				<td>渠道联系人</td>
				<td><input type="text" id="channel_phone" maxlength="32"  placeholder="必填"/> <span
					id="spanchannel_phone"
					style="display: none; color: red; font-size: 12px">X</span></td>
			</tr>
			<tr>
				<td>渠道联系人电话</td>
				<td><input type="text" id="linkman_phone" maxlength="32"  placeholder="必填"/> <span
					id="spanlinkman_phone"
					style="display: none; color: red; font-size: 12px">X</span></td>
			</tr> -->
			<tr>
				<td>渠道邮箱</td>
				<td><input type="text" id="channel_Email" maxlength="120" placeholder="必填"/> <span
					id="spanchannel_Email"
					style="display: none; color: red; font-size: 12px">X</span></td>
			</tr>
			<tr>
				<td>渠道地址</td>
				<td><input type="text" id="channel_Address" maxlength="120" placeholder="选填"/> <span
					id="spanchannel_Address"
					style="display: none; color: red; font-size: 12px">X</span></td>
			</tr>
			
			<!-- <tr>
				<td>营业执照编号</td>
				<td><input type="text" id="product_Desc" maxlength="120" /> <span
					id="spanproduct_Desc"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr> -->
			<tr>
				<td>备注</td>
				<td><input type="text" id="channel_remark" maxlength="128" placeholder="选填"/> <span
					id="spanchannel_remark"
					style="display: none; color: red; font-size: 12px">X</span></td>
			</tr>
			<tr>
				<td>类型</td>
				<td><select type="select" id="channel_Type">
						<option value="1">中介</option>
						<option value="2">第三方团体</option>
						<option value="3">第三方个人</option>
						<option value="4">内部员工</option>
						<%-- <c:forEach items="${projectList}" var="projec">
							<option value="${projec.projectId }">
								${projec.projectName }</option>
						</c:forEach> --%>
				</select>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary"	id="formcheck_product_sure">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return_product_esc">取消</a>
	</div>
</div>
<!--添加渠道结束-->

<script src="${ctx }/js/pagination.js"></script>
<script src="${ctx }/js/channel/channel.js"></script>
