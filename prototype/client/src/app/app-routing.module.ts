import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SendTaskComponent } from './send-task/send-task.component';
import { TasksListComponent } from './tasks-list/tasks-list.component';

const routes: Routes = [
  { path: '', redirectTo: 'sendTask', pathMatch: 'full'},
  { path: 'sendTask', component: SendTaskComponent},
  { path: 'tasksList', component: TasksListComponent}
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
