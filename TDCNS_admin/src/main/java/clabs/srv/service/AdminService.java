package clabs.srv.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import clabs.srv.mapper.HelpMapper;


@Service("AdminService")
public class AdminService {
private final static Logger logger = Logger.getLogger(AdminService.class.getName());
	
	@Autowired
	HelpMapper helpMapper;
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	
	
}
