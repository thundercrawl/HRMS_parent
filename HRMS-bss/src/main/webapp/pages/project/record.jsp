<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScript:void(0);">租凭记录</a></li>
		</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form action="">
				  <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">项目名称</span>
                    <input type="text" class="form-control" placeholder="项目名称" id="orderId" name="orderId">
                  </div>
                  
                  <div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="findproject">查询</a>
	</div>
                  
				</form>
					<div id="recordtable" style="margin-top: 4px;">
						<jsp:include page="showRecord.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>