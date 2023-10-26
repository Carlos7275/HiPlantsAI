import { HttpErrorResponse } from '@angular/common/http';
import { Component } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { UsuarioInfo } from 'src/app/Modelos/Usuario.model';
import { UsuarioService } from 'src/app/Servicios/Usuario.service';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent {
  constructor(private usuarioService: UsuarioService) {}

  columnasMostradas: string[] = [
    'nombres',
    'apellido_paterno',
    'apellido_materno',
    'email',
    'id_rol',
    'id_genero',
    'estatus'
  ];
  fuenteDatos = new MatTableDataSource<UsuarioInfo>();

  ngAfterViewInit() {
    this.MostrarUsuarios();
  }

  MostrarUsuarios() {
    this.usuarioService.ObtenerUsuarios().subscribe({
      error: (error) => {
        console.log(error.error);
      },
      complete: () => {},
      next: (response) => {
        this.fuenteDatos.data = response.data;
        console.log(response);
      },
    });
  }
}


