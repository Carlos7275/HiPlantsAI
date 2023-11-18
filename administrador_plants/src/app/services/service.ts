import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class Service {

    cabecera = new HttpHeaders().set("Authorization", `bearer ${localStorage.getItem("token")!}`);
    private _$refresh = new Subject<void>();

    get refresh() {
        return this._$refresh;
    }

    constructor(protected cliente: HttpClient) { }
}
