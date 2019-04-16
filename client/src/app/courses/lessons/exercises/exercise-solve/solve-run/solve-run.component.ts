import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Solution } from '../../shared/solution/solution.model';
import { SolutonService } from '../../shared/solution/soluton.service';
import { SolutonSourceService } from '../../shared/solution-source/solution-source.service';
import { SolutonTestService } from '../../shared/solution-test/solution-test.service';
import { SolutionEstimationService } from '../../shared/solution-estimation/solution-estimation.service';
import { SolutionFileService } from '../../shared/solution-file/solution-file.service';
import { SolutionSource } from '../../shared/solution-source/solution-source.model';
import { forkJoin, Observable } from 'rxjs';
import { SolutionTest } from '../../shared/solution-test/solution-test.model';
import { SolutionFile } from '../../shared/solution-file/solution-file.model';
import { ExerciseType } from '../../shared/exercise-type/exercise-type.model';

@Component({
  selector: 'solve-run',
  templateUrl: './solve-run.component.html',
  styleUrls: ['./solve-run.component.scss']
})
export class SolveRunComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  private solution: Solution;
  private exerciseTypeValue: string;

  constructor(
    private fb: FormBuilder,

    private solutionService: SolutonService,
    private solutionSourceService: SolutonSourceService,
    private solutionTestService: SolutonTestService,
    private solutionFileService: SolutionFileService,
    private solutionEstimationService: SolutionEstimationService
  ) { }

  ngOnInit() {
    this.updForm();
    this.setExerciseType();
  }

  updForm() {
    this.createSolutionEstimation();
  }

  createSolutionEstimation() {
    this.solutionFormGroup.addControl(
      'solutionEstimation', this.createEstimation()
    );
  }

  createEstimation() {
    return this.fb.group({
      id: [''],
      solutionId: [''],
      estimation: ['']
    });
  }

  setExerciseType() {
    this.exerciseTypeValue = this.solutionFormGroup.controls.intro.controls.exerciseType.value;
  }


  async run() {
    this.solutionFormGroup.controls.solutionEstimation.controls.estimation.value = 'Running...';

    await this.setSolution();
    await this.saveSolutionItems();
    await this.getEstimation();
  }

  async setSolution() {
    const solution = await this.saveSolution();

    console.log(solution);
    this.solution = solution;
  }

  saveSolution(): any {
    this.solution = new Solution();
    this.solution.exerciseId = this.solutionFormGroup.get('intro').get('exerciseId').value;
    // TODO | create with exerciseId only?
    return new Promise((resolve, reject) => {
      this.solutionService.createSolution(this.solution).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  async saveSolutionItems() {
    switch (this.exerciseTypeValue) {
      case 'whitebox': {
        await this.saveSolutionSources();
        await this.saveSolutionTests();
        break;
      }
      case 'whitebox-file': {
        await this.saveSolutionSources();
        await this.saveSolutionTests();
        await this.saveSolutionFiles();
        break;
      }
      case 'blackbox': {
        await this.saveSolutionTests();
        break;
      }
      case 'blackbox-file': {
        await this.saveSolutionTests();
        await this.saveSolutionFiles();
        break;
      }
      default: {
        console.log('defaut: Solution type was not found');
      }
    }
  }

  saveSolutionSources(): Promise<{}> {
    const solutionSources: Array<SolutionSource> = this.solutionFormGroup.get('sourceControl').get('solutionControl').value;
    const observables = [];
    solutionSources.forEach(sc => {
      observables.push(this.saveSolutionSource(sc));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveSolutionSource(solutionSource: SolutionSource): Observable<{}> {
    solutionSource.solutionId = this.solution.id;
    return this.solutionSourceService.createSolutionSource(solutionSource);
  }

  saveSolutionTests(): Promise<{}> {
    const solutionTests: Array<SolutionTest> = this.solutionFormGroup.get('testControl').get('solutionControl').value;
    const observables = [];
    solutionTests.forEach(st => {
      observables.push(this.saveSolutionTest(st));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveSolutionTest(solutionTest: SolutionTest): Observable<{}> {
    solutionTest.solutionId = this.solution.id;
    return this.solutionTestService.createSolutionTest(solutionTest);
  }

  saveSolutionFiles(): Promise<{}> {
    const solutionFiles: Array<SolutionFile> = this.solutionFormGroup.get('fileControl').get('solutionControl').value;
    const observables = [];
    solutionFiles.forEach(sf => {
      observables.push(this.saveSolutionFile(sf));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveSolutionFile(solutionFile: SolutionFile): Observable<{}> {
    solutionFile.solutionId = this.solution.id;
    return this.solutionFileService.createSolutionFile(solutionFile);
  }

  getEstimation() {
    this.solutionEstimationService.estimateSourceTestSolution(this.exerciseTypeValue, this.solution.id)
      .subscribe(
        data => {
          console.log(data);
          this.solutionFormGroup.get('solutionEstimation').get('estimation').setValue(data.estimation);
        },
        error => console.log(error)
      );
  }

}
