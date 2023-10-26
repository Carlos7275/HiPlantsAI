import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { LoginModel } from '../models/Login.model';
import { Petition } from '../models/Petition.model';
import { environment } from 'src/enviroments/enviroment.prod';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioInfo } from '../models/Usuario.model';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  cabecera= new HttpHeaders().set("Authorization", `Bearer ${localStorage.getItem("token")!}`);
  private _$refresh = new Subject<void>();

  get refresh() {
    return this._$refresh;
  }


  constructor(private cliente: HttpClient) {}
  iniciarSesion(data: any): Observable<Petition<any>> {
  return this.cliente.post<any>(environment.urlApi + 'auth/login', JSON.stringify(data));
  }

  GuardarToken(data: string) {
    localStorage.setItem('token', data);
  }

  Me(){
    return this.cliente.get<Petition<UsuarioInfo>>(environment.urlApi + 'auth/me',{headers:this.cabecera})
  }

  GuardarUsuarioInfo(info_usuario:UsuarioInfo){
    localStorage.setItem('info_usuario',JSON.stringify(info_usuario));
  }
}
