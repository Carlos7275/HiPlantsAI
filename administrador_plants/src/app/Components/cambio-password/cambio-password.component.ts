import { Component, signal } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/services/usuario.service';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-cambio-password',
  templateUrl: './cambio-password.component.html',
  styleUrls: ['./cambio-password.component.scss']
})
export class CambioPasswordComponent {
constructor(private fb: FormBuilder, private usuarioService: UsuarioService){}
OcultaOjo = true;
OcultaOjo2=true;
OcultaOjo3=true;
frmCambioPwd: FormGroup;
ngOnInit(): void {
  this.crearFormulario();
}
crearFormulario(){
  this.frmCambioPwd = this.fb.group({
    password2: ['', [Validators.required,Validators.minLength(8)]],
    password: ['', [Validators.required,Validators.minLength(8)]],
    passwordActual:['',[Validators.required]]
  });
}
submit(){
  if(this.frmCambioPwd.valid && this.frmCambioPwd.controls["password"].value===this.frmCambioPwd.controls["password2"].value)
  this.CambiarPwd();
}
CambiarPwd(){
  this.usuarioService.CambiarPassword({
    PasswordNueva:this.frmCambioPwd.controls["password"].value,
    PasswordAuxiliar:this.frmCambioPwd.controls["password2"].value,
    PasswordActual:this.frmCambioPwd.controls["passwordActual"].value
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
  },(error) => {
    Swal.fire({
      title: 'Alerta',
      html: 'Error: ' + error.error.message,
      icon: 'error',
      customClass: {
        container: 'my-swal',
      },
    })
  })
}
obtenerErrorPassword() {
  if (this.frmCambioPwd.controls["password"].hasError('required')) {
    return 'El campo es requerido';
  }else{
    return 'La contraseña debe ser de mínimo 8 caractéres'
  }
}
obtenerErrorPassword2() {
  if (this.frmCambioPwd.controls["password2"].hasError('required')) {
    return 'El campo es requerido';
  }else{
    return 'La contraseña debe ser de mínimo 8 caractéres'
  }
}
}
