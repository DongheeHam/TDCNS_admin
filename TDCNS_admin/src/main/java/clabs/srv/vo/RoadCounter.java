package clabs.srv.vo;

import java.util.ArrayList;

public class RoadCounter {
	private int rno;
	private ArrayList<ArrayList<ArrayList<Integer>>> counter;
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public ArrayList<ArrayList<ArrayList<Integer>>> getCounter() {
		return counter;
	}
	public void setLdtc(ArrayList<ArrayList<ArrayList<Integer>>> counter) {
		this.counter = counter;
	}
	@Override
	public String toString() {
		return "RoadDtc [rno=" + rno + ", counter=" + counter + "]";
	}
	
}
