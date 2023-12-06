import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatIconModule } from '@angular/material/icon';
import { SidenavComponent } from './components/sidenav/sidenav.component';
import { UsuariosComponent } from './components/usuarios/usuarios.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { BodyComponent } from './components/body/body.component';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatTableModule } from '@angular/material/table';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatInputModule } from '@angular/material/input';
import { MatSortModule } from '@angular/material/sort';
import { IniciarSesionComponent } from './components/iniciar-sesion/iniciar-sesion.component';
import { LoaderInterceptor } from './interceptors/loader.interceptor';
import { LoaderComponent } from './components/loader/loader.component';
import { GenericCrudComponent } from './components/generic-crud/generic-crud.component';
import { MatPaginatorModule } from '@angular/material/paginator';
import { FooterComponent } from './components/footer/footer.component';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { DropdownComponent } from './components/dropdown/dropdown.component';
import { ModalRegistroUsuarioComponent } from './components/modal-registro-usuario/modal-registro-usuario.component';
import { MatDialogModule } from '@angular/material/dialog';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { InfoUsuarioComponent } from './components/info-usuario/info-usuario.component';
import { MenuConfigUsuarioComponent } from './components/menu-config-usuario/menu-config-usuario.component';
import { CambioPasswordComponent } from './components/cambio-password/cambio-password.component';
import { RecuperarCuentaComponent } from './components/recuperar-cuenta/recuperar-cuenta.component';
import { RecuperarPasswordComponent } from './components/recuperar-password/recuperar-password.component';
import { MapaComponent } from './components/mapa/mapa.component';
import { InfoPlantasComponent } from './components/info-plantas/info-plantas.component';
import { JwtHelperService, JwtModule, JWT_OPTIONS } from '@auth0/angular-jwt';
import { ConfiguracionesPanelComponent } from './components/configuraciones-panel/configuraciones-panel.component';
import { ModalRegistroplantasComponent } from './components/modal-registroplantas/modal-registroplantas.component';
import { EstadisticasComponent } from './components/estadisticas/estadisticas.component';
import { PreviewImagenComponent } from './components/preview-imagen/preview-imagen.component';
import { ComandosComponent } from './components/comandos/comandos.component';
import { ModalComandosComponent } from './components/modal-comandos/modal-comandos.component';
import { ComandosService } from './services/comandos.service';
import { UsuarioService } from './services/usuario.service';

@NgModule({
  declarations: [
    AppComponent,
    SidenavComponent,
    UsuariosComponent,
    DashboardComponent,
    BodyComponent,
    IniciarSesionComponent,
    LoaderComponent,
    GenericCrudComponent,
    FooterComponent,
    DropdownComponent,
    ModalRegistroUsuarioComponent,
    InfoUsuarioComponent,
    MenuConfigUsuarioComponent,
    CambioPasswordComponent,
    RecuperarCuentaComponent,
    RecuperarPasswordComponent,
    MapaComponent,
    InfoPlantasComponent,
    ConfiguracionesPanelComponent,
    ModalRegistroplantasComponent,
    EstadisticasComponent,
    PreviewImagenComponent,
    ComandosComponent,
    ModalComandosComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    BrowserModule,
    ReactiveFormsModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    FormsModule,
    MatFormFieldModule,
    MatInputModule,
    HttpClientModule,
    MatSortModule,
    MatTableModule,
    MatPaginatorModule,
    MatIconModule,
    MatDialogModule,
    MatSnackBarModule,
    MatSelectModule,
    MatButtonModule,
    JwtModule,
    MatSnackBarModule
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: LoaderInterceptor,
      multi: true,
    },
    { provide: JWT_OPTIONS, useValue: JWT_OPTIONS },
    JwtHelperService,
    ComandosService,
    UsuarioService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
