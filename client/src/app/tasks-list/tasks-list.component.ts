import { Component, OnInit, ViewChild } from '@angular/core';
import { TaskService } from '../task.service';
import { TaskData } from '../model/task-data';
import { MatTableDataSource, MatSort } from '@angular/material';


@Component({
  selector: 'tasks-list',
  templateUrl: './tasks-list.component.html',
  styleUrls: ['./tasks-list.component.scss']
})

export class TasksListComponent implements OnInit {
  dataSource;
  displayedColumns = [];

  constructor(private taskService: TaskService) { }

  columnNames = [
    {id: 'id', value: 'Id'},
    {id: 'sourceFilename', value: 'SourceFilename'},
    {id: 'testFilename', value: 'TestFilename'},
    {id: 'timestamp', value: 'Timestamp'},
    {id: 'resultRunTime', value: 'ResultRunTime'},
    {id: 'resultSuccessful', value: 'ResultSuccessful'},
    {id: 'resultRunCount', value: 'ResultRunCount'},
    {id: 'resultFailuresCount', value: 'ResultFailuresCount'},
    {id: 'resultFailures', value: 'ResultFailures'},
    {id: 'resultIgnoreCount', value: 'ResultIgnoreCount'},
    {id: 'compileSuccessful', value: 'CompileSuccessful'},
    {id: 'compileMessage', value: 'CompileMessage'}
  ];

  ngOnInit() {
    this.displayedColumns = this.columnNames.map(x => x.id);
    this.createTable();
  }

  createTable() {
    this.taskService.getTasksList()
      .subscribe(tasks => {
        // this.datepipe.transform(ts, 'yyyy-MM-dd');
        this.dataSource = new MatTableDataSource(tasks);
      });
  }
}
