import { Component, OnInit, ViewChild } from '@angular/core';
import { CourseService } from '../shared/course.service';
import { Title } from '@angular/platform-browser';
import { MatTableDataSource, MatPaginator } from '@angular/material';
import { SelectionModel } from '@angular/cdk/collections';

@Component({
  selector: 'app-courses-list',
  templateUrl: './courses-list.component.html',
  styleUrls: ['./courses-list.component.scss']
})
export class CoursesListComponent implements OnInit {

  displayedColumns = ['name', 'description', 'created'];
  dataSource: any;
  data: any;
  selection = new SelectionModel<Element>(true, []);

  @ViewChild(MatPaginator) paginator: MatPaginator;

  constructor(
    private titleService: Title,
    private courseService: CourseService
  ) { }

  ngOnInit() {
    this.setTitle();
    this.getData();
  }

  setTitle() {
    this.titleService.setTitle(`Courses | AgileXP`);
  }

  getData() {
    this.courseService.getCoursesList().subscribe(
      data => {
        console.log(data);
        this.data = Object.assign(data);
        this.dataSource = new MatTableDataSource<Element>(this.data);
        this.dataSource.paginator = this.paginator;
        console.log(this.dataSource.paginator);
      },
      error => console.log('error: ' + error)
    );
  }

  delete(course) {
    this.courseService.deleteCourse(course.id).subscribe(
      data => {
        console.log(data);
        this.getData();
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
