<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">微信销售记录
		</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">销售员编号</span> <input type="text"
								class="form-control" placeholder="请输入销售员编号" id="salesman"
								value="${salesman}">
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block">
                     <a href="javaScript:void(0);" class="btn btn-primary"
						onclick="findwecmediarycustomer()" >查询</a>
                  </div>
                  <div class="input-group col-md-1 colLee" style="display:inline-block">
                      <a
						href="filter/wec/exportWecMediaryCustomer?salesman=${salesman}" class="btn btn-primary" 
						>导出</a>
                    </div>
						
					</form>
					
					<div id="wecmediarycustomer_table" style="margin-top: 8px;">
						<jsp:include page="wecmediarycustomer.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->

