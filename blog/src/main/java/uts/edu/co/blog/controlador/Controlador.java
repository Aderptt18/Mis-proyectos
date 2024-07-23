package uts.edu.co.blog.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import uts.edu.co.blog.modelo.Blog;
import uts.edu.co.blog.modelo.Comentario;
import uts.edu.co.blog.modelo.Cuenta;
import uts.edu.co.blog.modelo.Usuario;
import uts.edu.co.blog.servicio.impl.BlogServicioImpl;
import uts.edu.co.blog.servicio.impl.ComentarioServicioImpl;
import uts.edu.co.blog.servicio.impl.UsuarioServicioImpl;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class Controlador {
    private Usuario usuarioActual;

    @Autowired
    private UsuarioServicioImpl usuarioServicio;

    @Autowired
    private BlogServicioImpl blogServicio;

    @Autowired
    private ComentarioServicioImpl comentarioServicio;

    private void setUsuarioActual(Usuario usuario) {
        this.usuarioActual = usuario;
    }

    @GetMapping({ "/" })
    public String index(Model model) {
        if (usuarioActual == null) {
            return "redirect:/login";
        }

        // Fecha y hora actual
        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formatter);

        model.addAttribute("usuario", usuarioActual);
        model.addAttribute("fechaHoraActual", fechaHoraFormateada);

        return "vista/usuario/index";
    }

    @GetMapping("/crear-cuenta")
    public String mostrarFormularioCrearCuenta(Model model) {
        Usuario usuario = new Usuario();
        model.addAttribute("usuario", usuario);
        return "vista/usuario/crear-cuenta";
    }

    @PostMapping("/crear-cuenta")
    public String crearCuenta(Usuario usuario, Model model) {
        usuarioServicio.guardarUsuario(usuario);
        return "redirect:/login"; // Redirigir al inicio de sesión después de crear la cuenta
    }

    @GetMapping("/login")
    public String loginPage(Model model) {
        Cuenta cuenta = new Cuenta();
        model.addAttribute("cuenta", cuenta);
        return "vista/usuario/ingresar";
    }

    @PostMapping("/login")
    public String login(Cuenta cuenta, Model model) {
        Usuario usuario = usuarioServicio.obtenerUsuarioPorCorreo(cuenta.getCorreo());
        if (usuario != null && usuario.getContraseña().equals(cuenta.getContraseña())) {
            setUsuarioActual(usuario);
            return "redirect:/";
        } else {
            model.addAttribute("error", "Correo o contraseña incorrectos");
            return "vista/usuario/ingresar";
        }
    }

    @GetMapping("/blogs")
    public String mostrarTodosLosBlogs(Model model) {
        List<Blog> blogs = blogServicio.obtenerTodosLosBlogsDesc();
        model.addAttribute("blogs", blogs);
        Map<Long, List<Comentario>> comentariosPorBlog = new HashMap<>();
        for (Blog blog : blogs) {
            List<Comentario> comentarios = comentarioServicio.obtenerComentariosPorBlogId(blog.getId());
            comentariosPorBlog.put(blog.getId(), comentarios);
        }

        model.addAttribute("comentariosPorBlog", comentariosPorBlog);
        return "vista/usuario/blogs";
    }

    @GetMapping("/mis-blogs")
    public String mostrarMisBlogs(Model model) {
        if (usuarioActual == null) {
            return "redirect:/login";
        }
        List<Blog> misBlogs = blogServicio.obtenerBlogsPorUsuario(usuarioActual);
        model.addAttribute("misBlogs", misBlogs);
        return "vista/usuario/mis-blogs";
    }  

    @GetMapping("/crear-blog")
    public String mostrarFormularioCrearBlog(Model model) {
        if (usuarioActual == null) {
            return "redirect:/login";
        }
        Blog blog = new Blog();
        model.addAttribute("blog", blog);
        return "vista/usuario/crear-blogs";
    }

    @PostMapping("/crear-blog")
    public String crearBlog(Blog blog, Model model) {
        if (usuarioActual == null) {
            return "redirect:/login";
        }
        blog.setUsuario(usuarioActual); // Establece el usuario actual como el autor del blog
        blogServicio.guardarBlog(blog);
        return "redirect:/blogs"; // Redirigir a la página de todos los blogs después de crear el blog
    }

    @GetMapping("/perfil")
    public String mostrarPerfil(Model model) {
        model.addAttribute("usuario", usuarioActual);
        return "vista/usuario/perfil";
    }

    @PostMapping("/perfil/cambiarContraseña")
    public String cambiarContraseña(String contraseñaActual, String nuevaContraseña, Model model,
            RedirectAttributes attribute) {
        if (usuarioActual.getContraseña().equals(contraseñaActual)) {
            usuarioActual.setContraseña(nuevaContraseña);
            usuarioServicio.actualizarUsuario(usuarioActual.getId(), usuarioActual); // Asegúrate de guardar el cambio
                                                                                     // en la base de datos
            model.addAttribute("usuario", usuarioActual);
            return "redirect:/perfil";
        } else {
            attribute.addFlashAttribute("errorContraseña", "Contraseña actual incorrecta");
            return "redirect:/perfil";
        } 
    }

    @PostMapping("/perfil/cerraSesion")
    public String cerrarSesion() {
        return "redirect:/login";
    }

    
    @PostMapping("/comentarios")
    public String agregarComentario(@RequestParam Long blogId, @RequestParam String contenido,
            RedirectAttributes attribute, Model model) {
        if (usuarioActual == null) {
            return "redirect:/login";
        } else {
            Blog blog = blogServicio.obtenerBlogPorId(blogId);
            Comentario comentario = new Comentario();
            comentario.setBlog(blog);
            comentario.setNombreUsuario(usuarioActual.getNombre());
            comentario.setContenido(contenido);
            comentarioServicio.guardarComentario(comentario);
            attribute.addFlashAttribute("mensaje", "Comentario agregado exitosamente");
        }
        return "redirect:/blogs";
    }
}
