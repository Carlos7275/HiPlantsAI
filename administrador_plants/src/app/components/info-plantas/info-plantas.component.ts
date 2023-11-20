import { Component } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { InformacionPlanta, Mapa } from 'src/app/models/Mapa.model';
import { MapaService } from 'src/app/services/mapa.service';

@Component({
  selector: 'app-info-plantas',
  templateUrl: './info-plantas.component.html',
  styleUrls: ['./info-plantas.component.scss']
})
export class InfoPlantasComponent {

  columnasMostradas: string[] = [
    'id',
    'nombre_planta',
    'nombre_cientifico',
    'url_imagen',
    'familia',
    'año',
    'genero',
    'created_at',
    "toxicidad",

  ];
  fuenteDatos = new MatTableDataSource<InformacionPlanta>();
  constructor(private mapaService: MapaService) {
    this.mapaService.ObtenerInfoPlantas().subscribe(x => {
      this.fuenteDatos.data = x.data;
    });
  }
}
