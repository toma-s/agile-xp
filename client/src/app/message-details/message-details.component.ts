import { Component, OnInit, Input } from '@angular/core';
import { MessageService } from '../message.service';
import { Message } from '../message';

import { MessagesListComponent } from '../messages-list/messages-list.component';

@Component({
  selector: 'message-details',
  templateUrl: './message-details.component.html',
  styleUrls: ['./message-details.component.scss']
})
export class MessageDetailsComponent implements OnInit {

  @Input() message: Message;

  constructor(private messageService: MessageService, private listComponent: MessagesListComponent) { }

  ngOnInit() {
  }

  // updateMessage() {
  //   this.messageService.updateMesage(this.message.id,
  //     {
  //       sender: this.message.sender,
  //       text: this.message.text})
  //     .subscribe(
  //       data => {
  //         console.log(data);
  //         this.message = data as Message;
  //       },
  //       error => console.log(error));
  // }

  deleteMessage() {
    this.messageService.deleteMesage(this.message.id)
      .subscribe(
        data => {
          console.log(data);
          this.listComponent.reloadData();
        },
        error => console.log(error));
  }

}
