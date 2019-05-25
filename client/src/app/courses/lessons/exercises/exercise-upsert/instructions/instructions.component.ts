import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'instructions',
  templateUrl: './instructions.component.html',
  styleUrls: ['./instructions.component.scss']
})
export class InstructionsComponent implements OnInit {

  private shown = false;
  private switcherBugCode = 'if (!switcher.BUGS[0]) {\n    fail();\n}';

  constructor() { }

  ngOnInit() {
  }

  show() {
    this.shown = true;
  }

  hide() {
    this.shown = false;
  }

}
