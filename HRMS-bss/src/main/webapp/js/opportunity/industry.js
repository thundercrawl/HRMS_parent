function Hashtable() {
    this._hash = new Object();
    //add()
    this.add = function(key,value){
        if(typeof(key)!="undefined"){
            if(this.contains(key)==false){
                this._hash[key]=typeof(value)=="undefined"?null:value;
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    //remove()
    this.remove = function(key){delete this._hash[key];}
    //count
    this.count = function(){var i=0;for(var k in this._hash){i++;} return i;}
    //items
    this.items = function(key){return this._hash[key];}
    //contains
    this.contains = function(key){ return typeof(this._hash[key])!="undefined";}
    //clear
    this.clear = function(){for(var k in this._hash){delete this._hash[k];}}
}

var industryString = " ,房产,建筑,汽车,住宿餐饮,时尚类,教育培训,医疗卫生," +
                    "文化体育娱乐,金融,IT互联网,互联网,制造业,贸易,交通物流,商务服务," +
                    "公共管理和社会组织,环境与公共设施,国际组织,科学研究和技术服务,能源,农林牧渔";
var industryArray = industryString.split(',');

var industryHT = new Hashtable();
industryHT.add("--请选择--","");
industryHT.add("房产","房地产开发,物业管理,房地产中介,其它房地产业");
industryHT.add("建筑","房屋建筑,装饰设计,建筑安装,工程项目管理,其它建筑业");
industryHT.add("汽车","汽车制造,汽车配件,汽车销售与租赁,汽车品牌管理,其它汽车相关行业");
industryHT.add("住宿餐饮","酒店宾馆,餐厅酒吧,酒店用品和服务");
industryHT.add("时尚类","婚庆,美容美发,服装饰品,箱包,钟表");
industryHT.add("教育培训","院校类,职业技能培训,出国留学,图书");
industryHT.add("医疗卫生","医疗机构,医药保健品,健康咨询,医疗器械,殡葬业");
industryHT.add("文化体育娱乐","影视传媒,新闻出版,游戏开发,体育健身,文化艺术,休闲娱乐,毕节,黔东南,黔南");
industryHT.add("金融","银行,保险,证券基金期货,金融信息服务,金融信托与管理,投资控股,其它金融业");
industryHT.add("IT互联网","通讯,软件,电子产品,互联网信息及技术,网站建设");
industryHT.add("互联网","电子商务,网站建设,在线教育,VR,大庆,绥化,鹤岗,鸡西,黑河,双鸭山,伊春,七台河,大兴安岭");
industryHT.add("制造业","冶金冶炼,五金,机械,农副产品,安阳,鹤壁,新乡,焦作,濮阳,许昌,漯河,三门峡,南阳,商丘,信阳,周口,驻马店,济源");
industryHT.add("贸易","互联网交易平台,贸易代理,零售和批发,商场百货,物资供销");
industryHT.add("交通物流","仓储,物流货代,城市交通,航空航天,船舶");
industryHT.add("商务服务","企业管理咨询,法律服务,咨询与调查,广告业,人力资源服务,旅行社及相关服务,安保,会展,印刷包装,信用担保,办公设备");
industryHT.add("公共管理和社会组织","党政机关,公益团体,宗教组织");
industryHT.add("环境与公共设施","环境保护,水利,城市建设");
industryHT.add("国际组织","使领馆,外国驻在机构");
industryHT.add("科学研究和技术服务","高新技术,技术监测,气象地质,其它科研服务");
industryHT.add("能源","石油化工,可再生能源");
industryHT.add("农林牧渔","农业,渔业,畜牧业,林业,农林牧渔其它相关产品");

function GetNameFromString(str)
{
    return str.split('|')[0];
}

function GetIDFromString(str)
{
    return str.split('|')[1];
}

function InitIndustryone()
{
    document.getElementById("industryone").options.length = 0;
    for (var i=0; i<industryArray.length; ++i)
    {
        provStr = industryArray[i];
        document.getElementById("industryone").options[i] = new Option(provStr, provStr);
    }
}

function InitIndustrytwo(IndustryoneName)
{
	if(IndustryoneName!=''){
        var IndustrytwoArray = industryHT.items(IndustryoneName).split(',');
	}else{
		var IndustrytwoArray='';
	}
    document.getElementById("industrytwo").options.length = 0;
    for (var i=0; i<IndustrytwoArray.length; ++i)
    {
        IndustrytwoStr = IndustrytwoArray[i];
        document.getElementById("industrytwo").options[i] = new Option(IndustrytwoStr, IndustrytwoStr);
    }
}

InitIndustryone();
InitIndustrytwo("");