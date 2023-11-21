import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { CP } from 'src/app/models/CodigoP.model';
import { Genero } from 'src/app/models/Genero.model';
import { Rol } from 'src/app/models/Rol.model';
import { UsuarioInfo } from 'src/app/models/Usuario.model';
import { UsuarioService } from 'src/app/services/usuario.service';
import { ConfirmedValidator } from 'src/app/validators/CustomValidator';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-modal-registro-usuario',
  templateUrl: './modal-registro-usuario.component.html',
  styleUrls: ['./modal-registro-usuario.component.scss']
})
export class ModalRegistroUsuarioComponent implements OnInit {
  frmDatos: FormGroup;
  title: any;
  flag: boolean = false;
  reader = new FileReader();
  public message: string;
  data: UsuarioInfo;
  roles: Rol[];
  generos: Genero[];
  asentamientos: CP[];
  hide: boolean = true;
  hide2: boolean = true;

  constructor(
    private fb: FormBuilder,
    private usuarioService: UsuarioService,
    public dialogRef: MatDialogRef<ModalRegistroUsuarioComponent>,
    @Inject(MAT_DIALOG_DATA) public dataModal: any
  ) { }

  ngOnInit(): void {
    if (this.dataModal == 'Registrar') {
      this.title = "Registrar Usuario"
      this.registrar();

    } else {
      this.title = "Modificar Usuario"
      this.modificar(this.dataModal);
    }

    this.mostrarRoles();
    this.mostrarGeneros();
  }


  LimpiarCampos() {
    this.frmDatos.reset();
  }


  submit() {
    if (this.frmDatos.valid) {
      this.Operacion();
    }
  }

  registrar() {
    this.flag = true;
    this.registrarForm();
  }

  modificar(data: any) {
    this.modificarForm();
    this.flag = false;
    this.data = data;
    this.frmDatos.controls["Nombres"].setValue(data.nombres),
      this.frmDatos.controls["Email"].setValue(data.email),
      this.frmDatos.controls["ApellidoPaterno"].setValue(data.apellido_paterno),
      this.frmDatos.controls["ApellidoMaterno"].setValue(data.apellido_materno),
      this.frmDatos.controls["Domicilio"].setValue(data.domicilio),
      this.frmDatos.controls["Roles"].setValue(data.id_rol, { onlySelf: true }),
      this.frmDatos.controls["Generos"].setValue(data.id_genero, { onlySelf: true }),
      this.frmDatos.controls["CP"].setValue(data.cp);
    this.frmDatos.controls["Asentamiento"].setValue(data.id_asenta_cpcons, { onlySelf: true }),
      this.frmDatos.controls["FechaNacimiento"].setValue(data.fecha_nacimiento),
      this.mostrarAsentamientos(this.frmDatos.controls["CP"].value);
  }

  registrarForm() {
    this.frmDatos = this.fb.group({
      Email: ['', Validators.required],
      Password: ['', Validators.required],
      Password2: ['', Validators.required],
      Nombres: ['', Validators.required],
      ApellidoPaterno: ['', Validators.required],
      ApellidoMaterno: ['', Validators.maxLength(20)],
      Domicilio: ['', Validators.required],
      FechaNacimiento: ['', Validators.required],
      Roles: ['', Validators.required],
      Generos: ['', Validators.required],
      Asentamiento: ['', Validators.required],
      CP: ['', Validators.required]
    }, {
      validators: ConfirmedValidator("Password", "Password2")
    })
  }

  public getPasswordConfirmationErrorMessage() {

    if (this.frmDatos.get('Password')?.hasError('required')) {
      return 'Ingresa la contrasena';
    } else if (this.frmDatos.get('validators')?.errors) {
      return 'Las contrasenas no coinciden';
    }
    return ""
  }

  modificarForm() {
    this.frmDatos = this.fb.group({
      Email: ['', Validators.required],
      Nombres: ['', Validators.required],
      ApellidoPaterno: ['', Validators.required],
      ApellidoMaterno: ['', Validators.maxLength(20)],
      Domicilio: ['', Validators.required],
      FechaNacimiento: ['', Validators.required],
      Roles: ['', Validators.required],
      Generos: ['', Validators.required],
      Asentamiento: ['', Validators.required],
      CP: ['', Validators.required],
    })
  }

  Operacion() {
    if (this.title === 'Registrar Usuario') {
      this.usuarioService.RegistrarUsuario({
        email: this.frmDatos.controls["Email"].value,
        password: this.frmDatos.controls["Password"].value,
        nombres: this.frmDatos.controls["Nombres"].value,
        apellido_paterno: this.frmDatos.controls["ApellidoPaterno"].value,
        apellido_materno: this.frmDatos.controls["ApellidoMaterno"].value,
        domicilio: this.frmDatos.controls["Domicilio"].value,
        fecha_nacimiento: this.frmDatos.controls["FechaNacimiento"].value,
        id_rol: this.frmDatos.controls["Roles"].value,
        id_genero: this.frmDatos.controls["Generos"].value,
        id_asenta: this.frmDatos.controls["Asentamiento"].value,
        cp: this.frmDatos.controls["CP"].value,
      }).subscribe((s) => {
        Swal.fire(s.message, s.data.toString(), 'success').then(() => {
          this.dialogRef.close();
        });
      }, error => console.log(error));

    } else {
      this.usuarioService.ModificarUsuario(this.data.id, {
        email: this.frmDatos.controls["Email"].value,
        nombres: this.frmDatos.controls["Nombres"].value,
        apellido_paterno: this.frmDatos.controls["ApellidoPaterno"].value,
        apellido_materno: this.frmDatos.controls["ApellidoMaterno"].value,
        domicilio: this.frmDatos.controls["Domicilio"].value,
        fecha_nacimiento: this.frmDatos.controls["FechaNacimiento"].value,
        id_rol: this.frmDatos.controls["Roles"].value,
        id_genero: this.frmDatos.controls["Generos"].value,
        id_asenta: this.frmDatos.controls["Asentamiento"].value,
        cp: this.frmDatos.controls["CP"].value,
      }).subscribe((s) => {
        Swal.fire(s.message, s.data.toString(), "success").then(() => {
          this.dialogRef.close();
        });
      }, error => console.log(error));
    }
  }

  mostrarRoles() {
    this.usuarioService.ObtenerRoles().subscribe(s => {

      this.roles = s.data;
    }, error => console.log(error));
  }

  mostrarGeneros() {
    this.usuarioService.ObtenerGeneros().subscribe(s => {

      this.generos = s.data;
    }, error => console.log(error));
  }

  buscarCP(event: any) {
    if (event.target.value.length == 5) {
      this.frmDatos.controls["Asentamiento"].setValue("");
      this.mostrarAsentamientos(event.target.value);
    }
  }

  mostrarAsentamientos(cp: String) {
    this.usuarioService.ObtenerCPEsp(cp).subscribe(s => {
      this.asentamientos = s.data;
    }, error => console.log(error));
  }

}
