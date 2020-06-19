package clabs.controller;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

public class BaseController {

	private final static Logger logger = Logger.getLogger(BaseController.class.getName());
	
	protected @Autowired ServletContext context; 

	protected final static String GSPAccountInfo = "_GSVPM-UserInfo_";
//	protected final static String GSPCBParam = "_GSVPM-CBParm_";
	
}
