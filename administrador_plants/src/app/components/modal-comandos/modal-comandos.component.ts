import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ComandosService } from 'src/app/services/comandos.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-modal-comandos',
  templateUrl: './modal-comandos.component.html',
  styleUrls: ['./modal-comandos.component.scss']
})
export class ModalComandosComponent implements OnInit {
  frmRegistro: FormGroup;
  title: any = "Registrar Comando";
  constructor(
    private fb: FormBuilder,
    private comandosService: ComandosService,
    public dialogRef: MatDialogRef<ModalComandosComponent>,
    @Inject(MAT_DIALOG_DATA) public dataModal: any
  ) { this.CrearFormulario() }
  ngOnInit(): void {
    if (this.dataModal) {
      this.title = "Modificar Comando";
      this.SetDatos();
    }
  }
  SetDatos() {
    this.frmRegistro.controls["comando"].setValue(this.dataModal.comando);
    this.frmRegistro.controls["descripcion"].setValue(this.dataModal.descripcion);
  }
  CrearFormulario() {
    this.frmRegistro = this.fb.group({
      comando: ['', Validators.required],
      descripcion: ['', Validators.required]
    });
  }

  LimpiarCampos() {
    this.frmRegistro.reset();
  }
  Submit() {
    if (this.frmRegistro.valid) {
      this.dataModal ? this.ModificarComando() : this.RegistrarComando();
    }

  }

  RegistrarComando() {
    this.comandosService.AgregarComando(
      {
        comando: this.frmRegistro.controls["comando"].value,
        descripcion: this.frmRegistro.controls["descripcion"].value
      }
    ).subscribe(x => {
      console.log(x.data);
      Swal.fire(x.message, x.data, 'success').then(() => this.dialogRef.close())
    }, error => console.log("Error al registrar un comando:", error));
  }

  ModificarComando() {
    this.comandosService.EditarComando(
      this.dataModal.id,
      {
        comando: this.frmRegistro.controls["comando"].value,
        descripcion: this.frmRegistro.controls["descripcion"].value
      }
    ).subscribe(x => {
      console.log(x.data);
      Swal.fire(x.message, x.data, 'success').then(() => this.dialogRef.close())
    }, error => console.log("Error al modificar un comando:", error));
  }


}
