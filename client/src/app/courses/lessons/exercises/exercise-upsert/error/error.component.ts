import { Component, OnInit } from '@angular/core';
import { ControlContainer, FormGroup } from '@angular/forms';

@Component({
  selector: 'error',
  templateUrl: './error.component.html',
  styleUrls: ['./error.component.scss']
})
export class ErrorComponent implements OnInit {

  error: FormGroup;

  constructor(
    public controlContainer: ControlContainer
  ) { }

  ngOnInit() {
    this.error = <FormGroup>this.controlContainer.control;
    console.log(this.error);
  }

}
