import { Component, OnInit } from '@angular/core';

import { UploadFileService } from '../upload-file.service';
import { TaskContent } from '../model/task-content'
import { TaskData } from '../model/task-data';

@Component({
  selector: 'send-file',
  templateUrl: './send-file.component.html',
  styleUrls: ['./send-file.component.scss']
})

export class SendFileComponent implements OnInit {

  taskContent: TaskContent = new TaskContent()
  taskData: TaskData = new TaskData()
  submitted = false
  runTests = false

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
          this.runTests = true
          console.log(data)
          console.log(this.taskData.sourceFilename)
        },
        error => console.log(error)
      );
    this.taskContent = new TaskContent()
  }

  onSubmit() {
    this.submitted = true
    this.save()
  }

}
