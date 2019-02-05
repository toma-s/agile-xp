import { NgModule } from '@angular/core';
import {RouterModule, Routes} from "@angular/router";
import { MessagesListComponent } from './messages-list/messages-list.component';
import { CreateMessageComponent } from './create-message/create-message.component';
import { SearchMessagesComponent } from './search-messages/search-messages.component';
import { SendFileComponent } from './send-file/send-file.component';

const routes: Routes = [
  { path: '', redirectTo: 'message', pathMatch: 'full'},
  { path: 'message', component: MessagesListComponent },
  { path: 'add', component: CreateMessageComponent },
  { path: 'findBySender', component: SearchMessagesComponent },
  { path: 'sendFile', component: SendFileComponent}
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports: [
    RouterModule
  ],
  declarations: []
})

export class AppRoutingModule { }
