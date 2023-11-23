import { Injectable } from '@angular/core';
import { Observable, tap } from 'rxjs';
import { UsuarioInfo } from '../models/Usuario.model';
import { Peticion, PeticionConArreglo } from '../models/Peticion.model';
import { Environment } from 'src/enviroments/enviroment';
import { Rol } from '../models/Rol.model';
import { Genero } from '../models/Genero.model';
import { CP } from '../models/CodigoP.model';
import { Service } from './service';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService extends Service {

  iniciarSesion(data: any): Observable<Peticion<any>> {
    return this.cliente.post<any>(Environment.urlApi + 'auth/loginAdmin', JSON.stringify(data));
  }

  inicioSesion(): boolean {
    return localStorage.getItem("token") != null;
  }

  GuardarToken(data: string): void {
    localStorage.setItem('token', data);
  }

  ValidarToken(token: string) {
    return this.cliente.get(Environment.urlApi+"Validar/Token", {
      headers: {
        "Authorization": `bearer ${token}
    `}
    })
  }
  BorrarDatos(): void {
    localStorage.clear();
  }

  CerrarSesion() {
    return this.cliente.post<Peticion<UsuarioInfo>>(Environment.urlApi + "auth/logout", null, {
      headers: this.cabecera
    });
  }

  DarBajaToken(token: string) {
    return this.cliente.post<Peticion<UsuarioInfo>>(Environment.urlApi + "auth/logout", null, {
      headers: { "Authorization": `bearer ${token}` }
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

  RegistrarUsuario(data: any): Observable<Peticion<UsuarioInfo>> {
    return this.cliente.post<Peticion<UsuarioInfo>>(Environment.urlApi + "Registrar/Usuario", JSON.stringify(data),
      { headers: this.cabecera }).pipe(
        tap(() => {
          this.refresh.next();
        })
      );
  }

  EliminarUsuario(id: number): Observable<Peticion<UsuarioInfo>> {
    return this.cliente.put<Peticion<UsuarioInfo>>(Environment.urlApi + `Cambiar/Estatus/Usuario/${id}`, null,
      { headers: this.cabecera }).pipe(
        tap(() => {
          this.refresh.next();
        })
      );
  }

  ModificarUsuario(id: number, data: any): Observable<Peticion<UsuarioInfo>> {
    return this.cliente.put<Peticion<UsuarioInfo>>(Environment.urlApi + `Modificar/Usuario/${id}`, JSON.stringify(data),
      { headers: this.cabecera }).pipe(
        tap(() => {
          this.refresh.next();
        })
      );
  }

  ObtenerRoles(): Observable<PeticionConArreglo<Rol>> {
    return this.cliente.get<PeticionConArreglo<Rol>>(Environment.urlApi + 'Roles', {
      headers: this.cabecera
    });
  }

  ObtenerGeneros(): Observable<PeticionConArreglo<Genero>> {
    return this.cliente.get<PeticionConArreglo<Genero>>(Environment.urlApi + 'Generos', {
      headers: this.cabecera
    });
  }

  ObtenerCPEsp(cp: String): Observable<PeticionConArreglo<CP>> {
    return this.cliente.get<PeticionConArreglo<CP>>(Environment.urlApi + `CodigoPostal/${cp}`);
  }


  EnviarCorreoRecuperacion(correo: any): Observable<Peticion<any>> {
    return this.cliente.post<Peticion<any>>(Environment.urlApi + 'Recuperar/Cuenta', JSON.stringify(correo), { headers: this.cabecera });
  }

  RestablecerPassword(token: string, passwords: any): Observable<Peticion<any>> {
    return this.cliente.put<Peticion<any>>(Environment.urlApi + 'Crear/Contraseña', JSON.stringify(passwords), { headers: { "Authorization": `bearer ${token}` } });
  }
  CambiarPassword(credenciales: any): Observable<Peticion<any>> {
    return this.cliente.put<Peticion<any>>(Environment.urlApi + 'Cambiar/Contraseña', JSON.stringify(credenciales), { headers: this.cabecera });
  }


}
