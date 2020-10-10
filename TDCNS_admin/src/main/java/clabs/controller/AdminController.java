package clabs.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


/*
 * this controller is 
 * for to install package.
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {

	private final static Logger logger = Logger.getLogger(AdminController.class.getName());	
	
	@RequestMapping(value="/index.do")
	public ModelAndView index(HttpServletRequest request, @RequestParam Map<String,String> params) throws IOException{
		ModelAndView model = new ModelAndView("/index");
		model.addObject("serverName", String.format("%s%s", request.getServerName(), (request.getServerPort() != 80) ? ":" + Integer.toString(request.getServerPort()) : ""));
		model.addObject("contextPath", context.getContextPath());
		model.addObject("page", params.get("page") != null ? params.get("page") : "/home");
		
		return model;
	}
	
	@RequestMapping(value="/page.do")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String,String> params) throws IOException{
		
		logger.info("requestParam:" + params);
		String page = params.get("page");
		ModelAndView model = new ModelAndView("/pages" + page);

		model.addObject("contextPath", context.getContextPath());
		
		return model;
	}

	
	
}
