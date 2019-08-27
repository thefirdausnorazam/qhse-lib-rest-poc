package com.ideagen.qhse.pojo.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;

import com.ideagen.qhse.orm.dao.impl.SearchOperationsDaoImpl;
import com.ideagen.qhse.orm.entity.ProfileChecklistTask;
import com.ideagen.qhse.orm.entity.RiskBusinessArea;
import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.orm.query.config.BooleanQueryFilter;
import com.ideagen.qhse.orm.query.config.QueryDefinition;
import com.ideagen.qhse.orm.query.config.QueryFilter;
import com.ideagen.qhse.orm.query.config.QuerySort;
import com.ideagen.qhse.orm.query.config.SimpleFilter;
import com.ideagen.qhse.orm.query.impl.ListBackedSearchResult;
import com.ideagen.qhse.pojo.dto.ProfileChecklistTaskDto;
import com.ideagen.qhse.pojo.dto.RiskBusinessAreaDto;
import com.ideagen.qhse.pojo.dto.SiteDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;
import com.ideagen.qhse.pojo.service.LawService;

public class LawServiceImpl extends AbstractServiceImpl implements LawService {

	private SearchOperationsDaoImpl searchOperationsDao;
	private QueryDefinition queryDefinition;

	public LawServiceImpl(Map<String, String> ormProperties) {
		initializeQueryDefinition();
		searchOperationsDao = new SearchOperationsDaoImpl(ormProperties, queryDefinition);
	}

	@Override
	public QueryResult queryTask(TaskQueryCriteria criteria) {
		
		List<ProfileChecklistTaskDto> profileChecklistTaskDtos = new ArrayList<ProfileChecklistTaskDto>();
		
		ListBackedSearchResult queryResult = (ListBackedSearchResult)searchOperationsDao.search(criteria);
		
		for(ProfileChecklistTask profileChecklistTask: ((List<ProfileChecklistTask>)queryResult.getResults())) {
			profileChecklistTaskDtos.add(profileChecklistTasktoprofileChecklistTaskDto(profileChecklistTask));
		}
		
		return new ListBackedSearchResult(profileChecklistTaskDtos, queryResult.getPageNumber(), queryResult.getPageSize(), queryResult.isMore(), queryResult.getTotalResults(), queryResult.getSortName());
		
	}
	
	private ProfileChecklistTaskDto profileChecklistTasktoprofileChecklistTaskDto(ProfileChecklistTask profileChecklistTask) {
		
		ProfileChecklistTaskDto profileChecklistTaskDto = new ProfileChecklistTaskDto();
		abstractCopyProperties(profileChecklistTaskDto, profileChecklistTask);
		//site
		SiteDto siteDto = new SiteDto();
		try {
			BeanUtils.copyProperties(siteDto, profileChecklistTask.getSite());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		profileChecklistTaskDto.setSiteDto(siteDto);
		//responsible user
		UserDto responsibleUserDto = new UserDto();
		try {
			BeanUtils.copyProperties(responsibleUserDto, profileChecklistTask.getResponsibleUser());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		profileChecklistTaskDto.setResponsibleUserDto(responsibleUserDto);
		//completed user
		UserDto completedByUserDto = new UserDto();
		try {
			if(profileChecklistTask.getCompletedByUser() != null)
				BeanUtils.copyProperties(completedByUserDto, profileChecklistTask.getCompletedByUser());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		profileChecklistTaskDto.setCompletedByUserDto(completedByUserDto);
		//business area
		if(!profileChecklistTask.getBusinessAreas().isEmpty()) {
			Set<RiskBusinessAreaDto> riskBusinessAreaDtos = new HashSet<RiskBusinessAreaDto>();
			
			for(RiskBusinessArea riskBusinessArea: profileChecklistTask.getBusinessAreas()) {
				RiskBusinessAreaDto riskBusinessAreaDto = new RiskBusinessAreaDto();
				try {
					BeanUtils.copyProperties(riskBusinessAreaDto, riskBusinessArea);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
				riskBusinessAreaDtos.add(riskBusinessAreaDto);
			}
			
			profileChecklistTaskDto.setBusinessAreaDtos(riskBusinessAreaDtos);
		}
		//parent task id
		if(profileChecklistTask.getProfileChecklistTask() != null) {
			ProfileChecklistTaskDto parentProfileChecklistTaskDto = new ProfileChecklistTaskDto();
			try {
				BeanUtils.copyProperties(parentProfileChecklistTaskDto, profileChecklistTask.getProfileChecklistTask());
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			profileChecklistTaskDto.setProfileChecklistTaskDto(parentProfileChecklistTaskDto);
		}
			
		return profileChecklistTaskDto;
		
	}

	private void initializeQueryDefinition() {
		
		queryDefinition = new QueryDefinition();
		
		String sql = "select distinct x from ProfileChecklistTask x inner join x.businessAreas ba";
		queryDefinition.setSelection(sql);
		
        BooleanQueryFilter filter = new BooleanQueryFilter();
        filter.setName("overdue");
        filter.setTrueFilter("x.status in ('IN_PROGR') and x.targetCompletionDate &lt; scansol_curdate()");
        filter.setFalseFilter("1=1");		
		
		QueryFilter[] filters = new QueryFilter[] { new SimpleFilter("currentSite", "x.site in (:currentSearchSite)"),
				new SimpleFilter("id", "x.id = :id"),
				new SimpleFilter("name", "x.name like concat('%', :name, '%')"),
		        new SimpleFilter("status", "x.status = :status"),
		        new SimpleFilter("statusNotSet", "x.status in ('IN_PROGR', 'COMPLETE')"),
		        new SimpleFilter("priority", "x.priority = :priority"),
		        new SimpleFilter("startDateFrom", "x.creationDate &gt;= :startDateFrom"),
		        new SimpleFilter("startDateTo", "x.creationDate &lt;= :startDateToEOD"),
		        new SimpleFilter("lastUpdateDateFrom", "x.lastUpdatedTs &gt;= :lastUpdateDateFrom"),
		        new SimpleFilter("lastUpdateDateTo", "x.lastUpdatedTs &lt;= :lastUpdateDateTo"),
		        new SimpleFilter("targetCompletionDateFrom", "x.targetCompletionDate &gt;= :targetCompletionDateFrom"),
		        new SimpleFilter("targetCompletionDateTo", "x.targetCompletionDate &lt;= :targetCompletionDateToEOD"),
		        new SimpleFilter("completionDateFrom", "x.completionDate &gt;= :completionDateFrom"),
		        new SimpleFilter("completionDateTo", "x.completionDate &lt;= :completionDateToEOD"),
		        new SimpleFilter("responsibleUser", "x.responsibleUser = :responsibleUser"),
		        new SimpleFilter("createdByUser", "x.createdByUser = :createdByUser"),
		        new SimpleFilter("departmentId", "x.responsibleDepartment = :departmentId"),
		        filter, new SimpleFilter("businessAreaId","ba.id = :businessAreaId") };
		
		queryDefinition.setFilters(filters);
		
		QuerySort[] sorts = new QuerySort[] { new QuerySort("id", "x.id desc", true), new QuerySort("description", "x.name asc"),
				new QuerySort("responsibleUser", "x.responsibleUser", true), new QuerySort("targetCompletionDate", "x.targetCompletionDate desc"),
				new QuerySort("creationDate", "x.creationDate desc", true), new QuerySort("lastUpdatedTs", "x.lastUpdatedTs desc") };
		
		queryDefinition.setSorts(sorts);
	}

}
