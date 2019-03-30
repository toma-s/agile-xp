import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule,
  MatFormFieldModule, MatSelectModule, MatSortModule, MatToolbarModule } from '@angular/material';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatTabsModule } from '@angular/material/tabs';
import { MatDialogModule } from '@angular/material/dialog';
import { MatDividerModule } from '@angular/material/divider';

import { MonacoEditorModule } from 'ngx-monaco-editor';

import { ExerciseCreateComponent } from './exercise-create/exercise-create.component';
import { CreateWhiteBoxComponent,
  DialogOverviewExampleDialogComponent } from './exercise-create/create-white-box/create-white-box.component';
import { SolveWhiteBoxComponent } from './exercise-solve/solve-white-box/solve-white-box.component';
import { ExerciseSolveComponent } from './exercise-solve/exercise-solve.component';
import { ExercisesRoutingModule } from './exercises-routing.module';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { SolveIntroComponent } from './exercise-solve/solve-intro/solve-intro.component';
import { SolveSourceComponent } from './exercise-solve/solve-source/solve-source.component';
import { SolveTestComponent } from './exercise-solve/solve-test/solve-test.component';

@NgModule({
  entryComponents: [
    DialogOverviewExampleDialogComponent
  ],
  declarations: [
    ExerciseCreateComponent,
    CreateWhiteBoxComponent,
    SolveWhiteBoxComponent,
    ExerciseSolveComponent,
    DialogOverviewExampleDialogComponent,
    ToolbarComponent,
    SolveIntroComponent,
    SolveSourceComponent,
    SolveTestComponent
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
    MatTabsModule,
    MatDialogModule,
    MatDividerModule,
    ExercisesRoutingModule,
    MonacoEditorModule
  ]
})
export class ExercisesModule { }
