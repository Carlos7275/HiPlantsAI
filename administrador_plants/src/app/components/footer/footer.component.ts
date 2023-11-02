import { Component } from '@angular/core';
import { Environment } from 'src/enviroments/enviroment.prod';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.scss']
})
export class FooterComponent {
  version: String = Environment.version;
  year: number = new Date().getFullYear();
}
