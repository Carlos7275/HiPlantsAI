import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { UsuariosComponent } from './components/usuarios/usuarios.component';
import { IniciarSesionComponent } from './components/iniciar-sesion/iniciar-sesion.component';
import { IsLoginGuard } from './guards/is-login.guard';
import { ErrorComponent } from './components/error/error.component';
import { Error500Component } from './components/error500/error500.component';
import { IsNotLoginGuard } from './guards/is-not-login.guard';
import { ModalRegistroUsuarioComponent } from './components/modal-registro-usuario/modal-registro-usuario.component';

const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: "login", component: IniciarSesionComponent,canActivate:[IsNotLoginGuard]},
  {
    path: 'inicio', component: DashboardComponent, children: [
      { path: 'usuarios', component: UsuariosComponent }
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
