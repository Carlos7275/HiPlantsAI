import { Component, OnInit } from '@angular/core';
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

frmConfiguracion:FormGroup;
constructor(private fb:FormBuilder,private ConfiguracionService:ConfiguracionService,private matSnackBar: MatSnackBar){}


ngOnInit():void{
  this.CrearFormulario();
}

CrearFormulario(){
  this.frmConfiguracion=this.fb.group({

    TokenTreffle:[''],
    TokenPlants:[''],
    TokenIpInfo:[''],
    DistanciaMinima:[''],
    DistanciaMaxima:['']
  })
}

submit(){
  if(this.frmConfiguracion.valid)
  this.ConfigurarPanel();
}

ConfigurarPanel(){



  this.ConfiguracionService.ActualizarConfiguracion({
    tokentreffle:this.frmConfiguracion.controls["TokenTreffle"].value,
	tokenplantsnet:this.frmConfiguracion.controls["TokenPlants"].value,
	tokenipinfo:this.frmConfiguracion.controls["TokenIpInfo"].value,
	distanciamin:this.frmConfiguracion.controls["DistanciaMinima"].value,
	distanciamax:this.frmConfiguracion.controls["DistanciaMaxima"].value
  }).subscribe(
    (x) => {

      Swal.fire('Enhorabuena', x.data.toString(), 'success').then(
        function () {
          window.location.reload();
        }
      );
    },
    (error) => this.matSnackBar.open(error.error.message,"X",{duration:5000})
  );
}

}
