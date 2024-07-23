package uts.edu.co.blog.servicio;

import java.util.List;

import uts.edu.co.blog.modelo.Usuario;

public interface UsuarioServicio {
    public List<Usuario> obtenerTodosLosUsuarios();

    public Usuario obtenerUsuarioPorId(Long id);

    public Usuario obtenerUsuarioPorCorreo(String correo);

    public Usuario guardarUsuario(Usuario usuario);

    public Usuario actualizarUsuario(Long id, Usuario usuarioDetalles);

    public void eliminarUsuario(Long id);


} 