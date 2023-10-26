export interface UsuarioInfo {
    id_usuario: number;
    email: string;
    url_imagen: string;
    id_rol: number;
    id_genero: number;
    estatus: string;
    nombres: string;
    apellido_paterno: string;
    apellido_materno: string;
    domicilio: string;
    id_asenta_cpcons: number;
    cp: string;
    fecha_nacimiento: Date;
}

export interface TUsuarioInfo {
    message: string;
    data: UsuarioInfo[];
}