package uts.edu.co.blog.servicio;

import java.util.List;
import uts.edu.co.blog.modelo.Comentario;

public interface ComentarioServicio {
    public List<Comentario> obtenerTodosLosComentarios();
    public List<Comentario> obtenerComentariosPorBlogId(Long blogId);
    public Comentario guardarComentario(Comentario comentario);
    public void eliminarComentario(Long id);

}
