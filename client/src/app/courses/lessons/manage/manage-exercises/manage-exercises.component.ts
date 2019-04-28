import { Component } from '@angular/core';
import { ManageComponent } from '../manage.component';
import { Title } from '@angular/platform-browser';
import { LessonService } from '../../shared/lesson.service';
import { ExerciseService } from '../../exercises/shared/exercise/exercise/exercise.service';
import { ActivatedRoute } from '@angular/router';
import { Lesson } from '../../shared/lesson.model';
import { Exercise } from '../../exercises/shared/exercise/exercise/exercise.model';
import { forkJoin } from 'rxjs';

@Component({
  selector: 'manage-exercises',
  templateUrl: '../manage.component.html',
  styleUrls: ['../manage.component.scss']
})
export class ManageExercisesComponent extends ManageComponent {

  protected module = 'exercises';
  protected routerLink = '../../';
  protected parent: Lesson;
  protected content: Array<Exercise>;
  protected parentName;
  protected contentName;

  constructor(
    protected titleService: Title,
    protected route: ActivatedRoute,
    private lessonServise: LessonService,
    private exerciseService: ExerciseService
  ) {
    super(titleService, route);
  }


  setNames() {
    this.parentName = 'lesson';
    this.contentName = 'exercise';
  }


  async readParams() {
    this.parent = await this.getLesson();
  }

  getLesson(): Promise<Lesson> {
    const lessonId = this.route.snapshot.params['lessonId'];
    return new Promise<Lesson>((resolve, reject) => {
      this.lessonServise.getLessonById(lessonId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  async getContent() {
    this.content = await this.getExercises();
  }

  getExercises(): Promise<Array<Exercise>> {
    return new Promise<Array<Exercise>>((resolve, reject) => {
      this.exerciseService.getExercisesByLessonId(this.parent.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  reorder(newExercisesArray) {
    const observables = [];
    for (let i = 0; i < this.content.length; i++) {
      this.content[i].index = i;
      observables.push(
        this.exerciseService.updateExercise(this.content[i].id, this.content[i])
      );
    }
    forkJoin(observables).subscribe(
      data => {
        console.log(data);
      },
      error => {
        console.log(error);
        this.content = Object.assign([], newExercisesArray);
      }
    );
  }


  delete(exerciseId) {
    this.exerciseService.deleteExercise(exerciseId).subscribe(
      data => {
        console.log(data);
        this.load();
      },
      error => console.log(error)
    );
  }

}
