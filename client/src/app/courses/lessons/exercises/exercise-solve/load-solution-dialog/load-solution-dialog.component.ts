import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material';
import { SolutionEstimationService } from '../../shared/solution/solution-estimation/solution-estimation.service';
import { SolutonSourceService } from '../../shared/solution/solution-source/solution-source.service';
import { SolutonTestService } from '../../shared/solution/solution-test/solution-test.service';
import { SolutionFileService } from '../../shared/solution/solution-file/solution-file.service';
import { SolutionContent } from '../../shared/solution/solution-content/solution-content.model';
import { SolutionEstimation } from '../../shared/solution/solution-estimation/solution-estimation.model';

@Component({
  selector: 'load-solution-dialog',
  templateUrl: './load-solution-dialog.component.html',
  styleUrls: ['./load-solution-dialog.component.scss']
})
export class LoadSolutionDialogComponent implements OnInit {

  exerciseId: number;
  solutionType: string;
  loadedSolutions: Array<SolutionContent>;
  loadedEstimations: Array<SolutionEstimation>;

  constructor(
    public dialogRef: MatDialogRef<LoadSolutionDialogComponent>,
    private solutionEstimationService: SolutionEstimationService,
    private solutionSourceService: SolutonSourceService,
    private solutionTestService: SolutonTestService,
    private solutionFileService: SolutionFileService,
  ) { }

  async ngOnInit() {
    // this.loadedEstimations = await this.loadEstimations();
    // console.log(this.loadEstimations);
    // this.loadSolutions();
  }

  // loadEstimations() {
  //   return new Promise<Array<SolutionEstimation>>((resolve, reject) => {
  //     this.solutionEstimationService.getSolutionEstimationsByExerciseId(this.exerciseId).subscribe(
  //       data => resolve(data),
  //       error => reject(error)
  //     );
  //   });
  // }

  loadSolutions() {
    switch (this.solutionType) {
      case 'source': {
        this.solutionSourceService.getSolutionSourcesByExerciseId(this.exerciseId).subscribe(
          data => {
            this.loadedSolutions = data;
            console.log(data);
          },
          error => console.log(error)
        );
        console.log('source');
        break;
      }
      case 'test': {
        console.log('test');
        break;
      }
      case 'file': {
        console.log('file');
        break;
      }
    }
  }

  onCloseClick(): void {
    this.dialogRef.close();
  }

}
