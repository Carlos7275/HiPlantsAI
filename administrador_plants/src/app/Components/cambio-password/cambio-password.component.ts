import { Component, signal } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/services/usuario.service';
import { ConfirmedValidator } from 'src/app/validators/CustomValidator';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-cambio-password',
  templateUrl: './cambio-password.component.html',
  styleUrls: ['./cambio-password.component.scss']
})
export class CambioPasswordComponent {


  constructor(private fb: FormBuilder, private usuarioService: UsuarioService) { }


  getErrorMessagePassword() {
    return 'Ingrese su Contraseña!';
  }
  frmContrasena: FormGroup;
  hide = true;
  hide2 = true;
  hide3 = true;

  ngOnInit(): void {

    this.CreateForm();
  }

  CreateForm() {
    this.frmContrasena = this.fb.group({

      PasswordAnterior: ['', [Validators.required]],
      NewPassword: ['', [Validators.minLength(8), Validators.required]],
      AuxPassword: ['', [Validators.minLength(8), Validators.required]],
    }, {
      validators: ConfirmedValidator("NewPassword", "AuxPassword")
    });
  }

  submit() {
    if (this.frmContrasena.valid)
      this.CambiarPassword();
  }

  CambiarPassword() {

    this.usuarioService.CambiarPassword({
      PasswordActual: this.frmContrasena.controls['PasswordAnterior'].value,
      PasswordNueva: this.frmContrasena.controls['NewPassword'].value,
      PasswordAuxiliar: this.frmContrasena.controls['AuxPassword'].value
    })

      .subscribe(
        (x) => {

          Swal.fire('Enhorabuena', x.data.toString(), 'success').then(
            function () {
              window.location.reload();
            }
          );
        },
        (error) => Swal.fire(error.error.message, error.error.data.toString(), 'error')
      );


  }
  public getPasswordConfirmationErrorMessage() {

    if (this.frmContrasena.get('AuxPassword')?.hasError('required')) {
      return 'Ingresa la contrasena';
    } else if (this.frmContrasena.get('validators')?.errors) {
      return 'Las contrasenas no coinciden';
    }
    return ""
  }
  Limpiar() {
    this.frmContrasena.reset();

  }
}
