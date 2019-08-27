package com.ideagen.qhse.pojo.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.ideagen.qhse.orm.dao.impl.QuestionOptionDaoImpl;
import com.ideagen.qhse.orm.entity.QuestionOption;
import com.ideagen.qhse.orm.entity.Site;
import com.ideagen.qhse.pojo.dto.QuestionDto;
import com.ideagen.qhse.pojo.dto.QuestionHelpDto;
import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.dto.SiteDto;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;

public class QuestionMaintenanceServiceImpl extends AbstractServiceImpl implements QuestionMaintenanceService {
	
	private QuestionOptionDaoImpl questionOptionDao;

    public QuestionMaintenanceServiceImpl(Map<String, String> ormProperties) {
    	questionOptionDao = new QuestionOptionDaoImpl(ormProperties);
    }
    
    @Override
	public QuestionOptionDto getQuestionOptionByName(String name) {
		
		return questionOptionDao.findByName(name)
                .map(questionOption -> questionOptiontoDto(questionOption))
                .orElse(null);
	}

	@Override
	public QuestionOptionDto getQuestionOptionById(Long id) {
		
		return questionOptionDao.findById(id)
                .map(questionOption -> questionOptiontoDto(questionOption))
                .orElse(null);
	}

	@Override
	public List<QuestionOptionDto> listSearchableDepartments() {
		
		List<QuestionOptionDto> questionOptionDtos = new ArrayList<QuestionOptionDto>();
		
		for(QuestionOption questionOption: questionOptionDao.listSearchable(QuestionMaintenanceService.DEPARTMENT_ID)) {
			
			/*QuestionOptionDto questionOptionDto = new QuestionOptionDto();
			
			try {
				BeanUtils.copyProperties(questionOptionDto, questionOption);
				
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}*/
			questionOptionDtos.add(questionOptiontoDto(questionOption));
			
		}
		
		return questionOptionDtos;
	}
	
	private QuestionOptionDto questionOptiontoDto(QuestionOption questionOption) {
        
		QuestionOptionDto questionOptionDto = new QuestionOptionDto();
		/*UserDto createdDto = new UserDto();
		UserDto updatedDto = new UserDto();
		List<RoleDto> roleDtos = new ArrayList<RoleDto>();
        
        try {
			BeanUtils.copyProperties(questionOptionDto, questionOption);
			
			if(questionOption.getCreatedByUser() != null) {
				BeanUtils.copyProperties(createdDto, questionOption.getCreatedByUser());
				questionOptionDto.setCreatedByUserDto(createdDto);
				
				for(Role role: questionOption.getCreatedByUser().getRoles()) {
					RoleDto roleDto = new RoleDto();
					BeanUtils.copyProperties(roleDto, role);
					roleDtos.add(roleDto);
				}
				
				questionOptionDto.getCreatedByUserDto().setRolesDto(roleDtos);
			}
			
			if(questionOption.getLastUpdatedByUser() != null) {
				BeanUtils.copyProperties(updatedDto, questionOption.getLastUpdatedByUser());
				questionOptionDto.setLastUpdatedByUserDto(updatedDto);
			}
			
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}*/
		
		abstractCopyProperties(questionOptionDto, questionOption);
		if(questionOption.getDependsOn() != null) {
			
			QuestionOptionDto dependsOnDto = new QuestionOptionDto();
			abstractCopyProperties(dependsOnDto, questionOption.getDependsOn());
			questionOptionDto.setDependsOnDto(dependsOnDto);
		}
		
		if(questionOption.getQuestion() != null) {
			
			QuestionDto questionDto = new QuestionDto();
			abstractCopyProperties(questionDto, questionOption.getQuestion());
			questionOptionDto.setQuestionDto(questionDto);
			
			if(questionOption.getQuestion().getParentQuestion() != null) {
				QuestionDto parentQuestionDto = new QuestionDto();
				abstractCopyProperties(parentQuestionDto, questionOption.getQuestion().getParentQuestion());
				questionOptionDto.getQuestionDto().setParentQuestionDto(parentQuestionDto);
			}
			
			if(questionOption.getQuestion().getHelp() != null) {
				QuestionHelpDto helpDto = new QuestionHelpDto();
				abstractCopyProperties(helpDto, questionOption.getQuestion().getHelp());
				questionOptionDto.getQuestionDto().setHelpDto(helpDto);
			}
		}
		
		if(!questionOption.getInactiveInSites().isEmpty()) {
			
			Set<SiteDto> inactiveInSitesDto = new HashSet<SiteDto>();
			
			for(Site site: questionOption.getInactiveInSites()) {
				SiteDto siteDto = new SiteDto();
				abstractCopyProperties(siteDto, site);
				inactiveInSitesDto.add(siteDto);
			}
			
			questionOptionDto.setInactiveInSitesDto(inactiveInSitesDto);
		}
		
        return questionOptionDto;
    }

}
