package commute.model;

import java.util.Date;

public class CommuteBean {
	private String emp_no;
    private Date work_date;
    private Date clock_in;
    private Date clock_out;
    private Double total_hours;
    private Double overtime_hours;
    private String empNm;
    private String deptNm;
    private String cmmNm;
    
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public Date getWork_date() {
		return work_date;
	}
	public void setWork_date(Date work_date) {
		this.work_date = work_date;
	}
	public Date getClock_in() {
		return clock_in;
	}
	public void setClock_in(Date clock_in) {
		this.clock_in = clock_in;
	}
	public Date getClock_out() {
		return clock_out;
	}
	public void setClock_out(Date clock_out) {
		this.clock_out = clock_out;
	}
	public Double getTotal_hours() {
		return total_hours;
	}
	public void setTotal_hours(Double total_hours) {
		this.total_hours = total_hours;
	}
	public Double getOvertime_hours() {
		return overtime_hours;
	}
	public void setOvertime_hours(Double overtime_hours) {
		this.overtime_hours = overtime_hours;
	}
	public String getEmpNm() {
		return empNm;
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getCmmNm() {
		return cmmNm;
	}
	public void setCmmNm(String cmmNm) {
		this.cmmNm = cmmNm;
	}
	public CommuteBean() {
		super();
	}
	public CommuteBean(String emp_no, Date work_date, Date clock_in, Date clock_out, Double total_hours,
			Double overtime_hours, String empNm, String deptNm, String cmmNm) {
		super();
		this.emp_no = emp_no;
		this.work_date = work_date;
		this.clock_in = clock_in;
		this.clock_out = clock_out;
		this.total_hours = total_hours;
		this.overtime_hours = overtime_hours;
		this.empNm = empNm;
		this.deptNm = deptNm;
		this.cmmNm = cmmNm;
	}
	
	
}
