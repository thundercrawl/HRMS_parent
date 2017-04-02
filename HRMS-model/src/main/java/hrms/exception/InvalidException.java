package hrms.exception;


import hrms.common.ErrorCode;
import hrms.vo.MsgVo;

public class InvalidException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	
	private ErrorCode errorCode;
	private MsgVo msgVo;

	public InvalidException() {
		super();
	}

	public InvalidException(String message) {
		super(message);
	}

	public InvalidException(String message, Throwable cause) {
		super(message, cause);
	}

	public InvalidException(Throwable cause) {
		super(cause);
	}
	
	public InvalidException(ErrorCode errorCode) {
		super('['+errorCode.getStatus()+']'+errorCode.getMessage());
		this.errorCode = errorCode;
	}
	
	public InvalidException(MsgVo msgVo) {
		super();
		this.msgVo = msgVo;
	}

	public MsgVo getMsgVo() {
		return msgVo;
	}

	public void setMsgVo(MsgVo msgVo) {
		this.msgVo = msgVo;
	}

	public ErrorCode getErrorCode() {
		return errorCode;
	}
}
