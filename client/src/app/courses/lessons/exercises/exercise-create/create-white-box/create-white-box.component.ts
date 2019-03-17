import { Component } from '@angular/core';
import { ControlContainer, FormGroupDirective } from '@angular/forms';

@Component({
  selector: 'create-white-box',
  templateUrl: './create-white-box.component.html',
  styleUrls: ['./create-white-box.component.scss'],
  viewProviders: [ {
    provide: ControlContainer,
    useExisting: FormGroupDirective
  }]
})
export class CreateWhiteBoxComponent {
}
