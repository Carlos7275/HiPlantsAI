import { Component, OnInit, signal } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CP } from 'src/app/models/CodigoP.model';
import { Genero } from 'src/app/models/Genero.model';
import { Rol } from 'src/app/models/Rol.model';
import { UsuarioInfo } from 'src/app/models/Usuario.model';
import { UsuarioService } from 'src/app/services/usuario.service';
import { Environment } from 'src/enviroments/enviroment.prod';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-info-usuario',
  templateUrl: './info-usuario.component.html',
  styleUrls: ['./info-usuario.component.scss']
})
export class InfoUsuarioComponent implements OnInit {

  frmDatosUsuario: FormGroup;
  DatosUsuario = signal<UsuarioInfo>(JSON.parse(localStorage.getItem("info_usuario")!));
  ArrayRoles = signal<Rol[]>([]);
  ArrayGeneros = signal<Genero[]>([]);
  ArrayAsentamientos = signal<CP[]>([]);
  reader = new FileReader();

  public imagePath: any;
  imgURL: any;
  public message: string;

  constructor(private fb: FormBuilder,
    private usuarioService: UsuarioService) { }

  ngOnInit(): void {
    this.CrearFormulario();
    this.ObtenerRoles();
    this.ObtenerGeneros();
    this.ObtenerColonias();
    this.SetDatos();

  }

  BuscarCP(event: any) {
    if (this.frmDatosUsuario.controls["CP"].value.length == 5) {
      this.frmDatosUsuario.controls["ID_Asentamiento"].setValue("");
      this.usuarioService.ObtenerCPEsp(event.target.value).subscribe(x => {
        this.ArrayAsentamientos.set(x.data);
      }
      );
    }
  }

  CrearFormulario() {
    this.imgURL = Environment.url + this.DatosUsuario().url_imagen;
    this.frmDatosUsuario = this.fb.group({
      Correo: ['', [Validators.required, Validators.email]],
      Nombres: ['', Validators.required],
      ApellidoPaterno: ['', Validators.required],
      ApellidoMaterno: ['', Validators.required],
      CP: ['', [Validators.minLength(5), Validators.maxLength(5), Validators.required, Validators.pattern('^[0-9]*$')]],
      Direccion: ['', Validators.required],
      Rol: ['', Validators.required],
      Genero: ['', Validators.required],
      Asentamiento: ['', Validators.required],
      FechaNacimiento: ['', Validators.required],
    });
  }
  ObtenerRoles() {
    this.usuarioService.ObtenerRoles().subscribe(x => {
      this.ArrayRoles.set(x.data);

    }, error => console.log(error))
  }
  ObtenerGeneros() {
    this.usuarioService.ObtenerGeneros().subscribe(x => {
      this.ArrayGeneros.set(x.data);

    }, error => console.log(error))
  }

  ObtenerColonias() {
    this.usuarioService.ObtenerCPEsp(this.DatosUsuario().cp).subscribe(x => {
      this.ArrayAsentamientos.set(x.data);
    }, error => console.log(error))
  }


  //Nos visualiza la imagen seleccionada en el input file
  preview(files: any) {
    if (files.length === 0) return;
    //Si el archivo tiene longitud verificaremos su MIME  y en caso de que no sea imagen termimos el proceso
    var mimeType = files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      this.message = 'Only images are supported.';
      return;
    }

    //Instanciamos el lector de archivos

    this.imagePath = files;
    this.reader.readAsDataURL(files[0]);
    this.reader.onload = (_event) => {
      this.imgURL = this.reader.result;
    };
  }

  SetDatos() {
    this.frmDatosUsuario.controls["Correo"].setValue(this.DatosUsuario().email);
    this.frmDatosUsuario.controls["Nombres"].setValue(this.DatosUsuario().nombres);
    this.frmDatosUsuario.controls["ApellidoPaterno"].setValue(this.DatosUsuario().apellido_paterno);
    this.frmDatosUsuario.controls["ApellidoMaterno"].setValue(this.DatosUsuario().apellido_materno)
    this.frmDatosUsuario.controls["CP"].setValue(this.DatosUsuario().cp);
    this.frmDatosUsuario.controls["Direccion"].setValue(this.DatosUsuario().domicilio, Validators.required);
    this.frmDatosUsuario.controls["Rol"].setValue(this.DatosUsuario().id_rol);
    this.frmDatosUsuario.controls["Genero"].setValue(this.DatosUsuario().id_genero);
    this.frmDatosUsuario.controls["Asentamiento"].setValue(this.DatosUsuario().id_asenta_cpcons);
    this.frmDatosUsuario.controls["FechaNacimiento"].setValue(this.DatosUsuario().fecha_nacimiento);
  }

  Submit() {
    if (this.frmDatosUsuario.valid)
      this.EditarUsuario();
  }

  LimpiarCampos() {
    this.frmDatosUsuario.reset();
  }

  EditarUsuario() {

    this.usuarioService.ModificarUsuario(this.DatosUsuario().id, {
      nombres: this.frmDatosUsuario.controls["Nombres"].value,
      email: this.frmDatosUsuario.controls["Correo"].value,
      apellido_materno: this.frmDatosUsuario.controls["ApellidoMaterno"].value,
      apellido_paterno: this.frmDatosUsuario.controls["ApellidoPaterno"].value,
      domicilio: this.frmDatosUsuario.controls["Direccion"].value,
      fecha_nacimiento: this.frmDatosUsuario.controls["FechaNacimiento"].value,
      id_rol: this.frmDatosUsuario.controls["Rol"].value,
      id_genero: this.frmDatosUsuario.controls["Genero"].value,
      id_asenta: this.frmDatosUsuario.controls["Asentamiento"].value,
      cp: this.frmDatosUsuario.controls["CP"].value,
      imagen: this.reader.result,
      estatus: this.DatosUsuario().estatus
    }).subscribe((x) => {
      this.usuarioService.Me().subscribe(y => {
        localStorage.setItem('info_usuario', JSON.stringify(y.data));
        Swal.fire("¡Operacion Exitosa!", x.data.toString(), "success");

      }, error => {
        Swal.fire({
          title: 'Alerta',
          html: 'Error: ' + error.error.message,
          icon: 'error',
          customClass: {
            container: 'my-swal',
          },
        })
      });
    });
  }


}

