import { Component, OnInit } from '@angular/core';
import { MatDialogRef, PageEvent } from '@angular/material';
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
  shownEstimations: Array<SolutionItems>;
  currentContent: Map<number, Array<SolutionContent>>;
  chosen: SolutionContent;
  currentIndex = 0;
  pageSize = 8;
  length;
  pageEvent: PageEvent;

  constructor(
    public dialogRef: MatDialogRef<LoadSolutionDialogComponent>,
    private solutionEstimationService: SolutionEstimationService
  ) { }

  async ngOnInit() {
    this.loadedEstimations = await this.loadEstimations();
    this.shownEstimations = Object.assign([], this.loadedEstimations);
    this.length = this.loadEstimations.length;
    console.log(this.loadedEstimations);
    console.log(this.shownEstimations);
    this.setCurrentContent();
  }

  loadEstimations() {
    console.log(this.pageSize);
    console.log(this.currentIndex);
    return new Promise<Array<SolutionItems>>((resolve, reject) => {
      this.solutionEstimationService.getSolutionEstimationsByExerciseIdAndType(this.exerciseId, this.solutionType, this.currentIndex,
        this.pageSize).subscribe(
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

  async loadMore() {
    this.currentIndex ++;
    const loaded: Array<SolutionItems> = await this.loadEstimations();
    loaded.forEach(element => {
      this.loadedEstimations.push(element);
    });
    this.length = this.loadedEstimations.length;
    this.setCurrentContent();
    console.log(this.loadedEstimations);
    console.log(this.shownEstimations);
    console.log(this.length);
  }

  async pageChangeEvent(event) {
    console.log(event);
    this.currentIndex = event.pageIndex;
    const start = this.currentIndex * this.pageSize;
    const end = (this.currentIndex + 1) * this.pageSize;
    this.shownEstimations = Object.assign([], this.loadedEstimations.slice(start, end));
    console.log(start);
    console.log(end);
    console.log(this.loadedEstimations);
    console.log(this.shownEstimations);
  }


  onCloseClick(): void {
    this.dialogRef.close();
  }

}
