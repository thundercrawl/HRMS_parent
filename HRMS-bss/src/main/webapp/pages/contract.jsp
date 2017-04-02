<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />
<head lang="zh">
<title>登录界面</title>

<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<!-- <script type="text/javascript" src="js/main.js"></script> -->
	<link rel="stylesheet" href="css/contract/style.css">
	<link rel="stylesheet" href="fonts/iconfont.css">
	<link rel="stylesheet" href="css/jquery/jquery.datetimepicker.css">
	<link rel="stylesheet" href="css/contract/color.css">
	<!-- <script src="js/jquery-1.10.2.min.js"></script> -->
	<script src="js/main.js"></script>
	<script src="js/jquery/jquery.datetimepicker.js"></script>
</head>

<body>
	<div class="rent-box">
		<div class="rent-contract">
			<h1>租赁合同(线下)</h1>
			<div class="rent-con">
				<p>
					<span>供应方(甲方)</span>上海办伴科技发展有限公司
				</p>
				<p>
					<span>承租方(乙方)</span>上海亚飞咨询服务有限公司
				</p>
				<p>
					<span>合同编号</span>NO.00001
				</p>
				<p>
					<span>租赁周期</span>2016-01-01~2016-12-31
				</p>
				<p>
					<span>合同签订日期</span>015/12/1
				</p>
				<p>
					<span>付款周期</span>押三附一
				</p>
			</div>

			<div class="rent-con">
				<p class="rent-w">甲方</p>
				<p>
					<span>联系人</span>张三
				</p>
				<p>
					<span>电话</span>021-64890000
				</p>
				<p>
					<span>职位</span>销售总监
				</p>
				<p>
					<span>邮箱</span>zhangsan@distrii.com
				</p>
				<p class="rent-w">
					<span>账单地址</span>上海市闸北区长安路1000号恒丰商务大厦18楼A座
				</p>
			</div>


			<div class="rent-con">
				<p class="rent-w">乙方</p>
				<p>
					<span>联系人</span>李四
				</p>
				<p>
					<span>电话</span>021-64890000
				</p>
				<p>
					<span>职位</span>行政
				</p>
				<p>
					<span>邮箱</span> 1300210021@139.com
				</p>
				<p class="rent-w">
					<span>账单地址</span>上海市闸北区长安路1000号恒丰商务大厦18楼A座
				</p>
			</div>

			<div class="rent-con rent-p">
				<p>
					上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座 上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座
				</p>
			</div>

			<div class="rent-con">
				<h2>租赁产品</h2>
				<table class="rentbox">
					<tr>
						<th>项目</th>
						<th>产品名称</th>
						<th>单价</th>
						<th>数量</th>
						<th>租赁周期</th>
						<th>租金</th>
					</tr>
					<tr>
						<td rowspan="6" valign="top">苏河一号</td>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(6人)</td>
						<td>12000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td rowspan="2" valign="top">陆家嘴一号</td>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>智慧包+B档(5人)</td>
						<td>388元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>1940元/月</td>
					</tr>
					<tr>
						<td colspan="6"></td>
					</tr>
					<tr>
						<td rowspan="3" valign="top"></td>
						<td>跨点折扣(若有)</td>
						<td></td>
						<td></td>
						<td></td>
						<td>2% off</td>
					</tr>
					<tr>
						<td>组合折扣(若有)</td>
						<td></td>
						<td></td>
						<td></td>
						<td>2% off</td>
					</tr>
					<tr>
						<td>销售员折扣(若有)</td>
						<td></td>
						<td></td>
						<td></td>
						<td>3% off</td>
					</tr>

				</table>
			</div>

		</div>

		<div class="rent-contract">

			<div class="rent-con">
				<h2>租赁产品</h2>
				<table class="rentbox">
					<tr>
						<th>项目</th>
						<th>产品名称</th>
						<th>单价</th>
						<th>数量</th>
						<th>租赁周期</th>
						<th>租金</th>
					</tr>
					<tr>
						<td rowspan="6" valign="top">苏河一号</td>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(6人)</td>
						<td>12000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td rowspan="2" valign="top">陆家嘴一号</td>
						<td>独立办公室AOO1(5人)</td>
						<td>10000元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>10000元/月</td>
					</tr>
					<tr>
						<td>智慧包+B档(5人)</td>
						<td>388元/月</td>
						<td>1</td>
						<td>2016-01-01~2016-03-31</td>
						<td>1940元/月</td>
					</tr>
					<tr>
						<td colspan="6"></td>
					</tr>
					<tr>
						<td rowspan="3" valign="top"></td>
						<td>跨点折扣(若有)</td>
						<td></td>
						<td></td>
						<td></td>
						<td>2% off</td>
					</tr>
					<tr>
						<td>组合折扣(若有)</td>
						<td></td>
						<td></td>
						<td></td>
						<td>2% off</td>
					</tr>
					<tr>
						<td>销售员折扣(若有)</td>
						<td></td>
						<td></td>
						<td></td>
						<td>3% off</td>
					</tr>
				</table>
			</div>
			
			<div class="rent-con rent-p">
				<p>
					上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座 上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座上海市闸北区长安路1000号恒丰商务大厦18楼A座
				</p>
			</div>

			<div class="rent-con rent-f">
				<h2>首付款</h2>
				<p>月租金<span>47883.6</span></p>
				<p>智慧包租金<span>5208</span></p>
				<p>安装费<span>143651</span></p>
				<p>押金<span>合计：197452</span></p>
			</div>

			<div class="rent-con signature">
				<p>
					<span>Authorizing Party's Authorized Representative</span>授权方(供应方)授权代表
				</p>
				<p>
					<span>Authorized Party's Authorized Representative</span>被授权方(供应方)授权代表
				</p>
			</div>

			<div class="rent-con signature">
				<p>
					Position职位
				</p>
				<p>
					Position职位
				</p>
			</div>

			<div class="rent-con signature">
				<p>
					signature and Seal 签署及盖章
				</p>
				<p>
					signature and Seal 签署及盖章
				</p>
			</div>
		</div>

	</div>
</body>

</html>