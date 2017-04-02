package hrms.util;

import com.alibaba.fastjson.JSONArray;

import java.util.ArrayList;
import java.util.List;

public class Grid implements java.io.Serializable {

	private static final long serialVersionUID = 6881603714749783787L;
	private Long total = 0L;
	private List<?> rows = new ArrayList<Object>();
	private List<?> row = new ArrayList<Object>();
	private String errorMsg;
	private String message;
	private Object data;
	
	private String allMoney; // 三个money 供订单页面使用
	private String assureMoney;
	private String firstPayMoney;

	private String orderId;
	private String orderNo;
	private Double totalPrice;
	private String totalPriceStr;
	private String createTime;
	private String packageCount;
	private JSONArray jsonArray;
	private JSONArray jsonArrayMeet;
	private JSONArray jsonArrayTask;
	
	private String orderInfo;//json string 储存订单信息
	private String splitSign;//1分期 2不分期 

	private String picurl;
	private String userPicUrl;
	
	private double personCount;//个人用户弹性工位券数
	private double meetCount;//个人用户会议室券数
	
	private int flag;//支付方式标志 1调用外部支付接口  2调用内部支付接口
	
	private double companyMeet; //公司会议室券数
	private double companyUser; //公司弹性工位券数
	
	private int companyPay; //公司统一支付权限 0没有  1有
	
	public double getPersonCount() {
		return personCount;
	}

	public void setPersonCount(double personCount) {
		this.personCount = personCount;
	}

	public double getMeetCount() {
		return meetCount;
	}

	public void setMeetCount(double meetCount) {
		this.meetCount = meetCount;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getPicurl() {
		return picurl;
	}

	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

	public String getUserPicUrl() {
		return userPicUrl;
	}

	public void setUserPicUrl(String userPicUrl) {
		this.userPicUrl = userPicUrl;
	}

	private List<?> lists = new ArrayList<Object>();
	private List<?> listarray = new ArrayList<Object>();
	public List<?> getListarray() {
		return listarray;
	}

	public void setListarray(List<?> listarray) {
		this.listarray = listarray;
	}

	public List<?> getLists() {
		return lists;
	}

	public void setLists(List<?> lists) {
		this.lists = lists;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	

	public String getAllMoney() {
		return allMoney;
	}

	public void setAllMoney(String allMoney) {
		this.allMoney = allMoney;
	}

	public String getAssureMoney() {
		return assureMoney;
	}

	public void setAssureMoney(String assureMoney) {
		this.assureMoney = assureMoney;
	}

	public String getFirstPayMoney() {
		return firstPayMoney;
	}

	public void setFirstPayMoney(String firstPayMoney) {
		this.firstPayMoney = firstPayMoney;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}

	public List<?> getRow() {
		return row;
	}

	public void setRow(List<?> row) {
		this.row = row;
	}

	public String getPackageCount() {
		return packageCount;
	}

	public void setPackageCount(String packageCount) {
		this.packageCount = packageCount;
	}
	

	public JSONArray getJsonArray() {
		return jsonArray;
	}

	public void setJsonArray(JSONArray jsonArray) {
		this.jsonArray = jsonArray;
	}
	
	
	public JSONArray getJsonArrayMeet() {
		return jsonArrayMeet;
	}

	public void setJsonArrayMeet(JSONArray jsonArrayMeet) {
		this.jsonArrayMeet = jsonArrayMeet;
	}

	public JSONArray getJsonArrayTask() {
		return jsonArrayTask;
	}

	public void setJsonArrayTask(JSONArray jsonArrayTask) {
		this.jsonArrayTask = jsonArrayTask;
	}

	public String getTotalPriceStr() {
		return totalPriceStr;
	}

	public void setTotalPriceStr(String totalPriceStr) {
		this.totalPriceStr = totalPriceStr;
	}
	
	
	public String getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(String orderInfo) {
		this.orderInfo = orderInfo;
	}
	
	public String getSplitSign() {
		return splitSign;
	}

	public void setSplitSign(String splitSign) {
		this.splitSign = splitSign;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "Grid [total=" + total + ", rows=" + rows + ", errorMsg="
				+ errorMsg + ", message=" + message + "]";
	}

	public double getCompanyMeet() {
		return companyMeet;
	}

	public void setCompanyMeet(double companyMeet) {
		this.companyMeet = companyMeet;
	}

	public double getCompanyUser() {
		return companyUser;
	}

	public void setCompanyUser(double companyUser) {
		this.companyUser = companyUser;
	}

	public int getCompanyPay() {
		return companyPay;
	}

	public void setCompanyPay(int companyPay) {
		this.companyPay = companyPay;
	}

}
