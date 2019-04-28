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
import { MatListModule } from '@angular/material/list';

import { MonacoEditorModule } from 'ngx-monaco-editor';
import { QuillModule } from 'ngx-quill';

import { ExerciseSolveComponent } from './exercise-solve/exercise-solve.component';
import { ExercisesRoutingModule } from './exercises-routing.module';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { SolveIntroComponent } from './exercise-solve/solve-intro/solve-intro.component';
import { SolveRunComponent } from './exercise-solve/solve-run/solve-run.component';
import { SolveEditorComponent } from './exercise-solve/solve-editor/solve-editor.component';
import { LoadSolutionDialogComponent } from './exercise-solve/load-solution-dialog/load-solution-dialog.component';
import { MatPaginatorModule } from '@angular/material/paginator';
import { ExerciseCreateComponent } from './exercise-upsert/exercise-create/exercise-create.component';
import { ExerciseEditComponent } from './exercise-upsert/exercise-edit/exercise-edit.component';
import { DialogComponent } from './exercise-upsert/dialog/dialog.component';
import { CreateIntroComponent } from './exercise-upsert/create-intro/create-intro.component';
import { CreateEditorsComponent } from './exercise-upsert/create-editors/create-editors.component';
import { CreateSubmitComponent } from './exercise-upsert/create-submit/create-submit.component';
import { ErrorComponent } from './exercise-upsert/error/error.component';
import { EditorComponent } from './exercise-upsert/editor/editor.component';
import { ExerciseCreaterService } from './exercise-upsert/utils/exercise-creater.service';


@NgModule({
  entryComponents: [
    DialogComponent,
    LoadSolutionDialogComponent
  ],
  declarations: [
    ExerciseSolveComponent,
    ToolbarComponent,
    SolveIntroComponent,
    SolveRunComponent,
    CreateIntroComponent,
    DialogComponent,
    CreateEditorsComponent,
    CreateSubmitComponent,
    EditorComponent,
    SolveEditorComponent,
    ErrorComponent,
    LoadSolutionDialogComponent,
    ExerciseCreateComponent,
    ExerciseEditComponent
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
    MatListModule,
    MatPaginatorModule,
    ExercisesRoutingModule,
    MonacoEditorModule,
    QuillModule
  ]
})
export class ExercisesModule { }
