package uts.edu.co.blog.modelo;

import lombok.Data;
import jakarta.persistence.*;

@Data
@Entity
@Table(name = "comentarios")
public class Comentario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String contenido;
    
    private String nombreUsuario;

    @ManyToOne
    @JoinColumn(name = "blog_id")
    private Blog blog;
}
