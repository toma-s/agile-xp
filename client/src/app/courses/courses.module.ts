import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule,
  MatFormFieldModule, MatSelectModule, MatSortModule, MatToolbarModule } from '@angular/material';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatListModule } from '@angular/material/list';
import { MatPaginatorModule } from '@angular/material/paginator';

import { DragDropModule } from '@angular/cdk/drag-drop';

import { CoursesRoutingModule } from './courses-routing.module';
import { CoursesListComponent } from './courses-list/courses-list.component';
import { CourseDetailComponent } from './course-detail/course-detail.component';
import { LessonsModule } from './lessons/lessons.module';
import { CreateCourseComponent } from './upsert/create-course/create-course.component';
import { CreateLessonComponent } from './upsert/create-lesson/create-lesson.component';
import { EditCourseComponent } from './upsert/edit-course/edit-course.component';
import { EditLessonComponent } from './upsert/edit-lesson/edit-lesson.component';
import { ManageCoursesComponent } from './manage/manage-courses/manage-courses.component';
import { ManageLessonsComponent } from './manage/manage-lessons/manage-lessons.component';
import { ManageExercisesComponent } from './manage/manage-exercises/manage-exercises.component';


@NgModule({
  declarations: [
    CoursesListComponent,
    CourseDetailComponent,
    CreateCourseComponent,
    CreateLessonComponent,
    EditCourseComponent,
    EditLessonComponent,
    ManageLessonsComponent,
    ManageExercisesComponent,
    ManageCoursesComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatCardModule,
    MatCheckboxModule,
    MatProgressSpinnerModule,
    MatMenuModule,
    MatIconModule,
    MatToolbarModule,
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatSortModule,
    MatTableModule,
    MatExpansionModule,
    MatListModule,
    MatPaginatorModule,
    LessonsModule,
    CoursesRoutingModule,
    DragDropModule
  ]
})

export class CoursesModule { }
