<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="reader-btn card-lost">

	<h4 claclass="font-bold">卡号：${cardcode}</h4>


	<table class="table" id="my-table">
		<thead>
			<tr>
				<th></th>
				<th>卡号</th>
				<th>门号</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="tid">

		</tbody>
	</table>

	<p>注：解绑后此条信息将删除，请谨慎操作。</p>
	<button class="btn btn-primary" id="resove">解绑</button>
</div>
<script id="cardRecord" type="text/x-handlebars-template">
{{#each this}}
<tr>
<td>
									<div class="checkbox">
										<label>
											<input type="checkbox" id="blankCheckbox" value="{{doorCardId}}" name="tt" class="checkTt" aria-label="...">
										</label>
									</div>
								</td>	
					<td>
						{{cardCode}}
					</td>
					<td>{{doorId}}</td>
					<td>{{startTime}}</td>
					<td>{{endTime}}</td>
					<td></td>
				</tr>
{{/each}}
</script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/readCard/resoveCard.js"></script>
