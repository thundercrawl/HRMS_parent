<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">科目配置</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<div class="box-content">
						<div>
							<form id="query_item_fr">
								<div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">科目名称</span> <input type="text"
											class="form-control" placeholder="科目名称" id="item_name"
											name="walletItemName">
									</div>
									
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">科目创建时间</span> <input
											type="text" class="form-control reDatetimepicker"
											id="item_time" name="createTime">
									</div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">是否允许退款 </span> <select
											class="form-control" name="refundStatus" id="item_refund"><option
												value=""></option>
											<option value="">全部</option>
											<option value="0">否</option>
											<option value="1">是</option>
										</select>
									</div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">是否允许提现 </span> <select
											class="form-control" name="withdrawStatus" id="item_wihdraw"><option
												value=""></option>
											<option value="">全部</option>
											<option value="0">否</option>
											<option value="1">是</option>
										</select>
									</div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">是否允许转账 </span> <select
											class="form-control" name="transferStatus" id="item_transfer"><option
												value=""></option>
											<option value="">全部</option>
											<option value="0">否</option>
											<option value="1">是</option>
										</select>
									</div>
									<div class="input-group col-md-1 colLee" style="display: inline-table;">
										<a class="btn btn-primary"
											id="query_wallet_item" style="border-radius: 4px;">查询
										</a>
									</div>
									<div class="input-group col-md-1 colLee" style="display: inline-table;">
						<a href="javaScript:void(0);" class="btn btn-primary shiny"
							id="add_walletItem">添加</a>
					</div>
								</div>
							</form>

						</div>
					</div>
					
					<input type="hidden" value="" id="wallt_item_ip">
					<div id="wallet_item_info">
						<jsp:include page="walletItem.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/walletitem/walletItemfirst.js"></script>