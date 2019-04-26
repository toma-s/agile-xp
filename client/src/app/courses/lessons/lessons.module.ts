import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule,
  MatFormFieldModule, MatSelectModule, MatSortModule, MatToolbarModule } from '@angular/material';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatExpansionModule } from '@angular/material/expansion';

import { DragDropModule } from '@angular/cdk/drag-drop';

import { LessonsRoutingModule } from './lessons-routing.module';
import { ExercisesModule } from './exercises/exercises.module';
import { ManageLessonsComponent } from './manage/manage-lessons/manage-lessons.component';
import { ManageExercisesComponent } from './manage/manage-exercises/manage-exercises.component';


@NgModule({
  declarations: [
    ManageLessonsComponent,
    ManageExercisesComponent
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
    LessonsRoutingModule,
    ExercisesModule,
    DragDropModule
  ]
})
export class LessonsModule { }
