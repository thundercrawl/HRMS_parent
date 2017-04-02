<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">在租产品</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div >
				<form action="" id="assetform">
				   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">订单编号</span>
                     <input type="text" class="form-control" placeholder="订单编号" id="orderNo" name="orderNo" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;">
                   </div>
                    <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">项目名称</span>
                     <input type="text" class="form-control" placeholder="项目名称" id="projectName" name="projectName" readonly="true">
                      <input type="hidden" id="findprojectid" name="projectId" value="0">
                     <ul class="project_ul" id="project_ul"></ul>
                   </div>
                    <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">资产类型</span>
                     <input type="text" class="form-control" placeholder="资产类型" id="productName" name="productName" readonly="true">
                      <input type="hidden" id="assetType" name="assetType" value="${assetType }">
                     <ul class="project_ul" id="product_ul">
                     <li data-id='1'>移动商务舱</li>
                     <li data-id='2'>会议室</li>
                     <li data-id='3'>办公室</li>
                     </ul>
                   </div>
				   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">在租公司</span>
                     <input type="text" class="form-control" placeholder="在租公司" id="companyName" name="companyName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;">
                   </div>
                    <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                     <span class="input-group-addon">在租人姓名</span>
                     <input type="text" class="form-control" placeholder="在租人姓名" id="userName" name="userName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;">
                   </div>
                  <div class="input-group col-md-1 colLee" >
                    <a href="javaScript:void(0);" class="btn btn-primary" id="findasset">查询</a>
                  </div>
				</form>
				<input type="hidden" id="formParam" value>
					<div id="projectable_asset" style="margin-top: 8px;">
						<jsp:include page="asset.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<script src="js/project/asset.js"></script>
<script src="js/pagination.js"></script>