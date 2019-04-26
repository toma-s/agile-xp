import { Component, OnInit } from '@angular/core';
import { LessonService } from '../shared/lesson.service';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../exercises/shared/exercise/exercise/exercise.service';
import { Lesson } from '../shared/lesson.model';
import { Exercise } from '../exercises/shared/exercise/exercise/exercise.model';
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import { forkJoin } from 'rxjs';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-manage',
  templateUrl: './manage.component.html',
  styleUrls: ['./manage.component.scss']
})
export class ManageComponent implements OnInit {

  lesson: Lesson;
  exercises: Array<Exercise>;
  index: number;

  constructor(
    private titleService: Title,
    private lessonServise: LessonService,
    private exerciseService: ExerciseService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.setTitle();
    this.getLessonByIdParam();
  }

  setTitle() {
    this.titleService.setTitle(`Edit lesson | AgileXP`);
  }

  getLessonByIdParam() {
    const lesson$ = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.lessonServise.getLessonById(Number(params.get('lessonId')))
      )
    );
    lesson$
      .subscribe(
        data => {
          console.log(data);
          this.lesson = data;
          this.getExercises();
        },
        error => console.log(error)
      );
  }

  getExercises() {
    this.exerciseService.getExercisesByLessonId(this.lesson.id)
      .subscribe(
        data => {
          console.log(data);
          this.exercises = data;
          this.getIndex();
        },
        error => console.log(error)
      );
  }

  getIndex() {
    this.index = this.exercises.length;
    console.log(this.index);
  }

  drop(event: CdkDragDrop<string[]>) {
    const newExercisesArray = Object.assign([], this.exercises);
    moveItemInArray(this.exercises, event.previousIndex, event.currentIndex);
    this.reorder(newExercisesArray);
  }

  reorder(newExercisesArray) {
    const observables = [];
    for (let i = 0; i < this.exercises.length; i++) {
      this.exercises[i].index = i;
      observables.push(
        this.exerciseService.updateExercise(this.exercises[i].id, this.exercises[i])
      );
    }
    forkJoin(observables).subscribe(
      data => {
        console.log(data);
      },
      error => {
        console.log(error);
        this.exercises = Object.assign([], newExercisesArray);
      }
    );
  }

}
