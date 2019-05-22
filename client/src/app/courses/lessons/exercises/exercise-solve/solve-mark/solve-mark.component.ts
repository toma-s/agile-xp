import { Component, Input, OnInit } from '@angular/core';
import { FormGroup, ControlContainer } from '@angular/forms';
import { Solution } from '../../shared/solution/solution/solution.model';
import { SolutionService } from '../../shared/solution/solution/solution.service';
import { SolutionEstimationService } from '../../shared/solution/solution-estimation/solution-estimation.service';
import { SolutionEstimation } from '../../shared/solution/solution-estimation/solution-estimation.model';

@Component({
  selector: 'solve-mark',
  templateUrl: './solve-mark.component.html',
  styleUrls: ['./solve-mark.component.scss']
})
export class SolveMarkComponent implements OnInit {

  form: FormGroup;
  solution: Solution;
  estimation: SolutionEstimation;

  constructor(
    private solutionService: SolutionService,
    private solutionEstimationService: SolutionEstimationService,
    public controlContainer: ControlContainer
  ) { }

  ngOnInit(): void {
    this.form = <FormGroup>this.controlContainer.control;
  }

  async markSolved() {
    this.solution = await this.saveSolution();
    this.estimation = await this.saveMarkSolved();
    this.showEstimation();
  }

  saveSolution() {
    const solution = new Solution();
    solution.exerciseId = this.form.get('exerciseId').value;
    return new Promise<Solution>((resolve, reject) => {
      this.solutionService.createSolution(solution).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveMarkSolved() {
    return new Promise<SolutionEstimation>((resolve, reject) => {
      this.solutionEstimationService.markSolved(this.solution.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  showEstimation() {
    this.form.get('solved').setValue(this.estimation.solved);
    this.form.get('value').setValue(this.estimation.value + '%');
  }

  async markNotSolved() {
    this.solution = await this.saveSolution();
    this.estimation = await this.saveMarkNotSolved();
    this.showEstimation();
  }

  saveMarkNotSolved() {
    return new Promise<SolutionEstimation>((resolve, reject) => {
      this.solutionEstimationService.markNotSolved(this.solution.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

}
