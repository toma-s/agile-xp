import { Component, OnInit, ViewChild } from '@angular/core'
import { Observable } from 'rxjs'
import { TaskService } from '../task.service'
import { TaskData } from '../model/task-data'
import { DataSource } from '@angular/cdk/table'
import { MatTableDataSource, MatSort } from '@angular/material'


@Component({
  selector: 'tasks-list',
  templateUrl: './tasks-list.component.html',
  styleUrls: ['./tasks-list.component.scss']
})

export class TasksListComponent implements OnInit {
  dataSource;
  displayedColumns = [];
  @ViewChild(MatSort) sort: MatSort;

  // tasks: TaskData[]

  constructor(private taskService: TaskService) { }

  // columnNames = [
  //   {id: "id", value: "Id"},
  //   {id: "result", value: "Result"}
  // ]

  columnNames = [
    {id: "id",value: "Id"},
    {id: "sourceFilename",value: "SourceFilename"},
    {id: "testFilename",value: "TestFilename"},
    {id: "timestamp",value: "Timestamp"},
    {id: "resultRunTime",value: "ResultRunTime"},
    {id: "resultSuccessful",value: "ResultSuccessful"},
    {id: "resultRunCount",value: "ResultRunCount"},
    {id: "resultFailuresCount",value: "ResultFailuresCount"},
    {id: "resultFailures",value: "ResultFailures"},
    {id: "resultIgnoreCount",value: "ResultIgnoreCount"},
    {id: "compileSuccessful",value: "CompileSuccessful"},
    {id: "compileMessage",value: "CompileMessage"}
  ];

  ngOnInit() {
    this.displayedColumns = this.columnNames.map(x => x.id);
    this.createTable();
  }

  createTable() {
    let tableArr: TaskData[]
    console.log(this.taskService.getTasksList())
    this.taskService.getTasksList()
      .subscribe(tasks => {
        console.log(tasks)
        this.dataSource = new MatTableDataSource(tasks);
        this.dataSource.sort = this.sort;
        tableArr = tasks
      })
    console.log(tableArr)
    // this.dataSource = new MatTableDataSource(tableArr);
    console.log(this.dataSource )
    // this.dataSource.sort = this.sort;

    let tableArrX: Element[] = [
      {id: 1, result: true},
      {id: 2, result: false}
    ]
    console.log(tableArrX)
    // this.dataSource = new MatTableDataSource(tableArrX);
    // console.log(this.dataSource )
    // this.dataSource.sort = this.sort;
  }
}

export interface Element {
  id: number,
  result: boolean
}

