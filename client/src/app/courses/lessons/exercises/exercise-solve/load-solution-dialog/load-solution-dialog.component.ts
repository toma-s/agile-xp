import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material';
import { SolutionEstimationService } from '../../shared/solution/solution-estimation/solution-estimation.service';
import { SolutionContent } from '../../shared/solution/solution-content/solution-content.model';
import { SolutionItems } from '../../shared/solution/solution-items/solution-items.model';

@Component({
  selector: 'load-solution-dialog',
  templateUrl: './load-solution-dialog.component.html',
  styleUrls: ['./load-solution-dialog.component.scss']
})
export class LoadSolutionDialogComponent implements OnInit {

  exerciseId: number;
  solutionType: string;
  loadedEstimations: Array<SolutionItems>;
  currentContent: Map<number, Array<SolutionContent>>;
  chosen: SolutionContent;

  constructor(
    public dialogRef: MatDialogRef<LoadSolutionDialogComponent>,
    private solutionEstimationService: SolutionEstimationService
  ) { }

  async ngOnInit() {
    this.loadedEstimations = await this.loadEstimations();
    console.log(this.loadedEstimations);
    this.setCurrentContent();
  }

  loadEstimations() {
    return new Promise<Array<SolutionItems>>((resolve, reject) => {
      this.solutionEstimationService.getSolutionEstimationsByExerciseIdAndType(this.exerciseId, this.solutionType).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  setCurrentContent() {
    this.currentContent = new Map();
    switch (this.solutionType) {
      case 'source': {
        for (let i = 0; i < this.loadedEstimations.length; i++) {
          const content = new Array<SolutionContent>();
          this.loadedEstimations[i].solutionSources.forEach(ss => {
            content.push(ss);
          });
          this.currentContent[i] = content;
        }
        break;
      }
      case 'test': {
        for (let i = 0; i < this.loadedEstimations.length; i++) {
          const content = new Array<SolutionContent>();
          this.loadedEstimations[i].solutionTests.forEach(ss => {
            content.push(ss);
          });
          this.currentContent[i] = content;
        }
        break;
      }
      case 'file': {
        for (let i = 0; i < this.loadedEstimations.length; i++) {
          const content = new Array<SolutionContent>();
          this.loadedEstimations[i].solutionFiles.forEach(ss => {
            content.push(ss);
          });
          this.currentContent[i] = content;
        }
        break;
      }
    }
  }


  choose(content: SolutionContent) {
    this.chosen = content;
  }


  onCloseClick(): void {
    this.dialogRef.close();
  }

}
