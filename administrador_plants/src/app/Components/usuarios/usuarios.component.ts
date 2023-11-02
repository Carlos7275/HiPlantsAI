import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { UsuarioInfo } from 'src/app/models/Usuario.model';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent implements OnInit {
  constructor(private usuarioService: UsuarioService) { }

  columnasMostradas: string[] = [
    'id',
    'nombres',
    'apellido_paterno',
    'apellido_materno',
    'email',
    'id_rol',
    'url_imagen',
    'estatus',
    'acciones'
  ];
  fuenteDatos = new MatTableDataSource<UsuarioInfo>();
  ngOnInit() {
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


