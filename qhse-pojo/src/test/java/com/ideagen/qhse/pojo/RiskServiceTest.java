package com.ideagen.qhse.pojo;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.ideagen.qhse.pojo.dto.RiskBusinessAreaDto;
import com.ideagen.qhse.pojo.service.RiskService;

public class RiskServiceTest {
	
	RiskService riskService;
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
        
        //riskService = QhseServiceFactory.getRiskService(ormProperties);
	}
	
	@Test
	public void testListActiveBusinessAreas() {
		
		riskService = QhseServiceFactory.getRiskService(ormProperties);
		assertNotNull(riskService);
		
		List<RiskBusinessAreaDto> riskBusinessAreaDtos = riskService.listActiveBusinessAreas();
		
		assertFalse(riskBusinessAreaDtos.isEmpty());
		assertTrue(riskBusinessAreaDtos.size() == 4);
		
		String[] names = new String[] { "Business", "Environmental", "Health & Safety", "Quality"};
		Long[] ids = new Long[] { 3L, 1L, 2L, 1003L};
		int i = 0;
		for(RiskBusinessAreaDto riskBusinessAreaDto: riskBusinessAreaDtos) {
			assertTrue(names[i].equals(riskBusinessAreaDto.getName()));
			assertTrue(ids[i].longValue() == riskBusinessAreaDto.getId().longValue());
			i++;
		}
	}
	
	@Test
	public void testListAllBusinessAreas() {
		
		riskService = QhseServiceFactory.getRiskService(ormProperties);
		assertNotNull(riskService);
		
		List<RiskBusinessAreaDto> riskBusinessAreaDtos = riskService.listAllBusinessAreas();
		
		assertFalse(riskBusinessAreaDtos.isEmpty());
		assertTrue(riskBusinessAreaDtos.size() == 5);
		
		String[] names = new String[] { "Business", "Energy", "Environmental", "Health & Safety", "Quality"};
		Long[] ids = new Long[] { 3L, 1002L, 1L, 2L, 1003L};
		Boolean[] actives = new Boolean[] { true, false, true, true, true};
		int i = 0;
		for(RiskBusinessAreaDto riskBusinessAreaDto: riskBusinessAreaDtos) {
			assertTrue(names[i].equals(riskBusinessAreaDto.getName()));
			assertTrue(ids[i].longValue() == riskBusinessAreaDto.getId().longValue());
			assertTrue(actives[i] == riskBusinessAreaDto.getActive());
			i++;
		}
		
	}

}
