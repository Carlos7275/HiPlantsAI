import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/services/usuario.service';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-recuperar-password',
  templateUrl: './recuperar-password.component.html',
  styleUrls: ['./recuperar-password.component.scss']
})
export class RecuperarPasswordComponent {

  constructor(private fb:FormBuilder,private usuarioService:UsuarioService){}
  OcultaOjo = true;
  OcultaOjo2=true;
  frmRecuperarPassword: FormGroup;
  ngOnInit(): void {
    this.CrearFormulario();
  }

CrearFormulario(){
  this.frmRecuperarPassword = this.fb.group({
    PasswordAuxiliar: ['', [Validators.required,Validators.minLength(8)]],
    PasswordNueva: ['', [Validators.required,Validators.minLength(8)]],

  });
}

obtenerErrorPassword() {
  if (this.frmRecuperarPassword.controls["password"].hasError('required')) {
    return 'El campo es requerido';
  }else{
    return 'La contraseña debe ser de mínimo 8 caractéres'
  }
}
obtenerErrorPassword2() {
  if (this.frmRecuperarPassword.controls["password2"].hasError('required')) {
    return 'El campo es requerido';
  }else{
    return 'La contraseña debe ser de mínimo 8 caractéres'
  }
}

submit(){
  if(this.frmRecuperarPassword.valid)
  this.RecuperarPassword();
}

RecuperarPassword(){
  this.usuarioService.RestablecerPassword({
    PasswordNueva:this.frmRecuperarPassword.controls["PasswordNueva"].value,
    PasswordAuxiliar:this.frmRecuperarPassword.controls["PasswordAuxiliar"].value
  }).subscribe((x)=>
  {
    Swal.fire({
      title: 'Operación Exitosa',
      html: x.data,
      icon: 'success',
      customClass: {
        container: 'my-swal',
      },
    });
    //redirigimos al login no se me olvideko
    //window.location.reload();
  },(error) => {
    Swal.fire({
      title: 'Alerta',
      html: 'Error: ' + error.error.message,
      icon: 'error',
      customClass: {
        container: 'my-swal',
      },
    })
  }

  )
}


}
