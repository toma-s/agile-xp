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
import { ExerciseSolveComponent } from './exercise-solve/exercise-solve.component';
import { ExercisesRoutingModule } from './exercises-routing.module';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { SolveIntroComponent } from './exercise-solve/solve-intro/solve-intro.component';
import { SolveSourceComponent } from './exercise-solve/solve-source/solve-source.component';
import { SolveTestComponent } from './exercise-solve/solve-test/solve-test.component';
import { SolveFileComponent } from './exercise-solve/solve-file/solve-file.component';
import { SolveRunComponent } from './exercise-solve/solve-run/solve-run.component';
import { CreateIntroComponent } from './exercise-create/create-intro/create-intro.component';
import { CreateSourceComponent } from './exercise-create/create-source/create-source.component';
import { DialogComponent } from './exercise-create/dialog/dialog.component';
import { CreateTestComponent } from './exercise-create/create-test/create-test.component';
import { CreateEditorComponent } from './exercise-create/create-editor/create-editor.component';
import { CreateFileComponent } from './exercise-create/create-file/create-file.component';
import { CreateSubmitComponent } from './exercise-create/create-submit/create-submit.component';

@NgModule({
  entryComponents: [
    DialogComponent
  ],
  declarations: [
    ExerciseCreateComponent,
    ExerciseSolveComponent,
    ToolbarComponent,
    SolveIntroComponent,
    SolveSourceComponent,
    SolveTestComponent,
    SolveFileComponent,
    SolveRunComponent,
    CreateIntroComponent,
    CreateSourceComponent,
    DialogComponent,
    CreateTestComponent,
    CreateEditorComponent,
    CreateFileComponent,
    CreateSubmitComponent
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
