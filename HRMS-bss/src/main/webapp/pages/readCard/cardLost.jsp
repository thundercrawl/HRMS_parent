<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="reader-btn card-lost">
	<form class="form-horizontal clearfix col-md-12" id="foridLost">
		<div class="col-sm-4">
			<input type="text" class="form-control input-md" placeholder="用户名"
				name="userName">
		</div>
		<div class="col-sm-2">
			<button type="button" class="btn btn-info" id="lostOrderSearch">查询</button>
		</div>
	</form>
	<input type="hidden" value="" id="lostOrderSearchCondition">
	<div id="tid">
		<jsp:include page="cardLostTable.jsp"></jsp:include>
	</div>

	<p>注：请勾选需要挂失的信息。</p>
	<button class="btn btn-info" id="revoke">挂失</button>
</div>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/readCard/readCard.js"></script>
<script src="js/readCard/lostCard.js"></script>
<script src="js/pagination.js"></script>