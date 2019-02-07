import { Component, OnInit, Input } from '@angular/core'
import { TaskData } from '../model/task-data';

@Component({
  selector: 'task-details',
  templateUrl: './task-details.component.html',
  styleUrls: ['./task-details.component.scss']
})
export class TaskDetailsComponent implements OnInit {

  @Input() task: TaskData

  constructor() { }

  ngOnInit() {
  }

}
