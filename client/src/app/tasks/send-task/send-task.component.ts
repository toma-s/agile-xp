import { Component, OnInit } from '@angular/core';
import { TaskService } from '../shared/task.service';
import { TaskContent } from '../task/task-content';
import { TaskData } from '../shared/task-data';

@Component({
  selector: 'send-file',
  templateUrl: './send-task.component.html',
  styleUrls: ['./send-task.component.scss']
})

export class SendTaskComponent implements OnInit {

  taskContent: TaskContent = new TaskContent();
  taskData: TaskData = new TaskData();
  submitted = false;
  response = undefined;
  gotTestResult = false;

  constructor(private fileService: TaskService) { }

  ngOnInit(): void {
  }

  newTask(): void {
    this.taskContent = new TaskContent();
    this.taskData = new TaskData();
    this.submitted = false;
    this.taskContent = new TaskContent();
    this.response = undefined;
    this.gotTestResult = false;
  }

  save() {
    this.fileService.createTask(this.taskContent)
      .subscribe(
        id => {
          this.get(id);
        },
        error => {
          console.log(error);
          this.response = error.error;
        }
      );
    // this.taskContent = new TaskContent();
    // this.taskData = new TaskData();
  }

  get(idVal: string) {
    const id = Number(idVal);
    this.fileService.getTaskById(id)
      .subscribe (
        (data: TaskData) => {
          this.taskData = data;
          this.gotTestResult = true;
          this.response = data.compileMessage;
        },
        error => {
          console.log(error);
        }
      );
  }

  onSubmit() {
    this.submitted = true;
    this.save();
  }

}
