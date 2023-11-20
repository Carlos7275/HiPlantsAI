import { Component, OnDestroy, OnInit, signal } from '@angular/core';
import { Subscription } from 'rxjs';
import { UsuarioInfo } from 'src/app/models/Usuario.model';
import { ErrorHandlerService } from 'src/app/services/errorHandling.service';
import { UsuarioService } from 'src/app/services/usuario.service';
import { Environment } from 'src/enviroments/enviroment.prod';

@Component({
  selector: 'app-dropdown',
  templateUrl: './dropdown.component.html',
  styleUrls: ['./dropdown.component.scss']
})

export class DropdownComponent implements OnInit, OnDestroy {
  datosUsuario = signal<UsuarioInfo>(this.ObtenerDatos() ?? null);
  flag: boolean;
  subscription: Subscription;
  url = Environment.url;
  constructor(
    private userService: UsuarioService,
    private errorService: ErrorHandlerService
  ) { }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }

  ngOnInit(): void {
    this.actualizarDatos();
  }
  ObtenerDatos() {
    this.userService.Me().subscribe(x => {
      localStorage.setItem("info_usuario", JSON.stringify(x.data));
      this.flag = true;
    }, error => this.errorService.handleError(error))

    return JSON.parse(localStorage.getItem("info_usuario")!);
  }
  actualizarDatos() {
    this.subscription = this.userService.refresh.subscribe(() => {
      this.userService.Me().subscribe(x => {

        localStorage.setItem("info_usuario", JSON.stringify(x.data));
        this.flag = true;
      }, error => this.errorService.handleError(error))
    })
  }
  toggleDropdown() {

    let menu = document.getElementById("menu");
    let clase = document.getElementById("chevron");
    menu?.classList.toggle("open");

    clase!.innerHTML = !menu?.classList.contains("open")
      ? "expand_more"
      : "close";

  };
  disableDropdown() {
    let menu = document.getElementById("menu");
    let clase = document.getElementById("chevron");
    menu?.classList.remove("open");

    clase!.innerHTML = !menu?.classList.contains("open")
      ? "expand_more"
      : "close";
  }


  handleMenuButtonClicked() {
    this.toggleDropdown();

  };

  logout() {
    this.userService.CerrarSesion().subscribe(x => {
      this.userService.BorrarDatos();
      window.location.reload();

    })
  }
}
