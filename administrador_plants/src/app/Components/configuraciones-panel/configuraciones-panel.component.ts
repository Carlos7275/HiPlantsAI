import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/services/usuario.service';
import Swal from 'sweetalert2';
@Component({
  selector: 'app-configuraciones-panel',
  templateUrl: './configuraciones-panel.component.html',
  styleUrls: ['./configuraciones-panel.component.scss']
})
export class ConfiguracionesPanelComponent implements OnInit {
valorInput:string="";
valorInput2:string="";
valorInput3:string="";
frmConfiguracion:FormGroup;
constructor(private fb:FormBuilder,private UsuarioService:UsuarioService){}


ngOnInit():void{
  this.CrearFormulario();
}

CrearFormulario(){
  this.frmConfiguracion=this.fb.group({

    TokenTreffle:['',Validators.required],
    TokenPlants:['',Validators.required],
    TokenIpInfo:['',Validators.required],
    DistanciaMinima:['',[Validators.required,Validators.pattern('^[0-9]*$')]],
    DistanciaMaxima:['',[Validators.required,Validators.pattern('^[0-9]*$')]]
  })
}

submit(){
  if(this.frmConfiguracion.valid){
  this.ConfigurarPanel();
  }else{
    Swal.fire({
      title: 'Alerta',
          html: 'Error: Llene los campos correctamente e inténtelo de nuevo',
          icon: 'error',
    });
  }

}

ConfigurarPanel(){
  this.UsuarioService.ConfigurarPanel({
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
    (error) => Swal.fire(error.error.message, error.error.data.toString(), 'error')
  );
}

}
