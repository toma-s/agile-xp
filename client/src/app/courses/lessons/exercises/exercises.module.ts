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

import { ExerciseCreateComponent } from './exercise-create/exercise-create.component';
import { ExerciseSolveComponent } from './exercise-solve/exercise-solve.component';
import { ExercisesRoutingModule } from './exercises-routing.module';
import { ToolbarComponent } from './toolbar/toolbar.component';
import { SolveIntroComponent } from './exercise-solve/solve-intro/solve-intro.component';
import { SolveRunComponent } from './exercise-solve/solve-run/solve-run.component';
import { CreateIntroComponent } from './exercise-create/create-intro/create-intro.component';
import { DialogComponent } from './exercise-create/dialog/dialog.component';
import { CreateEditorsComponent } from './exercise-create/create-editors/create-editors.component';
import { CreateSubmitComponent } from './exercise-create/create-submit/create-submit.component';
import { EditorComponent } from './exercise-create/editor/editor.component';
import { SolveEditorComponent } from './exercise-solve/solve-editor/solve-editor.component';

@NgModule({
  entryComponents: [
    DialogComponent
  ],
  declarations: [
    ExerciseCreateComponent,
    ExerciseSolveComponent,
    ToolbarComponent,
    SolveIntroComponent,
    SolveRunComponent,
    CreateIntroComponent,
    DialogComponent,
    CreateEditorsComponent,
    CreateSubmitComponent,
    EditorComponent,
    SolveEditorComponent
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
    ExercisesRoutingModule,
    MonacoEditorModule,
    QuillModule
  ]
})
export class ExercisesModule { }
