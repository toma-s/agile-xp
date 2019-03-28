import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { SendTaskComponent } from './tasks/send-task/send-task.component';
import { TasksListComponent } from './tasks/tasks-list/tasks-list.component';
import { CdkColumnDef } from '@angular/cdk/table';

import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule,
  MatFormFieldModule, MatSelectModule, MatSortModule, MatToolbarModule, MatListModule } from '@angular/material';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatTabsModule } from '@angular/material/tabs';
import { MatDialogModule } from '@angular/material/dialog';
import { MatDividerModule } from '@angular/material/divider';

import { DragDropModule } from '@angular/cdk/drag-drop';

import { MonacoEditorModule } from 'ngx-monaco-editor';

import { CoursesModule } from './courses/courses.module';



@NgModule({
  declarations: [
    AppComponent,
    SendTaskComponent,
    TasksListComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
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
    MatListModule,
    MatTabsModule,
    MatDialogModule,
    MatDividerModule,
    CoursesModule,
    MonacoEditorModule.forRoot(),
    DragDropModule
  ],
  providers: [CdkColumnDef],
  bootstrap: [AppComponent]
})

export class AppModule { }
