package com.agilexp.service.solution;

import com.agilexp.dbmodel.solution.SolutionContent;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.repository.solution.SolutionFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SolutionFileServiceImpl implements SolutionContentService {

    @Autowired
    private SolutionFileRepository repository;

    private final String contentType = "solution file";

    @Override
    public SolutionFile create(SolutionContent solutionContent) {
        SolutionFile newSolutionContent = repository.save(new SolutionFile(
                solutionContent.getSolutionId(),
                solutionContent.getFilename(),
                solutionContent.getContent()
        ));
        System.out.format("Created %s %s%n", contentType, newSolutionContent);
        return newSolutionContent;
    }
}
