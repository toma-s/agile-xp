import { Component, OnInit } from '@angular/core';

import { Message } from '../message';
import { MessageService } from '../message.service';

@Component({
  selector: 'create-message',
  templateUrl: './create-message.component.html',
  styleUrls: ['./create-message.component.scss']
})
export class CreateMessageComponent implements OnInit {

  message: Message = new Message();
  submitted = false;

  constructor(private messageService: MessageService) { }

  ngOnInit() {
  }

  newMessage(): void {
    this.submitted = false;
    this.message = new Message();
  }

  save() {
    this.messageService.createMessage(this.message)
      .subscribe(
        data => console.log(data),
        error => console.log(error)
      );
    this.message = new Message();
  }

  onSubmit() {
    this.submitted = true;
    this.save();
  }

}
