package uts.edu.co.blog.servicio.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import uts.edu.co.blog.modelo.Comentario;
import uts.edu.co.blog.repositorio.ComentarioRepositorio;
import uts.edu.co.blog.servicio.ComentarioServicio;

@Service
public class ComentarioServicioImpl implements ComentarioServicio{
    @Autowired
    private ComentarioRepositorio comentarioRepository;

    @Override
    public List<Comentario> obtenerTodosLosComentarios() {
        return comentarioRepository.findAll();
    }

    @Override
    public List<Comentario> obtenerComentariosPorBlogId(Long blogId) {
        return comentarioRepository.findByBlogId(blogId);
    }

    @Override
    public Comentario guardarComentario(Comentario comentario) {
        return comentarioRepository.save(comentario);
    }
    @Override
    public void eliminarComentario(Long id) {
        comentarioRepository.deleteById(id);
    }
    
}
