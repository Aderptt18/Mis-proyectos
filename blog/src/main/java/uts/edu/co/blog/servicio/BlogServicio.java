package uts.edu.co.blog.servicio;

import java.util.List;

import uts.edu.co.blog.modelo.Blog;
import uts.edu.co.blog.modelo.Usuario;

public interface BlogServicio {

    public List<Blog> obtenerTodosLosBlogs();

    public List<Blog> obtenerTodosLosBlogsDesc();

    public List<Blog> obtenerBlogsPorUsuario(Usuario usuario);

    public Blog obtenerBlogPorId(Long id);

    public Blog guardarBlog(Blog blog);

    public Blog actualizarBlog(Long id, Blog blogDetalles);

    public void eliminarBlog(Long id);

}