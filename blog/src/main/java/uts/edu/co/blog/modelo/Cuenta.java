package uts.edu.co.blog.modelo;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Cuenta {
    @Id
    private Long id;

    private String nombre;

    private String correo;

    private String contraseña;

    private boolean registrado;
}




    