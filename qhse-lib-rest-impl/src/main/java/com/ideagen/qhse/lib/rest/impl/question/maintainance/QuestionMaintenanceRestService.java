package com.ideagen.qhse.lib.rest.impl.question.maintainance;

import com.ideagen.qhse.lib.rest.impl.RestService;
import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import org.springframework.util.LinkedMultiValueMap;

import java.util.Collection;
import java.util.List;
import java.util.Map;

public class QuestionMaintenanceRestService extends RestService implements QuestionMaintenanceService {

    protected QuestionMaintenanceRestService(Map<String, String> properties) {
        super(properties);
    }

    @Override
    public QuestionOptionDto getQuestionOptionByName(String name) {
        return requestSingle(QuestionOptionDto.class, QuestionMaintainanceServiceRequestMapping.GET_QUESTION_OPTION_BY_NAME_FULL_PATH,
                new LinkedMultiValueMap<>() {
                    {
                        add("name", name);
                    }
                });
    }

    @Override
    public QuestionOptionDto getQuestionOptionById(Long id) {
        return requestSingle(QuestionOptionDto.class, QuestionMaintainanceServiceRequestMapping.GET_QUESTION_OPTION_BY_ID_FULL_PATH,
                new LinkedMultiValueMap<>() {
                    {
                        add("id", id);
                    }
                });
    }

    @Override
    public List<QuestionOptionDto> listSearchableDepartments() {
        Collection<QuestionOptionDto> questionOptionDtoCollection
                = requestCollection(QuestionOptionDto.class, QuestionMaintainanceServiceRequestMapping.LIST_SEARCHABLE_DEPARTMENT_FULL_PATH);

        return List.copyOf(questionOptionDtoCollection);
    }
}
