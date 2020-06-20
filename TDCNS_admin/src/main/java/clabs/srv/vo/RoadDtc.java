package clabs.srv.vo;

import java.util.ArrayList;

public class RoadDtc {
	private int rno;
	private ArrayList<ArrayList<Integer>> dtc;
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public ArrayList<ArrayList<Integer>> getDtc() {
		return dtc;
	}
	public void setDtc(ArrayList<ArrayList<Integer>> dtc) {
		this.dtc = dtc;
	}
	@Override
	public String toString() {
		return "RoadDtc [rno=" + rno + ", dtc=" + dtc + "]";
	}
	
}
