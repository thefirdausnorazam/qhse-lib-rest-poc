package com.ideagen.qhse.orm.dao;

import java.util.List;
import java.util.Optional;

import com.ideagen.qhse.orm.entity.QuestionOption;

public interface QuestionOptionDao {
	
	Optional<QuestionOption> findByName(String name);
	
	Optional<QuestionOption> findById(Long id);
	
	/**
     * Get a list of all searchable QuestionOptions for a given question id.
     *
     * @param questionId Id of the question options to return
     * @param activeOnly <code>true</code> if only active options should be returned, otherwise
     *            all options will be returned.
     * @return non null list of <code>QuestionOptions</code> objects.
     */
    List<QuestionOption> listSearchable(long questionId);

}
