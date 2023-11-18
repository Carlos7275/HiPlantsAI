import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/services/usuario.service';
import Swal from 'sweetalert2';
import { ConfirmedValidator } from '../validators/CustomValidator';
import { TitleService } from 'src/app/services/title.service';
import { ActivatedRoute, Router } from '@angular/router';
import { JwtHelperService } from '@auth0/angular-jwt';

@Component({
  selector: 'app-recuperar-password',
  templateUrl: './recuperar-password.component.html',
  styleUrls: ['./recuperar-password.component.scss']
})
export class RecuperarPasswordComponent {

  frmRecover: FormGroup;
  hide = true;
  hide2 = true;
  valid: boolean;
  token: string;

  constructor(
    private titleService: TitleService,
    private fb: FormBuilder,
    private router: Router,
    private route: ActivatedRoute,
    private userService: UsuarioService,
    private jwtHelper: JwtHelperService
  ) {

    this.titleService.setTitle("Recuperar Cuenta");
    this.setToken();
    this.VerifiedToken();
    this.createForm();

  }
  VerifiedToken() {
    this.userService.ValidarToken(this.token).subscribe(x => {

      if (this.jwtHelper.isTokenExpired(this.token))
        this.router.navigate(["/"]);
    }, error => this.router.navigate(["/"]));

  }
  setToken() {
    this.route.paramMap.subscribe((param) => (this.token = param.get('token')!));
  }
  createForm() {
    this.frmRecover = this.fb.group({
      Password: ['', [Validators.minLength(8), Validators.required]],
      Password2: ['', [Validators.minLength(8), Validators.required]],
    }, {
      validators: ConfirmedValidator("Password", "Password2")
    }
    )
  }
  public getPasswordConfirmationErrorMessage() {

    if (this.frmRecover.get('Password2')?.hasError('required')) {
      return 'Ingresa la contrasena';
    } else if (this.frmRecover.get('validators')?.errors) {
      return 'Las contrasenas no coinciden';
    }
    return ""
  }
  submit() {
    if (this.frmRecover.valid)
      this.CambiarContraseña();
  }
  CambiarContraseña() {
    this.userService.RestablecerPassword(this.token, {
      PasswordNueva: this.frmRecover.controls["Password"].value,
      PasswordAuxiliar: this.frmRecover.controls["Password2"].value
    }).subscribe(x => {
      this.userService.DarBajaToken(this.token).subscribe(() => { });
      Swal.fire(x.message, x.data, "success").then(function () {

        window.location.href = "/login";
      })
    }, error => Swal.fire(error.error.message, error.error.data, "error"))
  }


}
