package uts.edu.co.blog.servicio.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import uts.edu.co.blog.modelo.Blog;
import uts.edu.co.blog.modelo.Usuario;
import uts.edu.co.blog.repositorio.BlogRepositorio;
import uts.edu.co.blog.repositorio.UsuarioRepositorio;
import uts.edu.co.blog.servicio.UsuarioServicio;

import java.util.List;

@Service
public class UsuarioServicioImpl implements UsuarioServicio {
    @Autowired
    private UsuarioRepositorio usuarioRepository;

    @Autowired
    private BlogRepositorio blogRepository;

    @Override
    public List<Usuario> obtenerTodosLosUsuarios() {
        return usuarioRepository.findAll();
    }

    @Override
    public Usuario obtenerUsuarioPorId(Long id) {
        return usuarioRepository.findById(id).orElse(null);
    }

    @Override
    public Usuario obtenerUsuarioPorCorreo(String correo) {
        return usuarioRepository.findByCorreo(correo).orElse(null);
    }

    @Override
    public Usuario guardarUsuario(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario actualizarUsuario(Long id, Usuario usuarioDetalles) {
        Usuario usuario = obtenerUsuarioPorId(id);

        if (usuario != null) {
            usuario.setNombre(usuarioDetalles.getNombre());
            usuario.setCorreo(usuarioDetalles.getCorreo());
            usuario.setContraseña(usuarioDetalles.getContraseña());
            return usuarioRepository.save(usuario);
        }

        return null;
    }

    @Transactional
    public void eliminarUsuario(Long id) {
        Usuario usuario = obtenerUsuarioPorId(id);
        if (usuario != null) {
            List<Blog> eliminarBlogs = blogRepository.findByUsuario(usuario);
            blogRepository.deleteAll(eliminarBlogs);
            usuarioRepository.deleteById(id);
        } else {
            // Manejo del caso en el que el usuario no se encuentra
            throw new EntityNotFoundException("Usuario no encontrado con el id: " + id);
        }
    }

}
