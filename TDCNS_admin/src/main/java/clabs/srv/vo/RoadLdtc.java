package clabs.srv.vo;

import java.util.ArrayList;

public class RoadLdtc {
	private int rno;
	private ArrayList<ArrayList<ArrayList<Integer>>> ldtc;
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public ArrayList<ArrayList<ArrayList<Integer>>> getLdtc() {
		return ldtc;
	}
	public void setLdtc(ArrayList<ArrayList<ArrayList<Integer>>> ldtc) {
		this.ldtc = ldtc;
	}
	@Override
	public String toString() {
		return "RoadDtc [rno=" + rno + ", ldtc=" + ldtc + "]";
	}
	
}
