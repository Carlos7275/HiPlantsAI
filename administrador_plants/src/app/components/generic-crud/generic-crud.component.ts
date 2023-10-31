import { Component, Input, ViewChild } from '@angular/core';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator, MatPaginatorIntl } from '@angular/material/paginator';
import { Output, EventEmitter } from '@angular/core';
import { Environment } from 'src/enviroments/enviroment.prod';

@Component({
  selector: 'app-generic-crud',
  templateUrl: './generic-crud.component.html',
  styleUrls: ['./generic-crud.component.scss']
})
export class GenericCrudComponent<T> {
  @Input() Entidad:String;
  @Input() EntidadSingular:String;
  @Input() columnasMostradas: string[] ;
  @Input() fuenteDatos = new MatTableDataSource<T>();
  Url:String=Environment.url;

  constructor(MatPaginator:MatPaginatorIntl){
    MatPaginator.nextPageLabel="Siguiente Página";
    MatPaginator.firstPageLabel="Primera Página";
    MatPaginator.itemsPerPageLabel="Registros por Página"
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
}
