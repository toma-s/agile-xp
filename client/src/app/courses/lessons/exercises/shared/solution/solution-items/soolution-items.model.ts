import { SolutionSource } from '../solution-source/solution-source.model';
import { SolutionTest } from '../solution-test/solution-test.model';
import { SolutionFile } from '../solution-file/solution-file.model';

export class SolutionItems {
  exerciseId: number;
  solutionSources: Array<SolutionSource>;
  solutionTests: Array<SolutionTest>;
  solutionFiles: Array<SolutionFile>;
}
