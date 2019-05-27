package com.agilexp.service.solution;

import com.agilexp.dbmodel.solution.SolutionContent;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.repository.solution.SolutionSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SolutionSourceServiceImpl implements SolutionContentService {

    @Autowired
    private SolutionSourceRepository repository;

    private final String contentType = "solution source";

    @Override
    public SolutionSource create(SolutionContent solutionContent) {
        SolutionSource newSolutionContent = repository.save(new SolutionSource(
                solutionContent.getSolutionId(),
                solutionContent.getFilename(),
                solutionContent.getContent()
        ));
        System.out.format("Created %s %s%n", contentType, newSolutionContent);
        return newSolutionContent;
    }
}
