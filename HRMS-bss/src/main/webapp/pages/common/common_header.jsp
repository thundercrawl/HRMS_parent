<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<!-- topbar starts -->
<div id="open-win" class="open-win" style="display:none">
	<div class="open-win-bg">
    	<div class="open-floor"> 
            <p class="online-active">已有上线活动，是否继续上线？</p>
            <div class="circle-btn">
                <button class="btn-imsure">确定</button>
                <button class="btn-imcancer">取消</button>
            </div>
        </div>
    </div>
    <input type="hidden" id="windowId" />
</div>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand"  href="filter/view/index"> <img
			alt="Charisma Logo" src="plugin/img/logo20.png" class="hidden-xs" />
			<span>人力资源管理</span></a>
    </div>

	  <div id="transfer-updatePwd" style="display: none;">
		  <form class="user-form user-form1 user-info" id="companyId1"
				method="post" action="" style="margin-left: 25px;margin-bottom: 20px"  enctype="multipart/form-data">
			  <div>
				  <label for="oldPwd">旧密码:</label> <input type="text"
															 id="oldPwdInput" /><span id="oldPwdspan">密码格式错误</span>
			  </div>
			  <div>
				  <label for="newPwd">新密码:</label> <input type="text"
															 id="newPwdInput" /> <span id="pwdspan">密码格式错误</span>
			  </div>
			  <div>
				  <label for="newPwd2">再次输入:</label> <input type="text"
														  id="newPwd2Input" />
			  </div>
			  <input type="button" disabled="disabled" id="updatePwdSure" value="确认"/>
			  <input type="button" id="updatePwdCancel" value="取消"/>
		  </form>

	  </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
       
			    <li><a class="ajax-link mytop" href="filter/personal/showAdminPwd" id="userinfo" >个人资料</a></li>
				<%--<li><a class="ajax-link mytop" href="javaScript:void(0);" id="updatePwd">修改密码</a></li>--%>
				<li><a calss="ajax-link mytop" href="login/logout" id="logout">注销</a></li>
			
      </ul>
    </div>
  </div>
</nav>

<!-- topbar ends -->
<div class="ch-container">
	<div class="row" style="min-height: 500px;">

		<!-- left menu starts -->
		<div class="col-sm-2 col-lg-2 out-l">
			<div class="sidebar-nav" style="min-height: 450px;">
				<div class="nav-canvas">
					<div class="nav-sm nav nav-stacked"></div>
					
					<ul class="nav nav-pills nav-stacked main-menu">
						<li><a class="ajax-link" href="filter/user/getAllUser"><span>用户管理</span></a></li>
						<li><a class="ajax-link" href="filter/org/getAllOrg"><span> 部门管理</span></a></li>
						<li><a class="ajax-link" href="filter/sign/getAllSign"><span> 考勤管理</span></a></li>
						<li class="accordion"><a href="#"><span>请假出差管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/leave/getAllLeaves">请假管理</a>
								<li><a class="ajax-link" href="filter/leave/getAllBusiness">出差管理</a>
								<li><a class="ajax-link" href="filter/leave/getAllApproves">审批管理</a></li>
							</ul>
						</li>
						<li class="accordion"><a href="#"><span>薪资管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="/filter/wage/getAllBills">个人薪资</a>
								<li><a class="ajax-link" href="/filter/wage/getAllWages">财务管理</a>
								<li><a class="ajax-link" href="/filter/wage/getAllFinanceBills">账单管理</a></li>
							</ul>
						</li>
						<li class="accordion"><a href="#"><span>统计数据</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="/filter/data/getSign">考勤统计</a>
								<li><a class="ajax-link" href="/filter/data/getBill">财务统计</a>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!--/span-->
		<!-- left menu ends -->

		<noscript>
			<div class="alert alert-block col-md-12">
				<h4 class="alert-heading">Warning!</h4>

				<p>
					You need to have <a href="http://en.wikipedia.org/wiki/JavaScript"
						target="_blank">JavaScript</a> enabled to use this site.
				</p>
			</div>
		</noscript>
