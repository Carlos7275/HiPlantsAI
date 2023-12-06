import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { Subscription } from 'rxjs';
import { Comandos } from 'src/app/models/Comandos.model';
import { ComandosService } from 'src/app/services/comandos.service';
import Swal from 'sweetalert2';
import { ModalComandosComponent } from '../modal-comandos/modal-comandos.component';

@Component({
  selector: 'app-comandos',
  templateUrl: './comandos.component.html',
  styleUrls: ['./comandos.component.scss']
})
export class ComandosComponent implements OnInit {
  componenteModal = ModalComandosComponent;

  columnasMostradas: string[] = [
    'id',
    'comando',
    'descripcion',
    'acciones'
  ];
  fuenteDatos = new MatTableDataSource<Comandos>();
  subscripcion: Subscription;
  ngOnInit() {
    this.MostrarComandos();
    this.ActualizarComandos();
  }

  constructor(protected comandosService: ComandosService) { }

  ngOnDestroy(): void {
    this.subscripcion.unsubscribe;
  }

  MostrarComandos() {
    this.comandosService.ObtenerComandos().subscribe({
      error: (error) => {
        console.log(error.error);
      },
      complete: () => { },
      next: (response) => {
        this.fuenteDatos.data = response.data;
      },
    });
  }

  ActualizarComandos() {
    this.subscripcion = this.comandosService.refresh.subscribe(() => { this.MostrarComandos() });
  }

  EliminarComando(data: any) {
    let id:number=data.id;
    Swal.fire({
      title: 'Atención',
      html: '¿Está seguro de hacer esta operación? No se puede deshacer!',
      showDenyButton: true,
      confirmButtonText: 'Si',
      denyButtonText: 'No',
      icon: 'info'

    }).then((result) => {

      if (result.isConfirmed) {
       this.comandosService.EliminarComando(id).subscribe(s=>{
        Swal.fire(s.message,s.data,"success");
       },error=>console.log(error));
      }
    })
  }
}

