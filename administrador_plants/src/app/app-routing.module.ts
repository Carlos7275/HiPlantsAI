import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { UsuariosComponent } from './components/usuarios/usuarios.component';
import { IniciarSesionComponent } from './components/iniciar-sesion/iniciar-sesion.component';
import { IsLoginGuard } from './guards/is-login.guard';
import { ErrorComponent } from './components/error/error.component';
import { Error500Component } from './components/error500/error500.component';
import { IsNotLoginGuard } from './guards/is-not-login.guard';
import { MenuConfigUsuarioComponent } from './components/menu-config-usuario/menu-config-usuario.component';
import { InfoUsuarioComponent } from './components/info-usuario/info-usuario.component';
import { CambioPasswordComponent } from './components/cambio-password/cambio-password.component';
import { RecuperarCuentaComponent } from './components/recuperar-cuenta/recuperar-cuenta.component';
import { MapaComponent } from './components/mapa/mapa.component';
import { InfoPlantasComponent } from './components/info-plantas/info-plantas.component';
import { RecuperarPasswordComponent } from './components/recuperar-password/recuperar-password.component';
import { ConfiguracionesPanelComponent } from './components/configuraciones-panel/configuraciones-panel.component';

const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: "login", component: IniciarSesionComponent, canActivate: [IsNotLoginGuard] },
  { path: "recuperarcuenta", component: RecuperarCuentaComponent, canActivate: [IsNotLoginGuard] },
  { path: "cambiarcontraseña/:token", component: RecuperarPasswordComponent },
  {
    path: 'inicio', component: DashboardComponent, children: [
      {
        path: '', redirectTo: "mapa", pathMatch: "full"
      },
      { path: 'usuarios', component: UsuariosComponent },
      { path: "mapa", component: MapaComponent },
      { path: "plantas", component: InfoPlantasComponent },
      { path: "configuracionsistema", component: ConfiguracionesPanelComponent },
      {
        path: 'configuracion', component: MenuConfigUsuarioComponent,
        children: [
          { path: 'infousuario', component: InfoUsuarioComponent },
          { path: "cambiarcontraseña", component: CambioPasswordComponent },
          {
            path: '', redirectTo: "infousuario", pathMatch: "full"
          },
        ],
      }
    ], canActivate: [IsLoginGuard]

  },

  {
    path: "error404", component: ErrorComponent
  },
  {
    path: "error500", component: Error500Component
  },
  {
    path: '**',
    redirectTo: 'error404',
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
