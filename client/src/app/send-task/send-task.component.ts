import { Component, OnInit } from '@angular/core';

import { UploadFileService } from '../upload-task.service';
import { TaskContent } from '../model/task-content'
import { TaskData } from '../model/task-data';

@Component({
  selector: 'send-file',
  templateUrl: './send-task.component.html',
  styleUrls: ['./send-task.component.scss']
})

export class SendTaskComponent implements OnInit {

  taskContent: TaskContent = new TaskContent()
  taskData: TaskData = new TaskData()
  submitted = false
  gotResult = false

  constructor(private uploadFileService: UploadFileService) { }

  ngOnInit(): void {
  }

  newTask(): void {
    this.submitted = false
    this.taskContent = new TaskContent()
  }

  save() {
    this.uploadFileService.createTask(this.taskContent)
      .subscribe(
        (data: TaskData) => {
          this.taskData = data
          this.gotResult = true
          console.log(data)
          console.log(this.taskData.sourceFilename)
        },
        error => console.log(error)
      );
    this.taskContent = new TaskContent()
    this.taskData = new TaskData()
  }

  onSubmit() {
    this.submitted = true
    this.save()
  }

}
