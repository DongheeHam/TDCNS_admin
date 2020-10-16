package clabs.srv.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import clabs.srv.mapper.AdminMapper;
import clabs.srv.vo.RoadCounter;
import clabs.srv.vo.RoadDtc;
import clabs.srv.vo.RoadLdtc;


@Service("AdminService")
public class AdminService {
private final static Logger logger = Logger.getLogger(AdminService.class.getName());
	
	@Autowired
	AdminMapper adminMapper;
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	@Transactional(rollbackFor=Exception.class)
	public int[] setLdtc(RoadLdtc payload) {
		map.clear();
		int rno=payload.getRno();
        ArrayList<ArrayList<ArrayList<Integer>>> ldtc=payload.getLdtc();
        map.put("rno", rno);
		
        adminMapper.deleteLdtc(map);
        int succ=0, fail=0;
        
        for(int i=0;i<ldtc.size();i++) {
        	ArrayList<ArrayList<Integer>> lane= ldtc.get(i);
        	for(int j=0;j<lane.size();j++) {
        		ArrayList<Integer> point=lane.get(j);
        		int x=point.get(0);
        		int y=point.get(1);
        		map.put("lane", i+1);
        		map.put("point", j);
        		map.put("lx", x);
        		map.put("ly", y);
        		logger.info(map);
    			int re = adminMapper.insertLdtc(map);
    			if(re==0)fail++;
    			else succ++;
        	}
        }
        int[] re= {succ, fail};
		return re;
	}
	
	@Transactional(rollbackFor=Exception.class)
	public int[] setCounter(RoadCounter payload) {
		map.clear();
		int rno=payload.getRno();
        ArrayList<ArrayList<ArrayList<Integer>>> ldtc=payload.getCounter();
        map.put("rno", rno);
		
        adminMapper.deleteCounter(map);
        int succ=0, fail=0;
        
        for(int i=0;i<ldtc.size();i++) {
        	ArrayList<ArrayList<Integer>> lane= ldtc.get(i);
        	for(int j=0;j<lane.size();j++) {
        		ArrayList<Integer> point=lane.get(j);
        		int x=point.get(0);
        		int y=point.get(1);
        		map.put("lane", i+1);
        		map.put("point", j);
        		map.put("lx", x);
        		map.put("ly", y);
        		logger.info(map);
    			int re = adminMapper.insertCounter(map);
    			if(re==0)fail++;
    			else succ++;
        	}
        }
        int[] re= {succ, fail};
		return re;
	}
	
	public int[] setDtc(RoadDtc payload) {
		map.clear();
		int rno=payload.getRno();
        ArrayList<ArrayList<Integer>> dtc=payload.getDtc();
        map.put("rno", rno);
		
        adminMapper.deleteDtc(map);
        int succ=0, fail=0;
        
        for(int i=0;i<dtc.size();i++) {
        	ArrayList<Integer> point=dtc.get(i);
    		int x=point.get(0);
    		int y=point.get(1);
    		map.put("point", i);
    		map.put("dx", x);
    		map.put("dy", y);
    		logger.info(map);
			int re = adminMapper.insertDtc(map);
			if(re==0)fail++;
			else succ++;
        }
        int[] re= {succ, fail};
		return re;
	}

	public Object getDtc(Map<String, String> params) {
		List<Map<String, Object>> raw = adminMapper.getDtc(params);
		logger.info("raw : "+raw);
		ArrayList<ArrayList<Integer>> dtc=new ArrayList<>();
		
		for(int i=0;i<raw.size();i++) {
			ArrayList<Integer> point=new ArrayList<>();
			point.add((Integer)raw.get(i).get("dx"));
			point.add((Integer)raw.get(i).get("dy"));
			
			dtc.add(point);
		}
		logger.info("dtc : "+dtc);
		return dtc;
	}
	
