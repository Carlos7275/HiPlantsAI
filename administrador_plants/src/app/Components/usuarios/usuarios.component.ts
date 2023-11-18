import { Component, OnInit, OnDestroy } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { UsuarioInfo } from 'src/app/models/Usuario.model';
import { UsuarioService } from 'src/app/services/usuario.service';
import { ModalRegistroUsuarioComponent } from '../modal-registro-usuario/modal-registro-usuario.component';
import Swal from 'sweetalert2';
import { Subscription } from 'rxjs';
@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent implements OnInit, OnDestroy {
  componenteModal = ModalRegistroUsuarioComponent;
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
  subscripcion: Subscription;
  ngOnInit() {
    this.MostrarUsuarios();
    this.actualizarUsuarios();
  }
  constructor(private usuarioService: UsuarioService) { }
  ngOnDestroy(): void {
    this.subscripcion.unsubscribe;
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

  actualizarUsuarios() {
    this.subscripcion = this.usuarioService.refresh.subscribe(() => { this.MostrarUsuarios() });
  }

  ModificarEstatus(data: any) {
    let infoUsuario = JSON.parse(localStorage.getItem("info_usuario")!);
    if (infoUsuario.id != data.id) {
      Swal.fire({
        title: 'Atención',
        html: '¿Está seguro de hacer esta operación?',
        showDenyButton: true,
        confirmButtonText: 'Si',
        denyButtonText: 'No',
        icon: 'info'

      }).then((result) => {
        if (result.isConfirmed) {
          this.usuarioService.EliminarUsuario(data.id).subscribe(s => {
            Swal.fire(s.message, s.data.toString(), 'success')
          })
        }
      })
    }
  }



}


