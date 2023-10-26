import { Component } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
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

  constructor(private fb: FormBuilder,
    private usuarioService: UsuarioService) { }

  ngOnInit(): void {
    this.CrearFormulario();
  }

  IniciarSesion() {
    this.usuarioService.iniciarSesion({
      "email": this.frmLogin.controls["email"].value,
      "password": this.frmLogin.controls["password"].value
    }).subscribe(
      (x) => {
        this.usuarioService.GuardarToken(x.data);
        this.usuarioService.Me().subscribe((x => {
          this.usuarioService.GuardarUsuarioInfo(x.data);
          window.location.href = "/dashboard";
        }));
      }, (error) => {
        Swal.fire({
          title: 'Alerta',
          html: 'Error: ' + error.error.message,
          icon: 'error',
          customClass: {
            container: 'my-swal',
          },
        })
      }
    );
  }

  ObtenerErrorEmail() {
    if (this.frmLogin.controls["email"].hasError('required')) {
      return 'El correo es requerido';
    }

    return this.frmLogin.controls["email"].hasError('email') ? 'Ingrese un correo válido' : '';
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
