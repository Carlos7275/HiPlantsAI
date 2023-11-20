import { AfterViewInit, Component, OnDestroy } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import * as L from 'leaflet';
import { Subscription } from 'rxjs/internal/Subscription';
import { IpLocationService } from 'src/app/services/iplocation.service';
import { MapaService } from 'src/app/services/mapa.service';
import { Environment } from 'src/enviroments/enviroment.prod';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-mapa',
  templateUrl: './mapa.component.html',
  styleUrls: ['./mapa.component.scss']
})
export class MapaComponent implements AfterViewInit, OnDestroy {
  private map: any;
  private subscription: Subscription;
  constructor(
    private mapaService: MapaService,
    private ipLocationService: IpLocationService,
    private matSnackBar: MatSnackBar
  ) { }

  ngAfterViewInit(): void {
    this.initMap();
    this.CargarPlantas();
    this.RecargarPlantas();
  }
  RecargarPlantas() {
    this.subscription = this.mapaService.refresh.subscribe(() => this.CargarPlantas())
  }
  ngOnDestroy(): void {
    this.subscription.unsubscribe;
  }

  ObtenerIcono(url: string) {
    return L.icon({
      iconUrl: url,  // Provide the path to your custom icon image
      iconSize: [32, 32],  // Size of the icon
      iconAnchor: [16, 32],  // Point of the icon that corresponds to the marker's location
      popupAnchor: [0, -32]  // Point from which the popup should open relative to the iconAnchor
    })
  }
  private initMap(): void {
    this.ipLocationService.getCoordinatesByIp().subscribe(
      (data: any) => {
        let coordinates = data.loc.split(',');
        this.map = L.map('map', {
          center: [coordinates[0], coordinates[1]],
          zoom: 10
        });

        const tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
          maxZoom: 18,
          minZoom: 3,
          attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        });

        tiles.addTo(this.map);
      },
      error => {
        this.matSnackBar.open("Error al Recibir las Coordenadas por IP: " + error.toString(), "X", { duration: 5000 });

      }
    );

  }

  CambiarEstatus(id: number) {
    this.mapaService.CambiarEstatusPlanta(id)
      .subscribe(x => Swal.fire(x.message, x.data.toString(), 'success'),
        error => this.matSnackBar.open("Atencion:" + error.error.message, "X", { duration: 5000 }))
  }

  CargarPlantas() {
    var Marker: L.Marker;

    this.mapaService.ObtenerPlantas().subscribe(x => {
      let datos = x.data;
      if (datos.length > 0)
        datos.forEach(x => {
          Marker = x.estatus == 0 ?
            L.marker([x.latitud, x.longitud], { icon: this.ObtenerIcono('../../../assets/plantdisabled.png') }).addTo(this.map) :
            L.marker([x.latitud, x.longitud], { icon: this.ObtenerIcono("../../../assets/plant.png") }).addTo(this.map);

          const button = L.DomUtil.create('button', 'btn btn-warning');
          button.innerHTML = 'Cambiar Estatus';

          const popupContent = L.DomUtil.create('div', 'popup-content');
          popupContent.innerHTML = `
            <img src="${Environment.url + x.url_imagen}" width="150px" class="img-thumbnail responsive"/><br>
            <b>Planta ${x.info_plantas.nombre_planta}</b>
            <br>
            <p>Genero: ${x.info_plantas.genero}</p>
            <p>Estatus: ${this.mapaService.ObtenerEstatus(x.estatus)}</p>
          `;

          popupContent.appendChild(button);

          Marker.bindPopup(popupContent);

          L.DomEvent.addListener(button, 'click', () => {
            this.CambiarEstatus(x.id);
            this.map.closePopup();

          });
        });

    }, error => this.matSnackBar.open("Atencion:" + error.error.message, "X", { duration: 5000 }))
  }


}
