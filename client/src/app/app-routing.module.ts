import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SendTaskComponent } from './tasks/send-task/send-task.component';
import { TasksListComponent } from './tasks/tasks-list/tasks-list.component';

const routes: Routes = [
  { path: '', redirectTo: 'sendTask', pathMatch: 'full'},
  { path: 'courses', redirectTo: '/courses', pathMatch: 'full'},
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
