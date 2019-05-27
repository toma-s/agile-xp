package com.agilexp.service.solution;

import com.agilexp.dbmodel.solution.SolutionContent;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.repository.solution.SolutionTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SolutionTestServiceImpl implements SolutionContentService {

    @Autowired
    SolutionTestRepository repository;

    private final String contentType = "solution test";

    @Override
    public SolutionTest create(SolutionContent solutionContent) {
        SolutionTest newSolutionContent = repository.save(new SolutionTest(
                solutionContent.getSolutionId(),
                solutionContent.getFilename(),
                solutionContent.getContent()
        ));
        System.out.format("Created %s %s%n", contentType, newSolutionContent);
        return newSolutionContent;
    }
}
