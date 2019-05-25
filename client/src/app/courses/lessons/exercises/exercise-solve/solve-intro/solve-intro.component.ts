import { Component, OnInit, Input, ViewEncapsulation } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { DomSanitizer } from '@angular/platform-browser';

@Component({
  selector: 'solve-intro',
  templateUrl: './solve-intro.component.html',
  styleUrls: ['./solve-intro.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class SolveIntroComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  exerciseName: string;
  exerciseDescription: string;
  lessonName: string;
  html;

  constructor(
    private sanitizer: DomSanitizer
  ) {
  }

  ngOnInit() {
    this.getValues();
    this.sanitize();
  }

  getValues() {
    this.exerciseName = this.solutionFormGroup.get('intro').get('exerciseName').value;
    this.exerciseDescription = this.solutionFormGroup.get('intro').get('exerciseDescription').value;
    this.lessonName = this.solutionFormGroup.get('intro').get('exerciseLessonName').value;
  }

  sanitize() {
    this.html = this.sanitizer.bypassSecurityTrustHtml(this.exerciseDescription);
  }

}
