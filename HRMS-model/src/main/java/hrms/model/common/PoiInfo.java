package hrms.model.common;


/**
 * @author sundf
 *2016年9月1日
 */
public class PoiInfo {
/**
 *  "name":"漕河泾开发区",
            "location":{
                "lat":31.099375,
                "lng":121.32855
            },
            "address":"上海市松江区莘砖公路518号3号楼12楼",
            "street_id":"905fb267f972ba86f02d83a2",
            "detail":1,
            "uid":"905fb267f972ba86f02d83a2"
 */
	private String name;
	private Point location;
	private String address;
	private String street_id;
	private String detail;
	private String uid;
	private String lat;
	private String lng;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Point getLocation() {
		return location;
	}
	public void setLocation(Point location) {
		this.location = location;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStreet_id() {
		return street_id;
	}
	public void setStreet_id(String street_id) {
		this.street_id = street_id;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	
}
