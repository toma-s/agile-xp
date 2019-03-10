import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule,
  MatFormFieldModule, MatSelectModule, MatSortModule, MatToolbarModule } from '@angular/material';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatExpansionModule } from '@angular/material/expansion';

import { ExerciseCreateComponent } from './exercise-create/exercise-create.component';
import { CreateWhiteBoxComponent } from './exercise-create/create-white-box/create-white-box.component';
import { SolveWhiteBoxComponent } from './exercise-solve/solve-white-box/solve-white-box.component';
import { ExerciseSolveComponent } from './exercise-solve/exercise-solve.component';
import { ExercisesRoutingModule } from './exercises-routing.module';

@NgModule({
  declarations: [
    ExerciseCreateComponent,
    CreateWhiteBoxComponent,
    SolveWhiteBoxComponent,
    ExerciseSolveComponent,
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
    ExercisesRoutingModule,
  ]
})
export class ExercisesModule { }
