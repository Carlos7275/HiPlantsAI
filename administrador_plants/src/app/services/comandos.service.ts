import { Injectable } from "@angular/core";
import { Service } from "./service";
import { Observable, tap } from "rxjs";
import { Environment } from "src/enviroments/enviroment";
import { Peticion, PeticionConArreglo } from "../models/Peticion.model";
import { Comandos } from "../models/Comandos.model";

@Injectable({
    providedIn: 'root'
})

export class ComandosService extends Service {
    AgregarComando( data: any): Observable<Peticion<any>> {
        return this.cliente.post<Peticion<any>>(Environment.urlApi + `Crear/Comando`, JSON.stringify(data), { headers: this.cabecera }).pipe(
            tap(() => {
                this.refresh.next();
            }));
    }

    EditarComando(id: number, data: any): Observable<Peticion<any>> {
        return this.cliente.put<Peticion<any>>(Environment.urlApi + `Editar/Comando/${id}`, JSON.stringify(data), { headers: this.cabecera }).pipe(
            tap(() => {
                this.refresh.next();
            }));
    }

    ObtenerComandos(): Observable<PeticionConArreglo<Comandos>> {
        return this.cliente.get<PeticionConArreglo<Comandos>>(Environment.urlApi + `Comandos`, { headers: this.cabecera });
    }
    EliminarComando(id: number): Observable<Peticion<any>> {
        return this.cliente.delete<Peticion<any>>(Environment.urlApi + `Eliminar/Comando/${id}`, { headers: this.cabecera }).pipe(
            tap(() => {
                this.refresh.next();
            }));
    }

}