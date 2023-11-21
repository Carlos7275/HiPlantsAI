import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Service } from './service';
import { Environment } from 'src/enviroments/enviroment';

@Injectable({
  providedIn: 'root'
})
export class IpLocationService extends Service {

  getCoordinatesByIp(): Observable<any> {
    return this.cliente.get(`${Environment.urlApi}Coordenadas`);
  }
}
