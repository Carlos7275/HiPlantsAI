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
  cabecera = new HttpHeaders().set("authorization", `bearer ${localStorage.getItem("token")!}`);
  private _$refresh = new Subject<void>();

  get refresh() {
    return this._$refresh;
  }

  constructor(private cliente: HttpClient) { }

  iniciarSesion(data: any): Observable<Peticion<any>> {
    return this.cliente.post<any>(Environment.urlApi + 'auth/login', JSON.stringify(data));
  }

  inicioSesion(): boolean {
    return localStorage.getItem("token") != null;
  }

  GuardarToken(data: string): void {
    localStorage.setItem('token', data);
  }

  BorrarDatos(): void {
    localStorage.clear();
  }

  CerrarSesion() {
    return this.cliente.post<Peticion<UsuarioInfo>>(Environment.urlApi + "auth/logout", null, {
      headers: this.cabecera
    });
  }


  Me() {
    return this.cliente.get<Peticion<UsuarioInfo>>(Environment.urlApi + 'auth/me', { headers: { authorization: `bearer ${localStorage.getItem("token")!}` } })
  }

  ObtenerUsuarios(): Observable<PeticionConArreglo<UsuarioInfo>> {
    return this.cliente.get<PeticionConArreglo<UsuarioInfo>>(Environment.urlApi + 'Usuarios', {
      headers: this.cabecera
    });
  }
}

