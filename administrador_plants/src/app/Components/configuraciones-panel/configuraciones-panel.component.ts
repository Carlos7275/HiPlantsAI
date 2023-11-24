import { Component, OnInit, signal } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ConfiguracionService } from 'src/app/services/configuracion.service';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-configuraciones-panel',
  templateUrl: './configuraciones-panel.component.html',
  styleUrls: ['./configuraciones-panel.component.scss']
})
export class ConfiguracionesPanelComponent implements OnInit {
  dataConfiguracion: any;
  frmConfiguracion: FormGroup;
  constructor(
    private fb: FormBuilder,
    private ConfiguracionService: ConfiguracionService,
    private matSnackBar: MatSnackBar
  ) { }
  ngOnInit(): void {
    this.CrearFormulario();
    this.ObtenerConfiguracion();
  }
  LimpiarCampos() {
    this.frmConfiguracion.reset();
  }
  CrearFormulario() {
    this.frmConfiguracion = this.fb.group({
      TokenTreffle: ['',Validators.required],
      TokenPlants: ['',Validators.required],
      TokenIpInfo: ['',Validators.required],
      DistanciaMinima: [0,Validators.required],
      DistanciaMaxima: [0,Validators.required]
    })
  }
  ObtenerConfiguracion() {
    this.ConfiguracionService.ObtenerConfiguracion().subscribe((x) => {
      this.dataConfiguracion = x.data;
      this.SetDatos();
    }, error => console.log(error)
    );
  }
  SetDatos() {
    this.frmConfiguracion.controls["TokenTreffle"].setValue(this.dataConfiguracion.tokentreffle);
    this.frmConfiguracion.controls["TokenPlants"].setValue(this.dataConfiguracion.tokenplantsnet);
    this.frmConfiguracion.controls["TokenIpInfo"].setValue(this.dataConfiguracion.tokenipinfo);
    this.frmConfiguracion.controls["DistanciaMinima"].setValue(this.dataConfiguracion.distanciamin);
    this.frmConfiguracion.controls["DistanciaMaxima"].setValue(this.dataConfiguracion.distanciamax);
  }
  submit() {
    if (this.frmConfiguracion.valid)
      this.ConfigurarPanel();
  }
  ConfigurarPanel() {
    this.ConfiguracionService.ActualizarConfiguracion({
      tokentreffle: this.frmConfiguracion.controls["TokenTreffle"].value,
      tokenplantsnet: this.frmConfiguracion.controls["TokenPlants"].value,
      tokenipinfo: this.frmConfiguracion.controls["TokenIpInfo"].value,
      distanciamin: this.frmConfiguracion.controls["DistanciaMinima"].value,
      distanciamax: this.frmConfiguracion.controls["DistanciaMaxima"].value
    }).subscribe(
      (x) => {
        Swal.fire('Enhorabuena', x.data.toString(), 'success').then(
          function () {
            window.location.reload();
          }
        );
      },
      (error) => this.matSnackBar.open(`${error.error.message} ${error.error.data.toString()}`, "X", { duration: 5000 })
    );
  }
}
