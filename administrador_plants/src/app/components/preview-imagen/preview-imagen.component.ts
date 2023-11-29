import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-preview-imagen',
  templateUrl: './preview-imagen.component.html',
  styleUrls: ['./preview-imagen.component.scss']
})
export class PreviewImagenComponent {
  constructor(@Inject(MAT_DIALOG_DATA) public data: { url: string }) {}

}
