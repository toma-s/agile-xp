import { Component } from '@angular/core';
import { MatDialogRef } from '@angular/material';

@Component({
  templateUrl: './dialog.component.html'
})
export class DialogComponent {

  fileExtention: string;

  constructor(
    public dialogRef: MatDialogRef<DialogComponent>
  ) { }

  onNoClick(): void {
    this.dialogRef.close();
  }
}
