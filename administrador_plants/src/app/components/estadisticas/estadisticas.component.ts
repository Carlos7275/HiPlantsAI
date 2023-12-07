import { animate, style, transition, trigger } from '@angular/animations';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Mapa } from 'src/app/models/Mapa.model';
import { MapaService } from 'src/app/services/mapa.service';
import { Environment } from 'src/enviroments/enviroment.prod';

@Component({
  selector: 'app-estadisticas',
  templateUrl: './estadisticas.component.html',
  styleUrls: ['./estadisticas.component.scss'],
  animations: [
    trigger('fadeIn', [
      transition(':enter', [
        style({ opacity: 0 }),
        animate('400ms', style({ opacity: 1 })),
      ])
    ]
    )]
})
export class EstadisticasComponent implements OnInit, OnDestroy {
  estadisticas: any;
  plantaMasVisitada: Mapa;
  subscripcion: Subscription;
  url = Environment.url;
  constructor(private mapaService: MapaService) { }

  ngOnInit(): void {
    this.ObtenerEstadisticas();
    this.ActualizarEstadisticas();
  }

  ngOnDestroy(): void {
    this.subscripcion.unsubscribe;
  }

  ObtenerEstadisticas() {
    this.mapaService.ObtenerEstadisticas().subscribe(x => {
      this.estadisticas = x.data;
    });
    this.mapaService.ObtenerPlantaMasVisitada().subscribe(x => {
      this.plantaMasVisitada = x.data;
    });
  }

  ActualizarEstadisticas() {
    this.subscripcion = this.mapaService.refresh.subscribe(() =>
      this.ObtenerEstadisticas()
    );
  }
}