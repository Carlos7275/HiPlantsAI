import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioInfo } from '../models/Usuario.model';
import { Peticion, PeticionConArreglo } from '../models/Peticion.model';
import { Environment } from 'src/enviroments/enviroment.prod';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  cabecera = new HttpHeaders().set("Authorization", `Bearer ${localStorage.getItem("token")!}`);
  private _$refresh = new Subject<void>();

  get refresh() {
    return this._$refresh;
  }

  constructor(private cliente: HttpClient) { }

  iniciarSesion(data: any): Observable<Peticion<any>> {
    return this.cliente.post<any>(Environment.urlApi + 'auth/login', JSON.stringify(data));
  }

  inicioSesion() {
    return localStorage.getItem("token") != null;
  }
  GuardarToken(data: string) {
    localStorage.setItem('token', data);
  }

  Me() {
    return this.cliente.get<Peticion<UsuarioInfo>>(Environment.urlApi + 'auth/me', { headers: this.cabecera })
  }

  GuardarUsuarioInfo(info_usuario: UsuarioInfo) {
    localStorage.setItem('info_usuario', JSON.stringify(info_usuario));
  }
  ObtenerUsuarios(): Observable<PeticionConArreglo<UsuarioInfo>> {
    return this.cliente.get<PeticionConArreglo<UsuarioInfo>>(Environment.urlApi + 'Usuarios', {
      headers: this.cabecera
    });
  }
}

