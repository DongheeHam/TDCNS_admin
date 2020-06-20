package clabs.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

import clabs.srv.service.AdminService;
import clabs.srv.vo.RoadDtc;
import clabs.srv.vo.RoadLdtc;
import clabs.tools.ResObject;
import clabs.tools.StringUtils;


/*
 * this controller is 
 * for to install package.
 */
@Controller
@RequestMapping("/rest")
public class RestController extends BaseController {

	private final static Logger logger = Logger.getLogger(RestController.class.getName());
	@Autowired AdminService adminService;
	
	@RequestMapping(value="/getInter.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getInter(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
		logger.info("getInter.json - Params:" + params);
		
		return null;
	}
	
	@RequestMapping(value="/getRoad.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getRoad(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
		logger.info("getRoad.json - Params:" + params);

		return null;
	}
	
	@RequestMapping(value="/getDtc.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getDtc(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
		logger.info("getDtc.json - Params:" + params);
		Object re = adminService.getDtc(params);
		return new ResObject(1,"",re);
	}
	
	@RequestMapping(value="/getLdtc.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getLdtc(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
		logger.info("getLdtc.json - Params:" + params);
		Object re = adminService.getLdtc(params);
		return new ResObject(1,"",re);
	}
	
	@RequestMapping(value="/setDtc.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject setDtc(HttpServletRequest request, @RequestParam Map<String, String> params, @RequestBody RoadDtc payload ) throws IOException{
		logger.info("setDtc.json - Params:" + params);
		Map<String, String[]> a=request.getParameterMap();
		Set<String> keys=a.keySet();
		logger.info("keys.size():"+keys.size());
		for (String key : keys) {
			  logger.info(key+":"+a.get(key));
			}
        
        logger.info("payload : " + payload);
        int[] result=adminService.setDtc(payload);
        
		return new ResObject(1,String.format("success : %d, fail : %d", result[0], result[1]), null);
	}
	
	
	@RequestMapping(value="/setLdtc.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject setLdtc(HttpServletRequest request, @RequestParam Map<String, String> params, @RequestBody RoadLdtc payload ) throws IOException{
		logger.info("setLdtc.json - Params:" + params);
		
		Map<String, String[]> a=request.getParameterMap();
		Set<String> keys=a.keySet();
		logger.info("keys.size():"+keys.size());
		for (String key : keys) {
			  logger.info(key+":"+a.get(key));
			}
        
        logger.info("payload : " + payload);
        
        
        
        int[] result=adminService.setLdtc(payload);
        
		return new ResObject(1,String.format("success : %d, fail : %d", result[0], result[1]), null);
	}
	
	
	
	
	
}
