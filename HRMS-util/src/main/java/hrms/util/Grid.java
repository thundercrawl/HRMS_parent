package hrms.util;

public class Grid implements java.io.Serializable {

	private String message;
	private String code;
	private Object data;

	public Grid() {
	}

	public Grid(String message, String code, Object data) {
		this.message = message;
		this.code = code;
		this.data = data;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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
				"message='" + message + '\'' +
				", code='" + code + '\'' +
				", data=" + data +
				'}';
	}
}
