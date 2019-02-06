import { Component, OnInit } from '@angular/core'
import { Observable } from 'rxjs'
import { TaskService } from '../task.service'
import { TaskData } from '../model/task-data';

@Component({
  selector: 'tasks-list',
  templateUrl: './tasks-list.component.html',
  styleUrls: ['./tasks-list.component.scss']
})
export class TasksListComponent implements OnInit {

  tasks: Observable<TaskData[]>

  constructor(private taskService: TaskService) { }

  ngOnInit() {
    this.tasks = this.taskService.getTasksList()
  }

}
