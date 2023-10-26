import { HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
@Injectable({
  providedIn: 'root'
})
export class ErrorHandlerService {
  public errorMessage: string = '';
  constructor(private router: Router,private snackBar:MatSnackBar) { }
  public handleError = (error: HttpErrorResponse) => {
   
    if (error.status === 500) {
      this.handle500Error(error);
      localStorage.clear();
    }
    else if (error.status === 404) {
      this.handle404Error(error)
    }
    else {
      this.handleOtherError(error);
    }
  }
  private handle500Error = (error: HttpErrorResponse) => {
    this.createErrorMessage(error);
    this.snackBar.open("Hubo un Error en el Servidor","Cerrar",{duration:3000});
    this.router.navigate(['error500']);
    
  }
  private handle404Error = (error: HttpErrorResponse) => {
    this.createErrorMessage(error);
    this.snackBar.open("Algo Fallo","Cerrar",{duration:3000});
    this.router.navigate(['error404']);
  }
  private handleOtherError = (error: HttpErrorResponse) => {
    this.createErrorMessage(error); //TODO: this will be fixed later; 
  }
  private createErrorMessage = (error: HttpErrorResponse) => {
    this.errorMessage = error.error ? error.error : error.statusText;
  }
}