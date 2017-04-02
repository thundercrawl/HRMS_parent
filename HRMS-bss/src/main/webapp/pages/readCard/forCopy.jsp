<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>读卡挂失</title>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
</head>

<body>
	<div class="reader-btn card-lost">
		<form class="form-horizontal clearfix col-md-12">
			<div class="col-sm-4">
				<input type="email" class="form-control input-md" id="inputEmail3" placeholder="输入订单号">
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-info">查询</button>
			</div>
		</form>


		<table class="table" id="my-table">
			<thead>
				<tr>
					<th>手机号</th>
					<th>姓名</th>
					<th>门的名称</th>
					<th>终端名称</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						13313331333
					</td>
					<td>箴言</td>
					<td>中汇3号</td>
					<td>终端一号</td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<p>注：请勾选需要挂失的信息。</p>
		<button class="btn btn-info">挂失</button>
	</div>
</body>

</html>