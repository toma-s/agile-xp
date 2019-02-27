import { Component, OnInit, ViewChild } from '@angular/core';
import { Observable } from 'rxjs';
import { TaskService } from '../shared/task.service';
import { TaskData } from '../shared/task-data';
import { DataSource } from '@angular/cdk/table';
import { MatTableDataSource, MatSort } from '@angular/material';


@Component({
  selector: 'tasks-list',
  templateUrl: './tasks-list.component.html',
  styleUrls: ['./tasks-list.component.scss']
})

export class TasksListComponent implements OnInit {
  dataSource: any;
  displayedColumns = [];

  constructor(private taskService: TaskService) { }

  columnNames = [
    {id: 'id', value: 'Id'},
    {id: 'sourceFilename', value: 'Source code filename'},
    {id: 'testFilename', value: 'Test filename'},
    {id: 'timestamp', value: 'Date and time'},
    {id: 'resultRunTime', value: 'Tests running time'},
    {id: 'resultSuccessful', value: 'Tests succeeded'},
    {id: 'resultRunCount', value: 'Tests run count'},
    {id: 'resultFailuresCount', value: 'Failures count'},
    {id: 'resultFailures', value: 'Failures'},
    {id: 'resultIgnoreCount', value: 'Ignored tests count'},
    {id: 'compileSuccessful', value: 'Compilation succeeded'},
    {id: 'compileMessage', value: 'Compilation message'}
  ];

  ngOnInit() {
    this.displayedColumns = this.columnNames.map(x => x.id);
    this.createTable();
  }

  createTable() {
    this.taskService.getTasksList()
      .subscribe(tasks => {
        this.dataSource = new MatTableDataSource(tasks);
      });

  }
}
