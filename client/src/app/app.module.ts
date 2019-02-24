import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule,
  MatFormFieldModule, MatSelectModule, MatSortModule } from '@angular/material';
import {MatTableModule} from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatToolbarModule } from '@angular/material/toolbar';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { SendTaskComponent } from './tasks/send-task/send-task.component';
import { TasksListComponent } from './tasks/tasks-list/tasks-list.component';
import { CdkColumnDef } from '@angular/cdk/table';
import { MatCardModule } from '@angular/material/card';
import { CoursesCreateComponent } from './courses/courses-create/courses-create.component';


@NgModule({
  declarations: [
    AppComponent,
    SendTaskComponent,
    TasksListComponent,
    CoursesCreateComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpClientModule,
    MatCheckboxModule,
    BrowserAnimationsModule,
    MatCardModule,
    ReactiveFormsModule,
    MatProgressSpinnerModule,
    MatMenuModule,
    MatIconModule,
    MatToolbarModule,
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatSortModule,
    MatTableModule
  ],
  providers: [CdkColumnDef],
  bootstrap: [AppComponent]
})

export class AppModule { }
