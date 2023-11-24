import { Injectable } from '@angular/core';
import { Service } from './service';
import { Observable, tap } from 'rxjs';
import { Peticion, PeticionConArreglo } from '../models/Peticion.model';
import { InfoPlantas, InformacionPlanta, Mapa } from '../models/Mapa.model';
import { Environment } from 'src/enviroments/enviroment.prod';

@Injectable({
  providedIn: 'root'
})
export class MapaService extends Service {

  ObtenerPlantas(): Observable<PeticionConArreglo<Mapa>> {
    return this.cliente.get<PeticionConArreglo<Mapa>>(Environment.urlApi + "Mapa/Plantas", { headers: this.cabecera });
  }

  ObtenerInfoPlantas(): Observable<PeticionConArreglo<InformacionPlanta>> {
    return this.cliente.get<PeticionConArreglo<InformacionPlanta>>(Environment.urlApi + "Plantas");
  }
  ObtenerEstatus(Estatus: number) {
    const estatusTextos = [
      "Inactivo",
      "Activo"
    ]

    return estatusTextos[Estatus] || "Estatus Desconocido";
  }

  CambiarEstatusPlanta(id: number) {
    return this.cliente.put<Peticion<Mapa>>(Environment.urlApi + `Cambiar/Estatus/Planta/${id}`, null, { headers: this.cabecera }).pipe(
      tap(() => {
        this.refresh.next();
      }));
  }

  RegistrarPlanta(data: any): Observable<Peticion<InfoPlantas>> {
    return this.cliente.post<Peticion<InfoPlantas>>(Environment.urlApi + "Registrar/Planta", JSON.stringify(data), { headers: this.cabecera }).pipe(
      tap(() => {
        this.refresh.next();
      }));;
  }

  ObtenerEstadisticas(): Observable<Peticion<any>> {
    return this.cliente.get<Peticion<any>>(Environment.urlApi + "Conteos", { headers: this.cabecera });
  }

}
