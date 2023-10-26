import { Component, Injectable, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UsuarioService } from '../services/usuario.service';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

@Injectable()
export class LoginComponent implements OnInit{

  ngOnInit(): void {
    this.CrearFormulario();
  }
  OcultaOjo = true;
  frmLogin: FormGroup;

  IniciarSesion() {
      this.usuarioService
        .iniciarSesion(
          {
            "email":this.frmLogin.controls["email"].value,
            "password":this.frmLogin.controls["password"].value
          }
        )
        .subscribe(
          (x) => {
            this.usuarioService.GuardarToken(x.data);

            this.usuarioService.Me().subscribe((x=>
              {
                this.usuarioService.GuardarUsuarioInfo(x.data);
                  window.location.reload();
              }
              ));
          },
          (error) => {
            Swal.fire({
              title: 'Alerta',
              html: 'Error: ' +error.error.message,
              icon: 'error',
              customClass: {
                container: 'my-swal',
              },
            })
          }
        );
  }

  constructor(private fb: FormBuilder,
    protected usuarioService: UsuarioService) { }

    ObtenerErrorEmail() {
      if (this.frmLogin.controls["email"].hasError('required')) {
        return 'El correo es requerido';
      }

      return this.frmLogin.controls["email"].hasError('email') ? 'Ingrese un correo válido' : '';
    }

  CrearFormulario() {
    //Inicializamos frmlogin con validators
    this.frmLogin = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
    });
  }


  submit() {
    if (this.frmLogin.valid){
      this.IniciarSesion();

    }else{
      Swal.fire({
        title: 'Atención',
        html: 'Ingrese un correo y contraseña válidos e inténtelo de nuevo',
        icon: 'info',
        customClass: {
          container: 'my-swal',
        },
      })
    }

  }
}
