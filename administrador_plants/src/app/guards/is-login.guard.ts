import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { UsuarioService } from '../services/usuario.service';

@Injectable({
    providedIn: 'root'
})
export class IsLoginGuard {
    constructor(private usuarioService: UsuarioService, private router: Router) {

    }
    canActivate(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
        if (!this.usuarioService.inicioSesion()) {
            this.router.navigateByUrl("/login");
            return false;
        }

        return true;
    }

}