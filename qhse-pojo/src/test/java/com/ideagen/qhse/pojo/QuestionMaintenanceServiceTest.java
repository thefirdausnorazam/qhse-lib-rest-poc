package com.ideagen.qhse.pojo;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;

public class QuestionMaintenanceServiceTest {
	
	QuestionMaintenanceService questionMaintenanceService;
	Map<String, String> ormProperties;
	
	@Before
	public void setup() {
		ormProperties = new HashMap<String, String>() {
            /**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			{
				put("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
				put("hibernate.connection.url", "jdbc:mysql://localhost:3306/qhse_test?serverTimezone=Asia/Kuala_Lumpur");
				put("hibernate.connection.username", "root");
				put("hibernate.connection.password", "p@ssw0rd");
				put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
				put("hibernate.hbm2ddl.auto", "");
            }
        };
        
        //questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(ormProperties);
	}
	
	@Test
	public void testlistSearchableDepartments() {
		questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(ormProperties);
		assertNotNull(questionMaintenanceService);
		// get list of departments list for search drop list.
		String siteName = "1-Demo";
		List<QuestionOptionDto> questionOptionDtos = questionMaintenanceService.listSearchableDepartments(siteName);
		assertNotNull(questionOptionDtos);
		assertFalse(questionOptionDtos.isEmpty());
		//System.out.println(questionOptionDtos.size());
		assertTrue(questionOptionDtos.size() == 47);
		//assertArrayEquals(new Long[] {57L}, new Integer[] {Long.parseLong(questionOptionDtos.size().to))});
		
		for(QuestionOptionDto questionOptionDto: questionOptionDtos) {
			assertTrue(questionOptionDto.getCreatedByUserDto().getFirstName().equals("System"));
			assertNotNull(questionOptionDto.getQuestionDto());
			assertNotNull(questionOptionDto.getInactiveInSitesDto());
		}
		
	}

}
