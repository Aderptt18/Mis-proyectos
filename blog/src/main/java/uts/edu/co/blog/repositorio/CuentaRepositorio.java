package uts.edu.co.blog.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;

import uts.edu.co.blog.modelo.Cuenta;

public interface CuentaRepositorio extends JpaRepository<Cuenta, Long>{
}
