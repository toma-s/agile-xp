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
      error => console.log(error)
    );
  }
}
