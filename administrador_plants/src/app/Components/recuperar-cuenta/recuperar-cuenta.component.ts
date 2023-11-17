import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/services/usuario.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-recuperar-cuenta',
  templateUrl: './recuperar-cuenta.component.html',
  styleUrls: ['./recuperar-cuenta.component.scss']
})
export class RecuperarCuentaComponent {
  frmRecuperar: FormGroup;
  ngOnInit(): void {

    this.CrearFormulario();
  }
  constructor(private fb: FormBuilder,
    private usuarioService: UsuarioService) { }


  CrearFormulario() {
    this.frmRecuperar = this.fb.group({
      Correo: ['', [Validators.required, Validators.email]]
    });
  }


  submit() {
    if (this.frmRecuperar.valid)
      this.EnviarCorreoRecuperacion();
  }

  EnviarCorreoRecuperacion() {
    this.usuarioService.EnviarCorreoRecuperacion({
      email: this.frmRecuperar.controls["Correo"].value
    }).subscribe((x) => {
      Swal.fire({
        title: 'Operación Exitosa',
        html: x.data,
        icon: 'success',
      });
    }, (error) => {
      Swal.fire({
        title: 'Alerta',
        html: 'Error: ' + error.error.message,
        icon: 'error',
      })
    })
  }

}
