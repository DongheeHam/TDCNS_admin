package clabs.srv.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AdminMapper {

	List<Map<String, Object>> getLdtc(Map<String, String> params);
	
	List<Map<String, Object>> getDtc(Map<String, String> params);

	int insertLdtc(Map<String, Object> map);

	int insertDtc(Map<String, Object> map);

	int deleteLdtc(Map<String, Object> map);
	
	int deleteDtc(Map<String, Object> map);

	List<Map<String, Object>> getCounter(Map<String, String> params);

	int insertCounter(HashMap<String, Object> map);

	void deleteCounter(HashMap<String, Object> map);

	List<Map<String, Object>> getRoadList();

	int insertInter(Map<String, String> hm);

	List<Map<String, Object>> getInterList();

	int insertRoad(Map<String, String> hm);

	Map<String, Object> getRoad(Map<String, String> hm);
}
