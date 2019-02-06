import { Component, OnInit } from '@angular/core'
import { Observable } from 'rxjs'
import { MessageService } from '../message.service'
import { Message } from '../message'


@Component({
  selector: 'messages-list',
  templateUrl: './messages-list.component.html',
  styleUrls: ['./messages-list.component.scss']
})

export class MessagesListComponent implements OnInit {

  messages: Observable<Message[]>

  constructor(private messageService: MessageService) { }

  ngOnInit() {
    this.reloadData()
  }

  deleteMessages() {
    this.messageService.deleteAll()
      .subscribe(
        data => {
          console.log(data)
          this.reloadData()
        },
        error => console.log('error: ' + error))
  }

  reloadData() {
    this.messages = this.messageService.getMessagesList()
  }

}
