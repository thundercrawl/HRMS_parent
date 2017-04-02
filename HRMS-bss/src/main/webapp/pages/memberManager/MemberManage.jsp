<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
	<script src="js/virtualMember/virtualMember.js" charset="UTF-8"></script>
<script src="js/handlebars-v2.0.0.js"></script>
<div class="widget-body">
<div>
<button type="button" class="btn-blue" id="memberCreate">创建会员</button>
<button type="button" class="btn-blue" id="companyCreate">创建公司</button>
<div class="alert" id="transfer-alert">
			<div class="alert-content backlog-alert">
				会员名字：<input type="text" id="memberName"><br>
				会员账号：<input type="text" id="memberNum">
				<button type="button" class="btn-blue"  id="memCreSure">确定</button><br>
				<button type="button" class="btn-blue"  id="memCreQuit">取消</button>
			</div>
		</div>	
<div class="alert" id="transfer-alert2">
			<div class="alert-content backlog-alert">
				公司名字：<input type="text" id="companyName"><br>
				公司账号：<input type="text" id="companyNum">
				<button type="button" class="btn-blue" id="comCreSure">确定</button><br>
				<button type="button" class="btn-blue" id="comCreQuit">取消</button>
			</div>
		</div>	
</div>
<div id="memSchid">
<input type="text" id="memNum">
<i class="glyphicon glyphicon-zoom-in icon-white" id="forMemSearch"></i>
<div>
<table  class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
	<thead>
		<tr>
			<th>会员账号</th>
			<th>名称</th>
			<th>等级</th>
			<th>操作</th>
		</tr>
	</thead>
			<tbody id="memSchBody">
			
			</tbody>
		</table>
		</div>
</div>
<div id="virtualShow">
		<table data-ajaxurl="/firter/order/all/{p}" class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
	<thead>
		<tr>
		<th>虚拟会员账号</th>
			<th>虚拟会员ID</th>
			<th>权限</th>
			<th>操作</th>
		</tr>
	</thead>
			<tbody id="vmem">
			
			</tbody>
		</table>
		</div>
	<div role="grid" id="simpledatatable_wrapper"
		class="dataTables_wrapper form-inline no-footer">
		
		<div class="row DTTTFooter">
			<div class="col-sm-6">
				<div class="dataTables_info" id="simpledatatable_info" role="alert"
					aria-live="polite" aria-relevant="all"></div>
			</div>
			<div class="col-sm-6">
				<!-- <div class="dataTables_paginate paging_bootstrap"
					id="simpledatatable_paginate">
					<ul class="pagination">
						<li class="prev disabled"><a href="#">Prev</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li class="next"><a href="#">Next</a></li>
					</ul>
				</div> -->
			</div>
		</div>
	</div>
			<div class="col-sm-6">
				<div class="dataTables_info" id="simpledatatable_info" role="alert"
					aria-live="polite" aria-relevant="all"></div>
			</div>
			<div class="col-sm-6">
				<!-- <div class="dataTables_paginate paging_bootstrap"
					id="simpledatatable_paginate">
					<ul class="pagination">
						<li class="prev disabled"><a href="#">Prev</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li class="next"><a href="#">Next</a></li>
					</ul>
				</div> -->
			</div>
		</div>
	</div>
<script id="virtualMem" type="text/x-handlebars-template">
   {{#each this}}
<tr>
				<td>{{imgUrl}}</td>
				<td>{{name}}</td>
				<td>{{address}}</td>
				<td>{{address}}</td>
			</tr>
   {{/each}}
</script>
<script id="memsch" type="text/x-handlebars-template">
   {{#each this}}
<tr>
				<input type="hidden" id="hideUse" value="{{imgUrl}}">
				<td>{{imgUrl}}</td>
				<td>{{name}}</td>
				<td>{{address}}</td>
				<td><input type="button" id="prohibition" value="禁用" onclick="prohibition()">
					<input type="button" id="unprohibition" value="解禁"></td>
			</tr>
   {{/each}}
</script>
<script type="text/javascript">
var virtualMem = Handlebars.compile($("#virtualMem").html());
var memsch = Handlebars.compile($("#memsch").html());
</script>
