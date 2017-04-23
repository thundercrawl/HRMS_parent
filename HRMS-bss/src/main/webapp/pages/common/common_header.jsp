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

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
       
			    <li><a class="ajax-link mytop" href="filter/personal/userinfo" id="userinfo" >个人资料</a></li>
				<li><a class="ajax-link mytop" href="filter/personal/forgetPsw" id="forgetPsw">忘记密码</a></li>
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
						<li><a class="ajax-link" href="filter/user/getAllUser" id="getAllUser"><span>用户管理</span></a></li>
						<li class="accordion"><a class="ajax-link" href="#"><span id="memberManager"> 客户关系管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" id="forCompany" href="filter/member/companyShow">公司管理</a></li>
								<li><a class="ajax-link" href="filter/member/memberShow" id="forSearch">会员管理</a></li>
								<!-- <li><a class="ajax-link" href="member/virMemberShow" id="virtualMemberManager">虚拟会员</a></li>
								<li><a class="ajax-link" href="filter/complaintAndSuggestions/home">投诉与建议</a></li> -->
								<li><a class="ajax-link" href="filter/secContact/contactManager" id="forContact">客户联系人管理</a></li>
                            </ul>		
						</li>
						<li class="accordion"><a href="#"><span> 用户管理</span></a>
							<ul class="nav nav-pills nav-stacked">
                                <li><a class="ajax-link" href="filter/bssuser/bssuser" id="bssUser"><span> 用户管理</span></a></li>
                                <li><a class="ajax-link" href="filter/bssuser/userRole" id="userRole">角色管理</a></li>
                                <li><a class="ajax-link" href="filter/bssuser/power" id="install">权限管理</a></li>
                                <li><a class="ajax-link" href="filter/bssuser/organ" id="org">组织管理</a></li>
                            </ul>
						</li>

						<li class="accordion"><a href="#"><span> 系统管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/configManage/sysParamCofigPage" id="sysParamConfig"><span> 系统参数配置</span></a></li>
								<li><a class="ajax-link" href="filter/configManage/sysBusinessCofigPage" id="sysBusinessConfig"><span> 业务相关配置</span></a></li>
								<li><a class="ajax-link" href="filter/configManage/ofcSpaceTypePage" id="ofcSpaceConfig">资产种类</a></li>
								<li><a class="ajax-link" href="filter/configManage/sysAssetCofigPage" id="sysAssetConfig">资产等级</a></li>
                            </ul>
						</li>
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
