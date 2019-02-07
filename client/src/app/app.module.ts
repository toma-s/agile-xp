import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule, 
  MatFormFieldModule, MatSelectModule, MatSortModule } from '@angular/material';
import {MatTableModule} from '@angular/material/table'
import { MatInputModule } from '@angular/material/input';
import { MatToolbarModule } from '@angular/material/toolbar';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { SendTaskComponent } from './send-task/send-task.component';
import { TaskDetailsComponent } from './task-details/task-details.component';
import { TasksListComponent } from './tasks-list/tasks-list.component';
import { CdkColumnDef } from '@angular/cdk/table';


@NgModule({
  declarations: [
    AppComponent,
    SendTaskComponent,
    TasksListComponent,
    TaskDetailsComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpClientModule,
    MatButtonModule, 
    MatCheckboxModule, 
    BrowserAnimationsModule,
    MatInputModule,
    MatToolbarModule,

    BrowserModule,
    BrowserAnimationsModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    AppRoutingModule,

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
