package com.ideagen.qhse.pojo.service.impl;

import java.util.Map;

import com.ideagen.qhse.orm.dao.impl.GroupDaoImpl;
import com.ideagen.qhse.orm.entity.Group;
import com.ideagen.qhse.pojo.dto.GroupDto;
import com.ideagen.qhse.pojo.dto.SiteDto;
import com.ideagen.qhse.pojo.service.GroupService;

public class GroupServiceImpl extends AbstractServiceImpl implements GroupService {
	
	private GroupDaoImpl groupDao;

    public GroupServiceImpl(Map<String, String> ormProperties) {
    	groupDao = new GroupDaoImpl(ormProperties);
    }

	@Override
	public GroupDto getGroupByName(String name) {
		
		return groupDao.findByName(name)
                .map(object -> grouptoDto(object))
                .orElse(null);
	}

	@Override
	public GroupDto getGroupById(Long id) {
		
		return groupDao.findById(id)
                .map(object -> grouptoDto(object))
                .orElse(null);
	}
	
	private GroupDto grouptoDto(Group group) {
        
		GroupDto groupDto = new GroupDto();
        abstractCopyProperties(groupDto, group);
        
        SiteDto siteDto = new SiteDto();
        abstractCopyProperties(siteDto, group.getSite());
        groupDto.setSiteDto(siteDto);
        
        return groupDto;
    }

}
