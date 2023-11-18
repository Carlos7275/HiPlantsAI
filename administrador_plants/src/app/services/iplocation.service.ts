import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class IpLocationService {
  private apiUrl = 'http://ipinfo.io/json?token=0705716a359e02';

  constructor(private http: HttpClient) {}

  getCoordinatesByIp(): Observable<any> {
    return this.http.get(this.apiUrl);
  }
}
