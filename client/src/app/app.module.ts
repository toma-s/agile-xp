import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
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
import { QuillModule } from 'ngx-quill';

import { CoursesModule } from './courses/courses.module';
import { NotFoundComponent } from './not-found/not-found.component';

const quillConfig = {
};

@NgModule({
  declarations: [
    AppComponent,
    NotFoundComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
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
    QuillModule.forRoot(quillConfig),
    DragDropModule,
    AppRoutingModule
  ],
  providers: [CdkColumnDef],
  bootstrap: [AppComponent]
})

export class AppModule { }
