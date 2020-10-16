package clabs.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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

import clabs.srv.service.DataCenterService;
import clabs.srv.vo.RoadDtc;
import clabs.tools.ResObject;
import clabs.tools.StringUtils;


/*
 * this controller is 
 * for to install package.
 */
@Controller
@RequestMapping("/dc")
public class DataCenterController extends BaseController {

	private final static Logger logger = Logger.getLogger(DataCenterController.class.getName());	
	
	@Autowired DataCenterService dataCenterService;
	
	@RequestMapping(value="/index.do")
	public ModelAndView index(HttpServletRequest request, @RequestParam Map<String,String> params) throws IOException{
		ModelAndView model = new ModelAndView("/index");
		model.addObject("serverName", String.format("%s%s", request.getServerName(), (request.getServerPort() != 80) ? ":" + Integer.toString(request.getServerPort()) : ""));
		model.addObject("contextPath", context.getContextPath());
		model.addObject("page", params.get("page") != null ? params.get("page") : "/home");
		
		return model;
	}
	
	@RequestMapping(value="/addDataRow.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject addDataRow(HttpServletRequest request, @RequestParam Map<String, String> params, @RequestBody Map<String,Object> payload ) throws IOException{
		logger.info("addDataRow.json - Params:" + params);
        logger.info("payload : " + payload);
        try {
    		dataCenterService.addDataRow(payload);
    		return new ResObject(1,"success!");
        }catch (Exception e) {
        	e.printStackTrace();
			return new ResObject(-1,e.getMessage());
		}
	}
	
	@RequestMapping(value="/getDataRow.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getDataRow(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
        try {
			logger.info("getDataRow.json - Params:" + params);
			// 파라미터 확인
			if(!StringUtils.paramsCheck(params,"serviceKey,rno,date,time")) return new ResObject(403,"Missing Required Parameters");
			
			// 키 검증
			String serviceKey=params.get("serviceKey");
			if(!dataCenterService.authenticationServiceKey(serviceKey)) return new ResObject(401,"unauthenticated api key");
			List<Map<String,Object>> result =dataCenterService.getDataRow(params.get("rno"),params.get("date"),params.get("time"));
    		
    		return new ResObject(1,"success!",result);
        }catch (Exception e) {
        	e.printStackTrace();
			return new ResObject(-1,e.getMessage());
		}
	}
	
	@RequestMapping(value="/getWeekStat.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getWeekStat(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
        try {
			logger.info("getWeekStat.json - Params:" + params);
			// 파라미터 확인
			if(!StringUtils.paramsCheck(params,"serviceKey,rno,endDate")) return new ResObject(403,"Missing Required Parameters");
			params.put("startDate", ""+(Integer.parseInt(params.get("endDate"))-7));
			// 키 검증
			String serviceKey=params.get("serviceKey");
			if(!dataCenterService.authenticationServiceKey(serviceKey)) return new ResObject(401,"unauthenticated api key");
			
			List<Map<String,Object>> result =dataCenterService.getWeekStat(params.get("rno"),params.get("startDate"),params.get("endDate"));
    		
    		return new ResObject(1,"success!",result);
        }catch (Exception e) {
        	e.printStackTrace();
			return new ResObject(-1,e.getMessage());
		}
	}
	@RequestMapping(value="/getDayStat.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getDayStat(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
        try {
			logger.info("getDayStat.json - Params:" + params);
			// 파라미터 확인
			if(!StringUtils.paramsCheck(params,"serviceKey,rno,date")) return new ResObject(403,"Missing Required Parameters");
			
			// 키 검증
			String serviceKey=params.get("serviceKey");
			if(!dataCenterService.authenticationServiceKey(serviceKey)) return new ResObject(401,"unauthenticated api key");
			
			List<Map<String,Object>> result =dataCenterService.getDayStat(params.get("rno"),params.get("date"));
    		
    		return new ResObject(1,"success!",result);
        }catch (Exception e) {
        	e.printStackTrace();
			return new ResObject(-1,e.getMessage());
		}
	}
	@RequestMapping(value="/getSizeStat.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getSizeStat(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
        try {
			logger.info("getSizeStat.json - Params:" + params);
			// 파라미터 확인
			if(!StringUtils.paramsCheck(params,"serviceKey,rno")) return new ResObject(403,"Missing Required Parameters");
			
			// 키 검증
			String serviceKey=params.get("serviceKey");
			if(!dataCenterService.authenticationServiceKey(serviceKey)) return new ResObject(401,"unauthenticated api key");
			
			Map<String,Object> result =dataCenterService.getSizeStat(params.get("rno"));
    		
    		return new ResObject(1,"success!",result);
        }catch (Exception e) {
        	e.printStackTrace();
			return new ResObject(-1,e.getMessage());
		}
	}
	@RequestMapping(value="/getLaneStat.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject getLaneStat(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
        try {
			logger.info("getLaneStat.json - Params:" + params);
			// 파라미터 확인
			if(!StringUtils.paramsCheck(params,"serviceKey,rno")) return new ResObject(403,"Missing Required Parameters");
			
			// 키 검증
			String serviceKey=params.get("serviceKey");
			if(!dataCenterService.authenticationServiceKey(serviceKey)) return new ResObject(401,"unauthenticated api key");
			
			List<Map<String,Object>> result =dataCenterService.getLaneStat(params.get("rno"));
    		
    		return new ResObject(1,"success!",result);
        }catch (Exception e) {
        	e.printStackTrace();
			return new ResObject(-1,e.getMessage());
		}
	}
}
