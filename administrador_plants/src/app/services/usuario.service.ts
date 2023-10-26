import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { environment } from 'src/enviroments/enviroment.prod';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UsuarioInfo } from '../models/Usuario.model';
import { Peticion, PetitionConArreglo } from '../models/Peticion.model';

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
    return this.cliente.post<any>(environment.urlApi + 'auth/login', JSON.stringify(data));
  }

  inicioSesion() {
    return localStorage.getItem("token") != null;
  }
  GuardarToken(data: string) {
    localStorage.setItem('token', data);
  }

  Me() {
    return this.cliente.get<Peticion<UsuarioInfo>>(environment.urlApi + 'auth/me', { headers: this.cabecera })
  }

  GuardarUsuarioInfo(info_usuario: UsuarioInfo) {
    localStorage.setItem('info_usuario', JSON.stringify(info_usuario));
  }
  ObtenerUsuarios(): Observable<PetitionConArreglo<UsuarioInfo>> {
    return this.cliente.get<PetitionConArreglo<UsuarioInfo>>(environment.urlApi + 'Usuarios', {
      headers: this.cabecera
    });
  }
}

