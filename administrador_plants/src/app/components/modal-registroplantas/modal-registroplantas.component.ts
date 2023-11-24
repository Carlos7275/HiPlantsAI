import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';
import { MapaService } from 'src/app/services/mapa.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-modal-registroplantas',
  templateUrl: './modal-registroplantas.component.html',
  styleUrls: ['./modal-registroplantas.component.scss']
})
export class ModalRegistroplantasComponent {
  public imagePath: any;
  imgURL: any;
  public message: string;
  reader = new FileReader();
  frmRegistro: FormGroup;

  constructor(
    private fb: FormBuilder,
    private mapaService: MapaService,
    public dialogRef: MatDialogRef<ModalRegistroplantasComponent>
  ) { this.CrearFormulario() }

  CrearFormulario() {
    this.frmRegistro = this.fb.group({
      Latitud: ['', [Validators.required, Validators.min(-90), Validators.max(90)]],
      Longitud: ['', [Validators.required, Validators.min(-180), Validators.max(180)]]
    });
  }

  LimpiarCampos() {
    this.frmRegistro.reset();
    this.imgURL = "";
  }
  Submit() {
    if (this.frmRegistro.valid && this.reader)
      this.RegistrarPlanta();
  }

  RegistrarPlanta() {
    this.mapaService.RegistrarPlanta(
      {
        latitud: this.frmRegistro.controls["Latitud"].value,
        longitud: this.frmRegistro.controls["Longitud"].value,
        imagen: this.reader.result
      }
    ).subscribe(x => {
      console.log(x.data);
      Swal.fire(x.message, `Se registro la planta ${x.data.nombre_planta}`, 'success').then(() => this.dialogRef.close())
    }, error => console.log("Error al registrar una planta:", error));
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
}
