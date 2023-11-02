import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { UsuarioService } from '../services/usuario.service';

@Injectable({
    providedIn: 'root'
})
export class IsNotLoginGuard {
    constructor(private userService: UsuarioService, private router: Router) { }
    canActivate(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
        if (this.userService.inicioSesion()) {
            this.router.navigateByUrl("/dashboard");
            return false;
        }

        return true;
    }

}