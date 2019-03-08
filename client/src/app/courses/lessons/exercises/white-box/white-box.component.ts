import { Component } from '@angular/core';
import { ControlContainer, FormGroupDirective } from '@angular/forms';

@Component({
  selector: 'white-box',
  templateUrl: './white-box.component.html',
  styleUrls: ['./white-box.component.scss'],
  viewProviders: [ {
    provide: ControlContainer,
    useExisting: FormGroupDirective
  }]
})
export class WhiteBoxComponent {
}
