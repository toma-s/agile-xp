import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { MatButtonModule, MatCheckboxModule, MatMenuModule, MatProgressSpinnerModule, MatIconModule,
  MatFormFieldModule, MatSelectModule, MatSortModule, MatToolbarModule } from '@angular/material';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';

import { CoursesRoutingModule } from './courses-routing.module';
import { CoursesComponent } from './courses.component';
import { CourseCreateComponent } from './course-create/course-create.component';
import { CoursesListComponent } from './courses-list/courses-list.component';
import { CourseDetailComponent } from './course-detail/course-detail.component';

@NgModule({
  declarations: [
    CourseCreateComponent,
    CoursesListComponent,
    CoursesComponent,
    CourseDetailComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    CoursesRoutingModule,
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
  ]
})

export class CoursesModule { }
