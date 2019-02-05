import {Component, OnInit} from '@angular/core';

import {UploadFileService} from '../upload-file.service';
import { Task } from '../Task'

@Component({
  selector: 'send-file',
  templateUrl: './send-file.component.html',
  styleUrls: ['./send-file.component.scss']
})
export class SendFileComponent implements OnInit {

  task: Task = new Task();
  submitted = false;

  constructor(private uploadFileService: UploadFileService) { }

  ngOnInit(): void {
  }

  newTask(): void {
    this.submitted = false;
    this.task = new Task();
  }

  save() {
    this.uploadFileService.createTask(this.task)
      .subscribe(
        data => console.log(data),
        error => console.log(error)
      );
    this.task = new Task();
  }

  onSubmit() {
    this.submitted = true;
    this.save();
  }

}
