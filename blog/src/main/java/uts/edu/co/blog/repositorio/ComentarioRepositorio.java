package uts.edu.co.blog.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import uts.edu.co.blog.modelo.Comentario;

public interface ComentarioRepositorio extends JpaRepository<Comentario, Long>{
    List<Comentario> findByBlogId(Long id);

}
