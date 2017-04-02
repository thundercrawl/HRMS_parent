<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">费率配置</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll; min-height: 320px;">
				<div>
							<form id="query_rate_fr">
								<div>
									<!-- 						<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;"> -->
									<!-- 							<span class="input-group-addon">编码</span> -->
									<!-- 							<input type="text" class="form-control" placeholder="编码" id="rate_code" name="code"> -->
									<!-- 						</div> -->
									<div class="input-group col-md-3"
										style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">名称</span> <input type="text"
											class="form-control" placeholder="名称" id="rate_name"
											name="rateName" maxlength="20">
									</div>
									<!-- <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">单价</span>
							<input type="number" class="form-control" placeholder="单价" id="rate_price" name="ratePriceFee" maxlength="20">
						</div> -->
									<div class="input-group col-md-3"
										style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">计费单元</span> <select
											type="select" class="form-control" id="rate_unit" name="unit"><option>
											</option>
											<option value="0">年</option>
											<option value="1">月</option>
											<option value="2">周</option>
											<option value="3">天</option>
											<option value="2">小时</option>
										</select>
									</div>
									<div class="input-group col-md-1 colLee" style="display: inline-block;">
										<a class="btn btn-primary" id="query_rate">查询
										</a>
									</div>
									<div class="input-group col-md-1 colLee">
						<a href="javaScript:void(0);" class="btn btn-primary shiny"
							id="add_rate">添加</a>
						<!--           <a href="javaScript:void(0);" class="btn btn-primary shiny" id="pl_delete">批量删除</a> -->
					</div>
								</div>
					
					<input type="hidden" value="" id="projectable_ip">
					<div id="projectable_rate" style="margin-top: 8px;">
						
						<jsp:include page="configuration.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!--/span-->

</div>
<script src="js/pagination.js"></script>
<script src="js/tariff/ratefir.js"></script>
