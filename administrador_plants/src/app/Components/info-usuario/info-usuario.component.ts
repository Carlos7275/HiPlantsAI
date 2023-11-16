import { Component, OnInit, signal } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CP } from 'src/app/models/CodigoP.model';
import { Genero} from 'src/app/models/Genero.model';
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
export class InfoUsuarioComponent implements OnInit{

  frmUsuario: FormGroup;
  InfoUsuarioLocalStorage:UsuarioInfo;
  ArrayRoles=signal<Rol[]>([]);
  ArrayGeneros=signal<Genero[]>([]);
  ArrayAsentamientos=signal<CP[]>([]);
  reader = new FileReader();
  ArrayEstatus: any[] = [
    {value: 'ACTIVO', viewValue: 'ACTIVO'},
    {value: 'INACTIVO', viewValue: 'INACTIVO'},
  ];



  public imagePath: any;
  imgURL: any;
  public message: string;

  constructor(private fb: FormBuilder,
    private usuarioService: UsuarioService) { }

  ngOnInit(): void {
    this.InfoUsuarioLocalStorage= JSON.parse(localStorage.getItem('info_usuario')!);
    this.CrearFormulario();
    this.ObtenerRoles();
    this.ObtenerGeneros();
    this.ObtenerColonias();
    this.SetDatos();

  }
  CrearFormulario() {
    this.imgURL=Environment.url+this.InfoUsuarioLocalStorage.url_imagen;
    this.frmUsuario = this.fb.group({
      Email: ['', [Validators.required, Validators.email]],
      Nombre: ['', Validators.required],
      ApellidoPaterno: ['', Validators.required],
      ApellidoMaterno: ['', Validators.required],
      CP:['',[Validators.minLength(5),Validators.maxLength(5),Validators.required,Validators.pattern('^[0-9]*$')]],
      Direccion:['',Validators.required],
      Rol:['',Validators.required],
      Genero:['',Validators.required],
      Asentamiento:['',Validators.required],
      Estatus:['',Validators.required],
      FechaNacimiento:['',Validators.required],
    });
  }
  ObtenerRoles(){
    this.usuarioService.ObtenerRoles().subscribe(x => {
      this.ArrayRoles.set(x.data);

    }, error => console.log(error))
  }
  ObtenerGeneros(){
    this.usuarioService.ObtenerGeneros().subscribe(x => {
      this.ArrayGeneros.set(x.data);

    }, error => console.log(error))
  }

  ObtenerColonias(){
    this.usuarioService.ObtenerCPEsp(this.InfoUsuarioLocalStorage.cp).subscribe(x => {
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


  ObtenerErrorCP(){
    if (this.frmUsuario.controls["CP"].hasError('required')) {
      return 'El C.P. es requerido';
    }else if(this.frmUsuario.controls["CP"].hasError('pattern')){
      return 'Ingrese solamente números'
    }else{
      return 'Longitud de 5 caracteres'
    }
  }

  ObtenerErrorEmail() {
    if (this.frmUsuario.controls["Email"].hasError('required')) {
      return 'El correo es requerido';
    }

    return this.frmUsuario.controls["Email"].hasError('email') ? 'Ingrese un correo válido' : '';
  }




  SetDatos() {


      this.frmUsuario.controls["Email"].setValue(this.InfoUsuarioLocalStorage.email);
      this.frmUsuario.controls["Nombre"].setValue(this.InfoUsuarioLocalStorage.nombres);
      this.frmUsuario.controls["ApellidoPaterno"].setValue(this.InfoUsuarioLocalStorage.apellido_paterno);
      this.frmUsuario.controls["ApellidoMaterno"].setValue(this.InfoUsuarioLocalStorage.apellido_materno)
      this.frmUsuario.controls["CP"].setValue(this.InfoUsuarioLocalStorage.cp);
      this.frmUsuario.controls["Direccion"].setValue(this.InfoUsuarioLocalStorage.domicilio,Validators.required);
      this.frmUsuario.controls["Rol"].setValue(this.InfoUsuarioLocalStorage.id_rol);
      this.frmUsuario.controls["Genero"].setValue(this.InfoUsuarioLocalStorage.id_genero);
      this.frmUsuario.controls["Asentamiento"].setValue(this.InfoUsuarioLocalStorage.id_asenta_cpcons);
      this.frmUsuario.controls["Estatus"].setValue(this.InfoUsuarioLocalStorage.estatus);
      this.frmUsuario.controls["FechaNacimiento"].setValue(this.InfoUsuarioLocalStorage.fecha_nacimiento);
    ;
  }

Submit(){
  if(this.frmUsuario.valid)
  this.EditarUsuario();
}

EditarUsuario(){

  this.usuarioService.ModificarUsuario(this.InfoUsuarioLocalStorage.id,{
    nombres:this.frmUsuario.controls["Nombre"].value,
    email:this.frmUsuario.controls["Email"].value,
    apellido_materno:this.frmUsuario.controls["ApellidoMaterno"].value,
    apellido_paterno:this.frmUsuario.controls["ApellidoPaterno"].value,
    domicilio:this.frmUsuario.controls["Direccion"].value,
    fecha_nacimiento:this.frmUsuario.controls["FechaNacimiento"].value,
    id_rol:this.frmUsuario.controls["Rol"].value,
    id_genero:this.frmUsuario.controls["Genero"].value,
    id_asenta:this.frmUsuario.controls["Asentamiento"].value,
    cp:this.frmUsuario.controls["CP"].value,
    url_imagen:this.reader.result,
    estatus:this.frmUsuario.controls["Estatus"]
  }).subscribe((x)=>{
    this.usuarioService.Me().subscribe(y => {
      localStorage.setItem('info_usuario', JSON.stringify(y.data));
      Swal.fire("¡Operacion Exitosa!", x.data.toString(), "success").then(function () {
        // window.location.reload();

      })
    },error=>{
      Swal.fire({
        title: 'Alerta',
        html: 'Error: ' + error.error.message,
        icon: 'error',
        customClass: {
          container: 'my-swal',
        },
      })
    });
  },error=>{
    Swal.fire({
      title: 'Alerta',
      html: 'Error: ' + error.error.message,
      icon: 'error',
      customClass: {
        container: 'my-swal',
      },
    })
  });
}


}

