package uts.edu.co.blog.repositorio;


import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import uts.edu.co.blog.modelo.Usuario;

public interface UsuarioRepositorio extends JpaRepository<Usuario, Long>{
    Optional<Usuario> findByCorreo(String correo);
    
} 