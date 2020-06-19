package clabs.srv.vo;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

public class TDCNS {

	public static String idpMetafile;
	public static String serviceDomain, serviceName, baseURL;
	
	public Properties props;

	public TDCNS(String config) {

		props = new Properties();
        try {
        	props.load(new InputStreamReader(new FileInputStream(config)));
 
        	serviceName = props.getProperty("service.name", "TDCNS");
            
        } catch (IOException e) {
            System.out.println("TDCNS Error:" + e.getMessage());
        }
	}
}
