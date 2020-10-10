package clabs.srv.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DataCenterMapper {
	void addDataRow(Map<String, String> hm);
	List<Map<String, Object>> getDataRow(Map<String, String> hm);
}
