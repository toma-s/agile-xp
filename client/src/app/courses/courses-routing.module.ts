import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CoursesListComponent } from './courses-list/courses-list.component';
import { CourseDetailComponent } from './course-detail/course-detail.component';
import { ExerciseSolveComponent } from './lessons/exercises/exercise-solve/exercise-solve.component';
import { ExerciseCreateComponent } from './lessons/exercises/exercise-create/exercise-create.component';
import { ManageLessonsComponent } from './lessons/manage/manage-lessons/manage-lessons.component';
import { ManageExercisesComponent } from './lessons/manage/manage-exercises/manage-exercises.component';
import { CreateLessonComponent } from './upsert/create-lesson/create-lesson.component';
import { CreateCourseComponent } from './upsert/create-course/create-course.component';
import { EditCourseComponent } from './upsert/edit-course/edit-course.component';
import { EditLessonComponent } from './upsert/edit-lesson/edit-lesson.component';

const routes: Routes = [
  { path: '', redirectTo: 'courses', pathMatch: 'full'},
  { path: 'courses', component: CoursesListComponent},
  { path: 'courses/create/course', component: CreateCourseComponent},
  { path: 'courseDetail/:courseId/edit/course', component: EditCourseComponent},
  { path: 'courseDetail/:id', component: CourseDetailComponent},
  { path: 'courseDetail/:courseId/manageLessons/create/lesson/:index', component: CreateLessonComponent},
  { path: 'courseDetail/:courseId/manageLessons/:lessonId/edit/lesson', component: EditLessonComponent},
  { path: 'courseDetail/:courseId/manageLessons', component: ManageLessonsComponent},
  { path: 'courseDetail/:courseId/:lessonId/manageExercises/create/exercise/:index', component: ExerciseCreateComponent},
  { path: 'courseDetail/:courseId/:lessonId/manageExercises', component: ManageExercisesComponent},
  { path: 'courseDetail/:courseId/lesson/:lessonId/exerciseSolve/:exerciseId', component: ExerciseSolveComponent},
  { path: '../', redirectTo: 'courses' }
];

@NgModule({
  imports: [
    RouterModule.forChild(routes)
  ],
  exports: [
    RouterModule
  ]
})

export class CoursesRoutingModule { }
