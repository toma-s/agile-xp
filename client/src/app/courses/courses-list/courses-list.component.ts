import { Component, OnInit } from '@angular/core';
import { CourseService } from '../shared/course.service';
import { Course } from '../shared/course.model';
import { MatTableDataSource } from '@angular/material';
import { SelectionModel } from '@angular/cdk/collections';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-courses-list',
  templateUrl: './courses-list.component.html',
  styleUrls: ['./courses-list.component.scss']
})
export class CoursesListComponent implements OnInit {

  displayedColumns = ['id', 'name', 'created', 'delete'];
  dataSource: any;
  data: any;
  selection = new SelectionModel<Element>(true, []);

  constructor(private courseService: CourseService) { }

  ngOnInit() {
    this.getData();
  }

  delete(course) {
    this.courseService.deleteCourse(course.id)
      .subscribe(
        data => {
          console.log(data);
          this.getData();
        },
        error => console.log('error: ' + error)
      );
  }

  getData() {
    this.courseService.getCoursesList()
      .subscribe(
        data => {
          console.log(data);
          this.data = Object.assign(data);
          this.dataSource = new MatTableDataSource<Element>(this.data);
        },
        error => console.log('error: ' + error)
      );
  }

  isAllSelected() {
    const numSelected = this.selection.selected.length;
    const numRows = this.dataSource.data.length;
    return numSelected === numRows;
  }

  removeSelectedRows() {

    this.selection.selected.forEach(item => {
      const index: number = this.data.findIndex(d => d === item);
      console.log(this.data.findIndex(d => d === item));
      this.data.splice(index, 1);
      this.dataSource = new MatTableDataSource<Element>(this.data);
    });
    this.selection = new SelectionModel<Element>(true, []);
  }

  masterToggle() {
    this.isAllSelected() ?
      this.selection.clear() :
      this.dataSource.data.forEach(row => this.selection.select(row));
  }

}
