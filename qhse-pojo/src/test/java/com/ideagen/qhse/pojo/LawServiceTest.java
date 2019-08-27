package com.ideagen.qhse.pojo;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.dto.ProfileChecklistTaskDto;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;
import com.ideagen.qhse.pojo.service.LawService;

public class LawServiceTest {
	
	LawService lawService;
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
				put("hibernate.connection.password", "root");
				put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
				put("hibernate.hbm2ddl.auto", "");
            }
        };
        
        lawService = QhseServiceFactory.getLawService(ormProperties);
	}
	
	@Test
	public void testSearch() {
		assertNotNull(lawService);
		TaskQueryCriteria criteria = new TaskQueryCriteria();
        QueryResult result = lawService.queryTask(criteria);
        assertNotNull(result);
        
        List<ProfileChecklistTaskDto> profileChecklistTaskDtos = result.getResults();
        assertFalse(profileChecklistTaskDtos.isEmpty());
        //default page number = 1, list size = 20, all records size = 83
        /*assertArrayEquals(new Integer[] {1, 20, 83}, 
        		new Integer[] { result.getPageNumber(), result.getResults().size(), result.getTotalResults() });*/
        assertTrue(result.getPageNumber() == 1);
        assertTrue(result.getResults().size() == 20);
        assertTrue(result.getTotalResults() == 83);
        //contains more than 20 records = true;
        assertTrue(result.isMore());
        
        for(ProfileChecklistTaskDto profileChecklistTaskDto: profileChecklistTaskDtos) {
        	assertNotNull(profileChecklistTaskDto.getSiteDto());
        	assertNotNull(profileChecklistTaskDto.getResponsibleUserDto());
        	assertNotNull(profileChecklistTaskDto.getBusinessAreaDtos());
        	assertFalse(profileChecklistTaskDto.getBusinessAreaDtos().isEmpty());
        }
        //set to 10 records per page
        lawService = QhseServiceFactory.getLawService(ormProperties);
        criteria.setPageSize(10);
        result = lawService.queryTask(criteria);
        assertNotNull(result);
        profileChecklistTaskDtos = result.getResults();
        assertFalse(profileChecklistTaskDtos.isEmpty());
        //page number = 1, list size = 10, all records size = 83
        /*assertArrayEquals(new Integer[] {1, 10, 83}, 
        		new Integer[] { result.getPageNumber(), result.getResults().size(), result.getTotalResults() });*/
        assertTrue(result.getPageNumber() == 1);
        assertTrue(result.getResults().size() == 10);
        assertTrue(result.getTotalResults() == 83);
        //contains more than 10 records = true;
        assertTrue(result.isMore());
        //set the specific id
        lawService = QhseServiceFactory.getLawService(ormProperties);
        criteria.setId(339L);
        result = lawService.queryTask(criteria);
        assertNotNull(result);
        //page number = 1, list size = 1, all records size = 1
        /*assertArrayEquals(new Integer[] {1, 1, 1}, 
        		new Integer[] { result.getPageNumber(), result.getResults().size(), result.getTotalResults() });*/
        assertTrue(result.getPageNumber() == 1);
        assertTrue(result.getResults().size() == 1);
        assertTrue(result.getTotalResults() == 1);
	}

}
