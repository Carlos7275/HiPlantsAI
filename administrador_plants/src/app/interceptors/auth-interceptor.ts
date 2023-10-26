import { Injectable } from '@angular/core';
import {
  HttpInterceptor,
  HttpRequest,
  HttpHandler,
  HttpEvent,
} from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, switchMap } from 'rxjs/operators';
import { UserServiceHost } from '../services/userHost.service';

@Injectable()
export class TokenInterceptor implements HttpInterceptor {
  constructor(private userService: UserServiceHost) { }

  intercept(
    request: HttpRequest<any>,
    next: HttpHandler
  ): Observable<HttpEvent<any>> {
    // Realiza la lógica para adjuntar el token de acceso actual a la solicitud.
    // Asegúrate de manejar correctamente el token de acceso en tus solicitudes.

    return next.handle(request).pipe(
      catchError((error) => {
        // Si la solicitud devuelve un error debido a un token de acceso inválido o expirado, intenta renovar el token.
        if (error.status === 401 && this.userService.isLogin()) {
          return this.userService.refreshToken().pipe(
            switchMap((newAccessToken) => {
              // Vuelve a intentar la solicitud original con el nuevo token de acceso.
              // Asegúrate de actualizar el token de acceso en tus solicitudes.
              const modifiedRequest = request.clone({
                setHeaders: {
                  Authorization: `Bearer ${newAccessToken}`,
                },
              });
              return next.handle(modifiedRequest);
            }),
            catchError((refreshError) => {
              // Maneja el error de renovación de token, por ejemplo, redirigiendo a la página de inicio de sesión.
              return throwError(refreshError);
            })
          );
        }
        return throwError(error);
      })
    );
  }
}