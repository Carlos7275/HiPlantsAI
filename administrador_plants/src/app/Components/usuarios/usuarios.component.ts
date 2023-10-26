import { Component, ViewChild } from '@angular/core';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { UsuarioInfo } from 'src/app/models/Usuario.model';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent {
  constructor(private usuarioService: UsuarioService) { }

  columnasMostradas: string[] = [
    'id_usuario',
    'nombres',
    'apellido_paterno',
    'apellido_materno',
    'email',
    'id_rol',
    'id_genero',
    'estatus'
  ];
  fuenteDatos = new MatTableDataSource<UsuarioInfo>();

  @ViewChild(MatSort, { static: false })
  set sort(value: MatSort) {
    if (this.fuenteDatos) {
      this.fuenteDatos.sort = value;
    }
  }
  ngAfterViewInit() {
    this.MostrarUsuarios();
  }

  MostrarUsuarios() {
    this.usuarioService.ObtenerUsuarios().subscribe({
      error: (error) => {
        console.log(error.error);
      },
      complete: () => { },
      next: (response) => {
        this.fuenteDatos.data = response.data;
      },
    });
  }
}


