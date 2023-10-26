import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})

//Servicio para Mostrar el Spinner
export class LoaderService {

  isLoading = new Subject<boolean>();

  constructor() {
  }

  show() {
    this.isLoading.next(true);
  }

  hide() {
    setTimeout(() => {
      this.isLoading.next(false);
    }, 500);
  }
}
