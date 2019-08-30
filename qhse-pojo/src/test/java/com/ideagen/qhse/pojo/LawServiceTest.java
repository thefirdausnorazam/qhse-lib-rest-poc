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
import com.ideagen.qhse.pojo.constants.CommonConstants;
import com.ideagen.qhse.pojo.dto.ProfileChecklistTaskDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.law.LawStatus;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;
import com.ideagen.qhse.pojo.service.LawService;
import com.ideagen.qhse.pojo.service.UserService;
import com.ideagen.qhse.pojo.util.Priority;

public class LawServiceTest {
	
	LawService lawService;
	UserService userService;
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
				//put("hibernate.show_sql", "true");
            }
        };
        
        //lawService = QhseServiceFactory.getLawService(ormProperties);
	}
	
	@Test
	public void testSearch() {
		lawService = QhseServiceFactory.getLawService(ormProperties);
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
        System.out.println(profileChecklistTaskDtos.size());
        /*for(ProfileChecklistTaskDto profileChecklistTaskDto: profileChecklistTaskDtos) {
        	System.out.println("==> id " + profileChecklistTaskDto.getId());
        }*/
        
        for(ProfileChecklistTaskDto profileChecklistTaskDto: profileChecklistTaskDtos) {
        	assertNotNull(profileChecklistTaskDto.getSiteDto());
        	assertNotNull(profileChecklistTaskDto.getResponsibleUserDto());
        	assertNotNull(profileChecklistTaskDto.getBusinessAreaDtos());
        	assertFalse(profileChecklistTaskDto.getBusinessAreaDtos().isEmpty());
        	assertNotNull(profileChecklistTaskDto.getProfileMainDto().getName());
        	assertNotNull(profileChecklistTaskDto.getResponsibleDepartmentDto());
        }
        //set to 10 records per page
        lawService = QhseServiceFactory.getLawService(ormProperties);
        criteria = new TaskQueryCriteria();
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
        criteria = new TaskQueryCriteria();
        criteria.setId(339L);
        result = lawService.queryTask(criteria);
        assertNotNull(result);
        //page number = 1, list size = 1, all records size = 1
        /*assertArrayEquals(new Integer[] {1, 1, 1}, 
        		new Integer[] { result.getPageNumber(), result.getResults().size(), result.getTotalResults() });*/
        assertTrue(result.getPageNumber() == 1);
        assertTrue(result.getResults().size() == 1);
        assertTrue(result.getTotalResults() == 1);
        
        //set to 100 records per page
        lawService = QhseServiceFactory.getLawService(ormProperties);
        criteria = new TaskQueryCriteria();
        criteria.setPageSize(100);
        result = lawService.queryTask(criteria);
        profileChecklistTaskDtos = result.getResults();
        assertTrue(profileChecklistTaskDtos.size() == 83);
        
        //set created by user 10000000078L       
        lawService = QhseServiceFactory.getLawService(ormProperties);
        criteria = new TaskQueryCriteria();
        criteria.setPageSize(100);
        criteria.setCreatedByUser(10000000078L);
        result = lawService.queryTask(criteria);
        profileChecklistTaskDtos = result.getResults();
        assert(profileChecklistTaskDtos.size() == 10);
        
        //set responsible user 40L
        lawService = QhseServiceFactory.getLawService(ormProperties);
        criteria = new TaskQueryCriteria();
        criteria.setPageSize(100);
        criteria.setCreatedByUser(40L);
        result = lawService.queryTask(criteria);
        profileChecklistTaskDtos = result.getResults();
        assert(profileChecklistTaskDtos.size() == 27);
        
        /*System.out.println("==> size " + profileChecklistTaskDtos.size());
        for(ProfileChecklistTaskDto profileChecklistTaskDto: profileChecklistTaskDtos) {
        	System.out.println("==> res id " + profileChecklistTaskDto.getResponsibleUserDto().getId());
        	System.out.println("==> create id " + profileChecklistTaskDto.getCreatedByUserDto().getId());
        }*/
        
	}
	
	@Test
	public void testListOfLawTasksUsers() {
		lawService = QhseServiceFactory.getLawService(ormProperties);
		assertNotNull(lawService);
		
		String siteName = "1-Demo";
		
		List<UserDto> userDtos = lawService.listOfLawTasksUsers(siteName);
		assertTrue(userDtos.size() == 83);
		/*for(UserDto userDto: userDtos) {
			System.out.println(userDto.getLastName());
		}*/
		
		siteName = "2-Sandbox";
		lawService = QhseServiceFactory.getLawService(ormProperties);
		userDtos = lawService.listOfLawTasksUsers(siteName);
		assertTrue(userDtos.size() == 26);
	}
	
	@Test
	public void testLawStatusValues( ) {
		assertTrue(LawStatus.values().size() == 4);
		
		int i = 0;
		String[] names = new String[] { "IN_PROGR", "COMPLETE", "TRASH", "ARCHIVE" };
		for(LawStatus lawStatus: LawStatus.values()) {
			assertTrue(lawStatus.getName().equals(names[i]));
			i++;
		}
	}
	
	@Test
	public void testPriorityValues( ) {
		assertTrue(Priority.values().size() == 3);
		
		int i = 0;
		String[] names = new String[] { "Low", "Medium", "High" };
		for(Priority priority: Priority.values()) {
			assertTrue(priority.getName().equals(names[i]));
			i++;
		}
	}
	
	@Test
	public void testFindTaskById() {
		lawService = QhseServiceFactory.getLawService(ormProperties);
		assertNotNull(lawService);
		
		ProfileChecklistTaskDto profileChecklistTaskDto = lawService.findTaskById(345L);
		assertNotNull(profileChecklistTaskDto);
		assertTrue(profileChecklistTaskDto.getType().equals(CommonConstants.LAW_COMPLIANCE_TASK));
		assertTrue(profileChecklistTaskDto.getStatus().equals(LawStatus.IN_PROGRESS.getName()));
	}
	
}
