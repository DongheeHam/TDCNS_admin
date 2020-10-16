package clabs.srv.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DataCenterMapper {
	void addDataRow(Map<String, String> hm);
	List<Map<String, Object>> getDataRow(Map<String, String> hm);
	List<Map<String, Object>> getWeekStat(Map<String, String> hm);
	List<Map<String, Object>> getDayStat(Map<String, String> hm);
	Map<String, Object> getSizeStat(String rno);
	List<Map<String, Object>> getLaneStat(String rno);
	void insertApiKey(Map<String, String> hm);
	Map<String, Object> getApiKey(String serviceKey);
}
