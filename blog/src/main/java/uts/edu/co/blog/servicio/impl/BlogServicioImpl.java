package uts.edu.co.blog.servicio.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import uts.edu.co.blog.modelo.Blog;
import uts.edu.co.blog.modelo.Usuario;
import uts.edu.co.blog.repositorio.BlogRepositorio;
import uts.edu.co.blog.servicio.BlogServicio;

@Service
public class BlogServicioImpl implements BlogServicio {
    @Autowired
    private BlogRepositorio blogRepository;

    @Override
    public List<Blog> obtenerTodosLosBlogs() {
        return blogRepository.findAll();
    }

    @Override
    public List<Blog> obtenerTodosLosBlogsDesc() {
        return blogRepository.findAllOrderByIdDesc();
    }

    @Override
    public List<Blog> obtenerBlogsPorUsuario(Usuario usuario) {
        return blogRepository.findByUsuario(usuario);
    }

    @Override
    public Blog obtenerBlogPorId(Long id) {
        return blogRepository.findById(id).orElse(null);
    }

    @Override
    public Blog guardarBlog(Blog blog) {
        return blogRepository.save(blog);
    }

    @Override
    public Blog actualizarBlog(Long id, Blog blogDetalles) {
        Blog blog = obtenerBlogPorId(id);

        if (blog != null) {
            blog.setTitulo(blogDetalles.getTitulo());
            blog.setParrafo(blogDetalles.getParrafo());
            return blogRepository.save(blog);
        }

        return null;
    }

    @Override
    public void eliminarBlog(Long id) {
        blogRepository.deleteById(id);
    }

}
