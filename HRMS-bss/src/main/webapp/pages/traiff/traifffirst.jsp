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
			<div class="box-content" style="overflow-x: scroll; min-height: 320px;">
				<div>
							<form id="query_item_fr">
								<div>
									<div class="input-group col-md-3"
										style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">科目名称</span> <input type="text"
											class="form-control" placeholder="科目名称" id="item_name"
											name="name" maxlength="20">
									</div>
									<div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
										<span class="input-group-addon">科目类别</span> <select
											type="select" class="form-control" name="type"
											id="item_type_find"><option value=""></option>
											<c:forEach items="${itemtype }" var="itype">
												<option value="${itype.typeNum }">${itype.typeValue }</option>
											</c:forEach>
										</select>
									</div>
									<div class="input-group col-md-1 colLee">
										<a class="btn btn-primary" id="query_item">查询</a>
									</div>
									<div class="input-group col-md-1 colLee">
										<a href="javaScript:void(0);" class="btn btn-primary" id="add_Project">添加</a>
									</div>
								</div>
							</form>

					<input type="hidden" value="" id="query_item_ip">
					<div id="projectable_item" style="margin-top: 8px;">
						<input type="hidden" value="${page }" id="curPage" name="curPage">
						<jsp:include page="trariff.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/tariff/tariffer.js"></script>
