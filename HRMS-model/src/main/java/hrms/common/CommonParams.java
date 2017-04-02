package hrms.common;

/**
 * Created by 谢益文 on 2017/3/20.
 */
public class CommonParams {

	private Integer orgId;
	private Integer userId;
	private Integer page;
	private Integer pagesize;

	public CommonParams() {
	}

	public CommonParams(Integer orgId, Integer userId, Integer page, Integer pagesize) {
		this.orgId = orgId;
		this.userId = userId;
		this.page = page;
		this.pagesize = pagesize;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getPagesize() {
		return pagesize;
	}

	public void setPagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}

	@Override
	public String toString() {
		return "CommonParams{" +
				"orgId=" + orgId +
				", userId=" + userId +
				", page=" + page +
				", pagesize=" + pagesize +
				'}';
	}
}
