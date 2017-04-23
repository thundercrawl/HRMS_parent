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
	private String code;

	private Object data;

	private JSONArray jsonArray;
	private JSONArray jsonArrayMeet;
	private JSONArray jsonArrayTask;
	

	private String picurl;
	private String userPicUrl;


	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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


	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "Grid{" +
				"total=" + total +
				", rows=" + rows +
				", row=" + row +
				", errorMsg='" + errorMsg + '\'' +
				", message='" + message + '\'' +
				", data=" + data +
				", jsonArray=" + jsonArray +
				", jsonArrayMeet=" + jsonArrayMeet +
				", jsonArrayTask=" + jsonArrayTask +
				", picurl='" + picurl + '\'' +
				", userPicUrl='" + userPicUrl + '\'' +
				", lists=" + lists +
				", listarray=" + listarray +
				'}';
	}
}