	public Object getLdtc(Map<String, String> params) {
		List<Map<String, Object>> raw = adminMapper.getLdtc(params);
		logger.debug("raw : "+raw);
		ArrayList<ArrayList<ArrayList<Integer>>> ldtc=new ArrayList<>();
		ArrayList<ArrayList<Integer>> lane=new ArrayList<>();
		
		for(int i=0;i<raw.size();i++) {
			int currentLane=(int)raw.get(i).get("lane");
			int nextLane ;
			try {
				nextLane = (int)raw.get(i+1).get("lane");
			}catch(IndexOutOfBoundsException e) {
				nextLane = currentLane+1;
			}
			
			ArrayList<Integer> point=new ArrayList<>();
			point.add((Integer)raw.get(i).get("lx"));
			point.add((Integer)raw.get(i).get("ly"));
			lane.add(point);
			
			if(currentLane!=nextLane) {

				logger.debug("lane:"+lane.clone());
				logger.debug("ldtc:"+ldtc);
				
				ldtc.add((ArrayList<ArrayList<Integer>>) lane.clone());
				lane.clear();
			}
		}
		logger.info("ldtc : "+ldtc);
		return ldtc;
	}
	
	public Object getCounter(Map<String, String> params) {
		List<Map<String, Object>> raw = adminMapper.getCounter(params);
		logger.debug("raw : "+raw);
		ArrayList<ArrayList<ArrayList<Integer>>> counter=new ArrayList<>();
		ArrayList<ArrayList<Integer>> lane=new ArrayList<>();
		
		for(int i=0;i<raw.size();i++) {
			int currentLane=(int)raw.get(i).get("lane");
			int nextLane ;
			try {
				nextLane = (int)raw.get(i+1).get("lane");
			}catch(IndexOutOfBoundsException e) {
				nextLane = currentLane+1;
			}
			
			ArrayList<Integer> point=new ArrayList<>();
			point.add((Integer)raw.get(i).get("lx"));
			point.add((Integer)raw.get(i).get("ly"));
			lane.add(point);
			
			if(currentLane!=nextLane) {

				logger.debug("lane:"+lane.clone());
				logger.debug("counter:"+counter);
				
				counter.add((ArrayList<ArrayList<Integer>>) lane.clone());
				lane.clear();
			}
		}
		logger.info("counter : "+counter);
		return counter;
	}
	
	public List<Map<String, Object>> getRoadList() {
		
		return adminMapper.getRoadList();
	}

	public int insertInter(String name, String pos) {
		Map<String,String> hm=new HashMap<String, String>();
		hm.put("name", name);
		hm.put("pos", pos);
		return adminMapper.insertInter(hm);
	}

	public List<Map<String,Object>> getInterList() {return adminMapper.getInterList();}

	public int insertRoad(String ino, String name, String ip, String stream, String pos) {
		Map<String,String> hm=new HashMap<String, String>();
		hm.put("ino", ino);
		hm.put("name", name);
		hm.put("ip", ip);
		hm.put("stream", stream);
		hm.put("pos", pos);
		return adminMapper.insertRoad(hm);
	}

	public Map<String, Object> getRoad(String rno) {
		Map<String,String> hm=new HashMap<String, String>();
		hm.put("rno", rno);
		return adminMapper.getRoad(hm);
	}

	public Map<String,Object> getInter(String ino) {
		Map<String,String> hm=new HashMap<String, String>();
		hm.put("ino", ino);
		return adminMapper.getInter(hm);
	}

	public int updateInter(String ino, String name, String pos) {
		Map<String,String> hm=new HashMap<String, String>();
		hm.put("ino", ino);
		hm.put("name", name);
		hm.put("pos", pos);
		return adminMapper.updateInter(hm);
	}

	public int updateRoad(String rno, String ino, String name, String ip, String stream, String pos) {
		Map<String,String> hm=new HashMap<String, String>();
		hm.put("rno", rno);
		hm.put("ino", ino);
		hm.put("name", name);
		hm.put("ip", ip);
		hm.put("stream", stream);
		hm.put("pos", pos);
		return adminMapper.updateRoad(hm);
	}
}
