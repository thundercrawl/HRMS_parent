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
<!-- <div class="navbar navbar-default" role="navigation">

	<div class="navbar-inner my-nav">
		<button type="button" class="navbar-toggle pull-left animated flip">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="filter/view/index"> <img
			alt="Charisma Logo" src="plugin/img/logo20.png" class="hidden-xs" />
			<span>办伴业务支撑系统</span></a>
		user dropdown starts
		<div class="btn-group pull-right">
			<button class="btn btn-default dropdown-toggle"
				data-toggle="dropdown">
				<i class="glyphicon "></i><span
					class="hidden-sm hidden-xs"> admin</span> <span class="caret"></span>
			</button>
			<ul class="dropdown-menu menu2">
			    <li><a class="ajax-link mytop" href="filter/personal/userinfo" id="userinfo" >个人资料</a></li>
				<li><a class="ajax-link mytop" href="filter/personal/forgetPsw" id="forgetPsw">忘记密码</a></li>
				<li><a>注销</a></li>
			</ul>
		</div>
		user dropdown ends
	</div>
</div> -->

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
					<li class="accordion"><a href="#"><span> 渠道管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/channel/jumpToAllChannel" id="jumpToAllChannel"><span>渠道管理</span></a></li>
								<li><a class="ajax-link" href="filter/channel/jumpToAllAgent" id="jumpToAllAgent"><span>经纪人/联系人管理</span></a></li>
                            	<li><a class="ajax-link" href="filter/channel/jumpToMyChannel" id="jumpToMyChannel"><span>我的渠道</span></a></li>
                            	<li><a class="ajax-link" href="filter/channel/jumpToMyAgent" id="jumpToMyAgent"><span>我的经纪人/联系人</span></a></li>
                            </ul>
						</li>
						<li class="accordion"><a class="ajax-link" id="offlineReserve" href="filter/offlineReserve/toOfflineReserve"><span> 线下预订</span></a></li>
						<li class="accordion"><a href="#"><span>订单管理</span></a>
						 <ul class="nav nav-pills nav-stacked">
                           <li><a class="ajax-link" href="filter/order/ofcOrderPage" id="orderManger">我的订单</a></li>
						  <li><a class="ajax-link"  href="filter/orderManage/ofcOrderPage">全部订单</a></li>
						 </ul>
						</li>
						<li class="accordion"><a href="#"><span> 合同管理</span></a>
							<ul class="nav nav-pills nav-stacked">
	                             <li><a class="ajax-link" href="filter/sys/contract/home" id="contract">合同管理</a></li>
	                             <li><a class="ajax-link" href="filter/wec/home" id="wec">微信销售记录</a></li>
                                <!-- <li><a class="ajax-link" href="filter/bookorder/gotoBookorder" id="billManger">账单查询</a></li> -->
                            </ul>
						</li>
						<li class="accordion"><a href="#"><span>账单管理</span></a>
						  <ul class="nav nav-pills nav-stacked">
						      <li><a class="ajax-link" href="filter/account/showCompanyAccount">公司账单</a>
						      <li><a class="ajax-link" href="filter/account/showPersonAccount">个人账单</a>
                              <li><a class="ajax-link" href="filter/bookorder/addBill" id="addBill">挂账</a></li>
                              <li><a class="ajax-link" href="filter/billSearch/showBill" id="showBill">查询挂账</a></li>
						      <li><a class="ajax-link" href="filter/deposit/home">订单押金</a></li>
						  </ul>
						</li> 
						<li class="accordion"><a class="ajax-link" href="#"><span id="memberManager"> 客户关系管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" id="forCompany" href="filter/member/companyShow">公司管理</a></li>
								<li><a class="ajax-link" href="filter/member/memberShow" id="forSearch">会员管理</a></li>
								<!-- <li><a class="ajax-link" href="member/virMemberShow" id="virtualMemberManager">虚拟会员</a></li>
								<li><a class="ajax-link" href="filter/complaintAndSuggestions/home">投诉与建议</a></li> -->
								<li><a class="ajax-link" href="filter/secContact/contactManager" id="forContact">客户联系人管理</a></li>
                            </ul>		
						</li>
						<li class="accordion"><a href="#"><span> 社区管理</span></a>
						  <ul class="nav nav-pills nav-stacked">
						      <li><a class="ajax-link" href="filter/forum/post">辅助发帖</a>
						      <li><a class="ajax-link" href="filter/forum/colation">敏感词配置</a>
						      <li><a class="ajax-link" href="filter/forum/manageForum">帖子管理</a>
						  </ul>
						</li> 
						<li class="accordion"><a href="#"><span> 资产管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/project/projectPlace" id="projectPlace"><span> 项目配置</span></a></li>
								<li><a class="ajax-link" href="filter/cad/main" id="cadConfig"><span> CAD配置</span></a></li>
                               <li><a class="ajax-link" href="filter/cad/look" id="cadLook"><span> CAD展示</span></a></li>
                                <li><a class="ajax-link" href="filter/project/meeting" id="meeting">会议室配置</a></li>
                                <li><a class="ajax-link" href="filter/project/office" id="office">办公室配置</a></li>
                                <li><a class="ajax-link" href="filter/project/work" id="work">工位配置</a></li>
								<li><a class="ajax-link" href="filter/inRentAsset/asset?assetType=3" id="asset">在租产品</a></li>
								<!-- <li><a class="ajax-link" href="filter/sys/logisticsCompany">储物柜登记</a></li>
                                <li><a class="ajax-link" href="filter/sys/logisticsCompany" >CAD图配置</a></li>
                                <li><a class="ajax-link" href="filter/project/record" id="record">租凭记录</a></li> -->
							</ul>		
						</li> 
						<li class="accordion"><a href="#"><span> 资费管理</span></a>
							<ul class="nav nav-pills nav-stacked">
                                <li><a class="ajax-link" href="filter/tariff/suTraiff" id="subjectTraiff">科目配置</a></li>
                                <li><a class="ajax-link" href="filter/tariff/traConFir" id="Traiffconfigure">费率配置</a></li>
                            </ul>		
						</li> 
						<li class="accordion"><a href="#"><span>产品管理</span></a>
							<ul class="nav nav-pills nav-stacked">
	                            <li><a class="ajax-link" href="filter/product/proconfirst" id="product_conf">基本产品</a></li>
                                <li><a class="ajax-link" href="filter/product/product_wid" id="product_widsom">智慧包产品</a></li>
							</ul>
					   </li>
						<li class="accordion"><a href="#"><span> 钱包管理</span></a>
							<ul class="nav nav-pills nav-stacked">
                                <li><a class="ajax-link" href="filter/wallet/gotoItem" id="walletItem">科目配置</a></li>
                                <li><a class="ajax-link" href="filter/wallet/gotoCompanyItem" id="companyWallet">公司钱包</a></li>
                                <li><a class="ajax-link" href="filter/wallet/gotoUserItem" id="userWallet">会员钱包</a></li>
                            </ul>		
						</li>
						<li class="accordion">
						<a class="ajax-link" href="filter/activity/showActivity"><span>抽奖活动</span></a>
						</li>
						<!-- <li class="accordion"><a href="#"><span>消息推送</span></a>
							<ul class="nav nav-pills nav-stacked"> -->
							
                                <li><a class="ajax-link" href="filter/ems/home" id="ems_home"><span>推送消息</span></a></li>
                               <!--  <li><a class="ajax-link" href="filter/ems/homePage" id="ems_home_page">推送列表</a></li>
                            </ul>	 
						</li>-->	
						<li class="accordion"><a href="#"><span>第三方硬件管理</span></a>
						  	<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/thirdparty/cabinet/home?page=0" >储物柜信息</a></li>
								<li><a class="ajax-link" href="filter/thirdparty/cabinethire/home?page=0" >储物柜在租记录</a></li>
								<li><a class="ajax-link" href="filter/thirdparty/cabinethirehis/home?page=0" >储物柜租用历史记录</a></li>
						  	</ul>
						</li>
						<li class="accordion"><a href="#"><span> 业务查询</span></a>
							<ul class="nav nav-pills nav-stacked">
                                <!-- <li><a class="ajax-link" href="filter/PersonalBills/showDeposit" id="">交易记录</a></li> -->
                                 <li><a class="ajax-link" href="filter/PersonalBills/showPersonDeposit?type=0&isCom=2" id="">个人交易</a></li>
                                  <li><a class="ajax-link" href="filter/PersonalBills/showPersonDeposit?type=0&isCom=1" id="">公司交易</a></li>
                                <li><a class="ajax-link" href="filter/PersonalBills/showDayBusinessRecord" id="">业务记录</a></li>
                            </ul>		
						</li>
						<li class="accordion"><a href="#"><span> 门禁管理</span></a>
							<ul class="nav nav-pills nav-stacked">
							<li><a class="ajax-link" href="filter/thirdparty/doorcontroller/home?page=0" >门禁控制器</a></li>
								<li><a class="ajax-link" href="filter/thirdparty/door/home?page=0" >门信息</a></li>
								<!-- <li><a class="ajax-link" href="filter/thirdparty/adddoorcard/index?" >添加授权</a></li> -->
								<li><a class="ajax-link" href="filter/thirdparty/doorcard/home?page=0" >门卡授权记录</a></li>
								<li><a class="ajax-link" href="filter/thirdparty/bluetooth/home" >蓝牙授权记录</a></li>
								<li><a class="ajax-link" href="filter/thirdparty/bluetooth/relievePage" >蓝牙授权解除</a></li>
                                <li><a class="ajax-link" href="filter/thirdparty/bluetoothdoor/home" >蓝牙开门记录</a></li>
                                <li><a class="ajax-link" href="filter/readCard/showReadCard" id="forCard">普通授权</a></li>
                                <li><a class="ajax-link" href="filter/readCard/showBossCard" id="forBossCard">高级授权</a></li>
                                <li><a class="ajax-link" href="filter/readCard/showRLCard" id="forCardLost">挂失/解绑</a></li>
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
						<li class="accordion"><a href="#"><span> 其他管理</span></a>
							<ul class="nav nav-pills nav-stacked">
                                <li><a class="ajax-link" href="filter/sys/menu">微信菜单管理</a></li>
                                <li><a class="ajax-link" href="filter/createDiscount/createNumber" id="discount">生成折扣码</a></li>
                                <li><a class="ajax-link" href="filter/version/versionShow" id="org">版本管理</a></li>
                            </ul>
						</li>
						<!-- <li class="accordion"><a href="#"><span> 区县管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/configManage/sysCbdInfoPage" id="sysCboInfo">商业区</a></li>
								<li><a class="ajax-link" href="filter/configManage/sysProvincePage" id="provinceConfig">省份</a></li>
								<li><a class="ajax-link" href="filter/configManage/cityPage" id="cityConfig">城市</a></li>
								<li><a class="ajax-link" href="filter/configManage/countyPage" id="countyConfig">区县</a></li>
                            </ul>
						</li> -->
						<li class="accordion"><a href="#"><span> 菜单管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/menu/adminMenu" id="adminMenu"><span> Bss菜单管理</span></a></li>
								<li><a class="ajax-link" href="filter/sys/menu">微信菜单管理</a></li>
                            </ul>
						</li>
						
						<li class="accordion"><a href="#"><span> 商机管理</span></a>
							<ul class="nav nav-pills nav-stacked">
								<li><a class="ajax-link" href="filter/opportunity/add" id=""><span>新建商机</span></a></li>
								<li><a class="ajax-link" href="filter/opportunity/" id=""><span>全部商机</span></a></li>
                            	<li><a class="ajax-link" href="filter/opportunity/" id=""><span>公共商机</span></a></li>
                            	<li><a class="ajax-link" href="filter/opportunity/" id=""><span>我的商机</span></a></li>
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
					<!-- <label id="for-is-ajax" for="is-ajax"><input id="is-ajax"
						type="checkbox"> 异步调用</label> -->
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