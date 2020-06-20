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
}
