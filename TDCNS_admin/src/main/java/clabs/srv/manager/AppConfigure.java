package clabs.srv.manager;


import org.apache.log4j.Logger;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.core.env.Environment;

import clabs.srv.vo.TDCNS;

@Configuration
@ImportResource({"classpath*:applicationContext.xml"})
public class AppConfigure implements EnvironmentAware {

	private final static Logger logger = Logger.getLogger(AppConfigure.class.getName());
	private static String configFile = "/gsvp.properties";
	public static String home;
	
	Environment env;
	
    @Bean
    public TDCNS gsuiteLink() {
    	home = env.getProperty("GSL_HOME");
    	return new TDCNS(home + configFile);
    }

	@Override
	public void setEnvironment(Environment environment) {
		env = environment;
	}
    
}
