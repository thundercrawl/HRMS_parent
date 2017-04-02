<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">活动信息</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<div stle="width:100%;height:auto;">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">活动名称</span> <input type="text"
								class="form-control" placeholder="活动名称" id="findInput"
								name="findInput">
						</div>

						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">产品状态 </span> <select
								class="form-control" name="status" id="info_status">
								<option value="0"></option>
								<c:forEach items="${Edlist}" var="status">
									<option value="${status.typeNum}">${status.typeValue}
									</option>
								</c:forEach>
							</select>
						</div>

					</div>
					<span id="textspan"
						style="margin-top: -43px; margin-left: 6px; color: red; display: none;">请输入合法的活动名称</span>
				</div>

				<div stle="width:100%;height:auto;">
					<div class="input-group col-md-3"
						style="margin: 2px 0; display: inline-table;">
						<span class="input-group-addon">活动上线时间</span> <input type="text"
							class="form-control reDatetimepicker" id="onLineTime"
							name="validDate">
					</div>

					<div class="input-group col-md-3"
						style="margin: 2px 0; display: inline-table;">
						<span class="input-group-addon">活动下线时间</span> <input type="text"
							class="form-control reDatetimepicker" id="offLineTime"
							name="expireDate">
					</div>

					<div class="input-group col-md-1 colLee" style="display: inline-block;">
						<a class="btn btn-primary" id="findActivity"
							style="border-radius: 4px;"> 查询 </a>
					</div>
					<div class="input-group col-md-1 colLee" style="display: inline-block;">
						<a href="javaScript:void(0);" class="btn btn-primary shiny"
							id="addActivity">添加</a>
					</div>
				</div>
				<input type="hidden" id="formParam" value="" />
				<div id="activitytable" style="margin-top: 8px;">
					<jsp:include page="activity.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
</div>
<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/prize/activity.js"></script>
