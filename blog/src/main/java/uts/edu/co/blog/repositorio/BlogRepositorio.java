package uts.edu.co.blog.repositorio;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import uts.edu.co.blog.modelo.Blog;
import uts.edu.co.blog.modelo.Usuario;

public interface BlogRepositorio extends JpaRepository<Blog, Long>{
    List<Blog> findByUsuario(Usuario usuario);

    @Query("SELECT b FROM Blog b ORDER BY b.id DESC")
    List<Blog> findAllOrderByIdDesc();
}
