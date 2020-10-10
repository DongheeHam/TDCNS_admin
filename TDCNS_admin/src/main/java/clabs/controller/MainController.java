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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import clabs.srv.service.AdminService;
import clabs.srv.service.DataCenterService;
import clabs.tools.ResObject;


/*
 * this controller is 
 * for to install package.
 */
@Controller
@RequestMapping("/")
public class MainController extends BaseController {

	private final static Logger logger = Logger.getLogger(MainController.class.getName());	
	
	@Autowired AdminService adminService;
	@Autowired DataCenterService dataCenterService;
	
	@RequestMapping(value="/index.do")
	public ModelAndView index(HttpServletRequest request, @RequestParam Map<String,String> params) throws IOException{
		ModelAndView model = new ModelAndView("/index");
		model.addObject("serverName", String.format("%s%s", request.getServerName(), (request.getServerPort() != 80) ? ":" + Integer.toString(request.getServerPort()) : ""));
		model.addObject("contextPath", context.getContextPath());
		model.addObject("page", params.get("page") != null ? params.get("page") : "/home");
		
		return model;
	}
	@RequestMapping(value="/pages/home.do")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String,String> params) throws IOException{
		String path=request.getServletPath();
		logger.debug(path +" : "+ params);
		ModelAndView model = new ModelAndView(path.substring(0, path.lastIndexOf(".do")));
		return model;
	}
	@RequestMapping(value="/pages/roadMgmt.do")
	public ModelAndView pages(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String,String> params) throws IOException{
		String path=request.getServletPath();
		logger.debug(path +" : "+ params);
		ModelAndView model = new ModelAndView(path.substring(0, path.lastIndexOf(".do")));
		return model;
	}

	
	@RequestMapping(value="/*.json", produces="application/json;charset=UTF-8")
	public @ResponseBody ResObject rest(HttpServletRequest request, @RequestParam Map<String, String> params) throws IOException{
		String path=request.getServletPath();
		try {
			logger.info(path+" - params : "+params);
			if("/getRoadList.json".equals(path)) {
				return new ResObject(1,"",adminService.getRoadList());
			}else if("/getInterList.json".equals(path)) {
				return new ResObject(1,"",adminService.getInterList());
			}else if("/insertInter.json".equals(path)) {
				String pos=String.format("%s %s", params.get("lng"),params.get("lat"));
				String name=params.get("name");
				return new ResObject(adminService.insertInter(name,pos),"",null);
			}else if("/insertRoad.json".equals(path)) {
				String pos=String.format("%s %s", params.get("lng"),params.get("lat"));
				return new ResObject(adminService.insertRoad(params.get("ino"),params.get("name"),params.get("ip"),params.get("stream"),pos),"",null);
			}else{
				logger.error("매핑되는 url이 없음.");
				return new ResObject(-1,"error",null);
			}
		}catch (Exception e) {
			e.printStackTrace();
			return new ResObject(-1,"error",null);
		}
	}
	
	@RequestMapping(value="/dialog/interForm.do")
	public ModelAndView interForm(HttpServletRequest request, @RequestParam Map<String,String> params) throws IOException{
		return dialog(request,params);
	}
	@RequestMapping(value="/dialog/roadForm.do")
	public ModelAndView roadForm(HttpServletRequest request, @RequestParam Map<String,String> params) throws IOException{
		return dialog(request,params);
	}
	private ModelAndView dialog(HttpServletRequest request, @RequestParam Map<String,String> params) throws IOException{
		String path=request.getServletPath();
		logger.debug(path+" - params : "+params);
		ModelAndView model = new ModelAndView(path.substring(0, path.lastIndexOf(".do")));
		return model;
	}
}
