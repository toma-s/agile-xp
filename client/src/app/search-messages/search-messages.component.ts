import { Component, OnInit } from '@angular/core';
import { Message } from '../message';
import { MessageService } from '../message.service';
import {Timestamp} from 'rxjs';

@Component({
  selector: 'search-messages',
  templateUrl: './search-messages.component.html',
  styleUrls: ['./search-messages.component.scss']
})
export class SearchMessagesComponent implements OnInit {

  sender: string;
  messages: Message[];

  constructor(private dataService: MessageService) { }

  ngOnInit() {
    this.sender = '';
  }

  private searchMessage() {
    this.dataService.getMessagesBySender(this.sender)
      .subscribe(
        messages => this.messages = messages
      );
  }

  onSubmit() {
    this.searchMessage();
  }

}
