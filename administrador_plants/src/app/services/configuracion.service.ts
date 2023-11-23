import { Injectable } from "@angular/core";
import { Service } from "./service";
import { Observable } from "rxjs";
import { Environment } from "src/enviroments/enviroment";
import { Peticion } from "../models/Peticion.model";



@Injectable({
  providedIn: 'root'
})

export class ConfiguracionService extends Service{

  ActualizarConfiguracion(data:any):Observable<Peticion<any>>{
    return this.cliente.put<Peticion<any>>(Environment.urlApi+'Actualizar/Configuracion',JSON.stringify(data),{headers:this.cabecera});
  }
}
