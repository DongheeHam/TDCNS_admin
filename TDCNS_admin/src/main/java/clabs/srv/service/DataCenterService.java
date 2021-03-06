package clabs.srv.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import clabs.srv.mapper.AdminMapper;
import clabs.srv.mapper.DataCenterMapper;
import clabs.srv.vo.RoadCounter;
import clabs.srv.vo.RoadDtc;
import clabs.srv.vo.RoadLdtc;


@Service("DataCenter")
public class DataCenterService {
private final static Logger logger = Logger.getLogger(DataCenterService.class.getName());
	
	@Autowired
	DataCenterMapper dataCenterMapper;

	public void addDataRow(Map<String, Object> payload) {
		Map<String,String> hm=new HashMap<>();
		hm.put("rno", ""+payload.get("rno"));
		hm.put("time", (String)payload.get("time"));
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
		String date = formatter.format (new Date());
		hm.put("date",date);
		List<Map<String,Integer>> lane=(List<Map<String, Integer>>) payload.get("lane");
		int i=1;
        for(Map<String,Integer> traffic:lane) {
        	logger.info("traffic:"+traffic);
        	hm.put("large", ""+traffic.get("large"));
        	hm.put("small", ""+traffic.get("small"));
        	hm.put("lane", ""+i++);
        	logger.info("hm:"+hm);
        	dataCenterMapper.addDataRow(hm);
        }
	}

	public boolean authenticationServiceKey(String serviceKey) {
		return dataCenterMapper.getApiKey(serviceKey)!=null;
	}

	public List<Map<String, Object>> getDataRow(String rno, String date, String time) {
		Map<String,String> hm= new HashMap<>();
		hm.put("rno", rno);
		hm.put("date", date);
		hm.put("time", time);
		
		return dataCenterMapper.getDataRow(hm);
	}

	public List<Map<String, Object>> getWeekStat(String rno, String startDate, String endDate) {
		Map<String,String> hm= new HashMap<>();
		hm.put("rno", rno);
		hm.put("startDate", startDate);
		hm.put("endDate", endDate);
		
		return dataCenterMapper.getWeekStat(hm);
	}
	public List<Map<String, Object>> getDayStat(String rno, String date) {
		Map<String,String> hm= new HashMap<>();
		hm.put("rno", rno);
		hm.put("date", date);
		
		return dataCenterMapper.getDayStat(hm);
	}
	public Map<String, Object> getSizeStat(String rno) {return dataCenterMapper.getSizeStat(rno);}
	public List<Map<String, Object>> getLaneStat(String rno) {return dataCenterMapper.getLaneStat(rno);}

	public void insertApiKey(String key) {
		Map<String,String> hm= new HashMap<>();
		hm.put("key", key);
		dataCenterMapper.insertApiKey(hm);
	}
	
}
