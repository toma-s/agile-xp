import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { CreateMessageComponent } from './create-message/create-message.component';
import { MessageDetailsComponent } from './message-details/message-details.component';
import { MessagesListComponent } from './messages-list/messages-list.component';
import { SearchMessagesComponent } from './search-messages/search-messages.component';
import { AppRoutingModule } from './app-routing.module';
import { HttpClientModule } from '@angular/common/http';
import { SendFileComponent } from './send-file/send-file.component';

@NgModule({
  declarations: [
    AppComponent,
    CreateMessageComponent,
    MessageDetailsComponent,
    MessagesListComponent,
    SearchMessagesComponent,
    SendFileComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
