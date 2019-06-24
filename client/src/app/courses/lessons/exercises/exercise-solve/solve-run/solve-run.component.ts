import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Solution } from '../../shared/solution/solution/solution.model';
import { SolutionService } from '../../shared/solution/solution/solution.service';
import { SolutonSourceService } from '../../shared/solution/solution-source/solution-source.service';
import { SolutonTestService } from '../../shared/solution/solution-test/solution-test.service';
import { SolutionEstimationService } from '../../shared/solution/solution-estimation/solution-estimation.service';
import { SolutionFileService } from '../../shared/solution/solution-file/solution-file.service';
import { SolutionSource } from '../../shared/solution/solution-source/solution-source.model';
import { forkJoin, Observable } from 'rxjs';
import { SolutionTest } from '../../shared/solution/solution-test/solution-test.model';
import { SolutionFile } from '../../shared/solution/solution-file/solution-file.model';
import { SolutionItems } from '../../shared/solution/solution-items/solution-items.model';
import { SolutionEstimation } from '../../shared/solution/solution-estimation/solution-estimation.model';

@Component({
  selector: 'solve-run',
  templateUrl: './solve-run.component.html',
  styleUrls: ['./solve-run.component.scss']
})
export class SolveRunComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  exerciseTypeValue: string;
  solutionSources: Array<SolutionSource>;
  solutionTests: Array<SolutionTest>;
  solutionFiles: Array<SolutionFile>;
  estimation: SolutionEstimation;
  solution: Solution;

  constructor(
    private fb: FormBuilder,
    private solutionService: SolutionService,
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
    this.solutionFormGroup.addControl(
      'solutionEstimation', this.fb.group({
        id: [''],
        solutionId: [''],
        estimation: ['']
      })
    );
  }


  setExerciseType() {
    this.exerciseTypeValue = this.solutionFormGroup.get('intro').get('exerciseType').value;
  }


  async run() {
    this.solutionFormGroup.get('solutionEstimation').get('estimation').setValue('Running...');
    this.setSolutionItems();
    this.solution = await this.saveSolution();
    this.estimation = await this.getEstimation();
    this.showEstimation();
    this.saveSolutionItems();
    console.log('saved solution items');
  }

  setSolutionItems() {
    this.solutionSources = this.solutionFormGroup.get('sourceControl').get('solutionControl').get('tabContent').value;
    this.solutionTests = this.solutionFormGroup.get('testControl').get('solutionControl').get('tabContent').value;
    this.solutionFiles = this.solutionFormGroup.get('fileControl').get('solutionControl').get('tabContent').value;
  }

  getEstimation() {
    const solutionItems = new SolutionItems();
    solutionItems.exerciseId = Number(this.solutionFormGroup.get('intro').get('exerciseId').value);
    solutionItems.solutionId = this.solution.id;
    solutionItems.solutionSources = this.solutionSources;
    solutionItems.solutionTests = this.solutionTests;
    solutionItems.solutionFiles = this.solutionFiles;

    return new Promise<SolutionEstimation>((resolve, reject) => {
      this.solutionEstimationService.estimateSolution(this.exerciseTypeValue, solutionItems).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  showEstimation() {
    this.solutionFormGroup.get('solutionEstimation').get('estimation').setValue(this.estimation.estimation);
    this.solutionFormGroup.get('intro').get('solved').setValue(this.estimation.solved);
    this.solutionFormGroup.get('intro').get('value').setValue(this.estimation.value + '%');
  }

  async saveSolution() {
    const solution = new Solution();
    solution.exerciseId = this.solutionFormGroup.get('intro').get('exerciseId').value;
    return new Promise<Solution>((resolve, reject) => {
      this.solutionService.createSolution(solution).subscribe(
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
    const observables = [];
    this.solutionSources.forEach(sc => {
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
    solutionSource.solutionEstimationId = this.estimation.id;
    return this.solutionSourceService.createSolutionSource(solutionSource);
  }

  saveSolutionTests(): Promise<{}> {
    const observables = [];
    this.solutionTests.forEach(st => {
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
    solutionTest.solutionEstimationId = this.estimation.id;
    return this.solutionTestService.createSolutionTest(solutionTest);
  }

  saveSolutionFiles(): Promise<{}> {
    const observables = [];
    this.solutionFiles.forEach(sf => {
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
    solutionFile.solutionEstimationId = this.estimation.id;
    return this.solutionFileService.createSolutionFile(solutionFile);
  }

}
