package uts.edu.co.blog.repositorio;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import uts.edu.co.blog.modelo.Admin;

public interface AdminRepositorio extends JpaRepository<Admin, Long>{
    Optional<Admin> findByCorreo(String correo);
}
