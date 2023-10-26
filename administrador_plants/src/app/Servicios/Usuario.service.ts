import { environment } from "src/enviroments/enviroment.prod";
import { TUsuarioInfo } from "../Modelos/Usuario.model";
import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Observable, tap } from 'rxjs';
import { Injectable } from "@angular/core";

@Injectable( {
    providedIn: 'root',
  })
  
export class UsuarioService{

    cabecera= new HttpHeaders().set("Authorization", `Bearer ${localStorage.getItem("token")!}`);
    constructor(private cliente: HttpClient) {}
   
    ObtenerUsuarios():Observable<TUsuarioInfo>{
        return this.cliente.get<TUsuarioInfo>(environment.urlApi + 'Usuarios',{
            headers: this.cabecera
        });
    }


}

