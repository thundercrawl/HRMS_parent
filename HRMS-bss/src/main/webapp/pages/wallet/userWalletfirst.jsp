<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">会员钱包查询</a></li>
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
							<form id="user_wallet_fr">
								<div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">会员名称</span> <input type="text"
											class="form-control" placeholder="公司名称" id="user_name"
											name="userName">
									</div>
									
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">科目名称</span> <input type="text"
											class="form-control" placeholder="科目名称" id="item_name"
											name="itemName">
									</div>
									
									<div class="input-group col-md-1 colLee" style="display: inline-block;">
										<a class="btn btn-primary"
											id="user_wallet_query" style="border-radius: 4px;"> 查询
										</a>
									</div>
								</div>
							</form>

						</div>
					</div>
					
					<input type="hidden" value="" id="user_wallet_ip">
					<div id="user_wallet_info">
						<jsp:include page="userWallet.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
