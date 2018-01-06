package zikzakjack;

import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.ws.config.annotation.EnableWs;
import org.springframework.ws.transport.http.MessageDispatcherServlet;
import org.springframework.ws.wsdl.wsdl11.DefaultWsdl11Definition;
import org.springframework.xml.xsd.SimpleXsdSchema;
import org.springframework.xml.xsd.XsdSchema;

@EnableWs
@Configuration
public class AppConfig {

	@Bean
	public ServletRegistrationBean mesageDispatcherServlet(ApplicationContext context) {
		MessageDispatcherServlet messageDispatcherServlet = new MessageDispatcherServlet();
		messageDispatcherServlet.setApplicationContext(context);
		messageDispatcherServlet.setTransformWsdlLocations(true);
		return new ServletRegistrationBean(messageDispatcherServlet, "/zws/*");
	}

	@Bean
	public XsdSchema regionSchema() {
		return new SimpleXsdSchema(new ClassPathResource("hrscott.xsd"));
	}

	@Bean("regions")
	public DefaultWsdl11Definition defaultWsdl11Definition(XsdSchema regionSchema) {
		DefaultWsdl11Definition definition = new DefaultWsdl11Definition();
		definition.setPortTypeName("RegionDetailsPort");
		definition.setTargetNamespace("http://zikzakjack/hrscott");
		definition.setLocationUri("/zws/*");
		definition.setSchema(regionSchema);
		return definition;
	}
}
