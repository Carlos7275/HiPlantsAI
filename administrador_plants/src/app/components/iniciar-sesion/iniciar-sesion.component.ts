import { Component } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TitleService } from 'src/app/services/title.service';
import { UsuarioService } from 'src/app/services/usuario.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-iniciar-sesion',
  templateUrl: './iniciar-sesion.component.html',
  styleUrls: ['./iniciar-sesion.component.scss']
})
export class IniciarSesionComponent {
  OcultaOjo = true;
  frmLogin: FormGroup;

  constructor(
    private fb: FormBuilder,
    private usuarioService: UsuarioService,
    private tituloService: TitleService,
    private matSnackBar: MatSnackBar
  ) { }

  ngOnInit(): void {
    this.tituloService.setTitle("Iniciar Sesión")
    this.CrearFormulario();
  }

  IniciarSesion() {
    this.usuarioService.iniciarSesion(
      {
      "email": this.frmLogin.controls["email"].value,
      "password": this.frmLogin.controls["password"].value
      }
    ).subscribe(
      (x) => {
        this.usuarioService.GuardarToken(x.data);
        
        this.usuarioService.Me().subscribe(y => {
          localStorage.setItem('info_usuario', JSON.stringify(y.data));
          window.location.reload();
        });
      }, (error) => {
        this.matSnackBar.open(error.error.message,"X",{duration:5000})
      }
    );
  }

  ObtenerErrorEmail() {
    if (this.frmLogin.controls["email"].hasError('required')) {
      return 'El correo es requerido';
    }

    return this.frmLogin.controls["email"].hasError('email') ?
      'Ingrese un correo válido' :
      null;
  }

  CrearFormulario() {
    this.frmLogin = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
    });
  }

  submit() {
    if (this.frmLogin.valid)
      this.IniciarSesion();
  }
}
