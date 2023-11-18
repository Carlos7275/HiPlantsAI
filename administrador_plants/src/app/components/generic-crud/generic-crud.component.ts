import { Component, Input, OnInit, ViewChild } from '@angular/core';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator, MatPaginatorIntl } from '@angular/material/paginator';
import { Environment } from 'src/enviroments/enviroment.prod';
import { MatDialog } from '@angular/material/dialog';
import { UsuarioInfo } from 'src/app/models/Usuario.model';
import { UsuarioService } from 'src/app/services/usuario.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-generic-crud',
  templateUrl: './generic-crud.component.html',
  styleUrls: ['./generic-crud.component.scss']
})
export class GenericCrudComponent<T> implements OnInit {
  @Input() Entidad: String;
  @Input() EntidadSingular: String;
  @Input() columnasMostradas: string[];
  @Input() fuenteDatos = new MatTableDataSource<T>();
  @Input() componenteModal: any;
  @Input() SinModal:Boolean=false;
  Url: String = Environment.url;
  @Input() eliminar: Function;

  constructor(MatPaginator: MatPaginatorIntl, private dialog: MatDialog, private usuarioService: UsuarioService) {
    MatPaginator.nextPageLabel = "Siguiente Página";
    MatPaginator.firstPageLabel = "Primera Página";
    MatPaginator.itemsPerPageLabel = "Registros por Página"
  }
  ngOnInit(): void {

  }

  @ViewChild(MatSort, { static: false })
  set sort(value: MatSort) {
    if (this.fuenteDatos) {
      this.fuenteDatos.sort = value;
    }
  }

  @ViewChild(MatPaginator, { static: false })
  set paginator(value: MatPaginator) {
    if (this.fuenteDatos) {
      this.fuenteDatos.paginator = value;
    }
  }
  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.fuenteDatos.filter = filterValue.trim().toLowerCase();
  }

  abrirModal(enterAnimationDuration: string, exitAnimationDuration: string, data: any = '') {
    this.dialog.open(this.componenteModal, {
      width: 'auto',
      enterAnimationDuration,
      exitAnimationDuration,
      data
    })
  }

  abrir() {
    this.abrirModal('0ms', '0ms', 'Registrar');
  }

  editar(data:any) {
    this.abrirModal('0ms', '0ms', data);
  }


}
