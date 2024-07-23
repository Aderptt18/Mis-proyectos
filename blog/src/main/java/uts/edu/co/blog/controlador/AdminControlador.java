package uts.edu.co.blog.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import uts.edu.co.blog.modelo.Admin;
import uts.edu.co.blog.modelo.Blog;
import uts.edu.co.blog.modelo.Comentario;
import uts.edu.co.blog.modelo.Cuenta;
import uts.edu.co.blog.modelo.Usuario;
import uts.edu.co.blog.servicio.impl.AdminServicioImpl;
import uts.edu.co.blog.servicio.impl.BlogServicioImpl;
import uts.edu.co.blog.servicio.impl.ComentarioServicioImpl;
import uts.edu.co.blog.servicio.impl.UsuarioServicioImpl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Data;

import org.springframework.web.bind.annotation.RequestBody;


@Data
@Controller
@RequestMapping("/admin")
public class AdminControlador {
    private Admin adminActual;

    @Autowired
    private AdminServicioImpl adminServicio;

    @Autowired
    private BlogServicioImpl blogServicio;

    @Autowired
    private ComentarioServicioImpl comentarioServicio;

    @Autowired
    private UsuarioServicioImpl usuarioServicio;

    public Admin getAdminActual() {
        return adminActual;
    }

    public void setAdminActual(Admin adminActual) {
        this.adminActual = adminActual;
    }

    @GetMapping("")
    public String inicio(){
        return "redirect:/admin/";
    }

    @GetMapping( "/" )
    public String index(Model model) {
        if (adminActual == null) {
            return "redirect:/admin/login";
        }
        // Fecha y hora actual
        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formatter);

        model.addAttribute("admin", adminActual);
        model.addAttribute("fechaHoraActual", fechaHoraFormateada);

        return "vista/admin/index";
    }

    @GetMapping("/login")
    public String loginPage(Model model) {
        Cuenta cuenta = new Cuenta();
        model.addAttribute("cuenta", cuenta);
        return "vista/admin/ingresar";
    }

    @PostMapping("/login")
    public String login(Cuenta cuenta, Model model) {
        Admin admin = adminServicio.obtenerAdminPorCorreo(cuenta.getCorreo());
        if (admin != null && admin.getContraseña().equals(cuenta.getContraseña())) {
            setAdminActual(admin);
            return "redirect:/admin/";
        } else {
            model.addAttribute("error", "Correo o contraseña incorrectos");
            return "vista/admin/ingresar";
        }
    }

    @GetMapping("/inicio")
    public String accerderInicio(Model model) {
        List<Blog> blogs = blogServicio.obtenerTodosLosBlogsDesc();
        model.addAttribute("listaBlogs", blogs);
        Map<Long, List<Comentario>> comentariosPorBlog = new HashMap<>();
        for (Blog blog : blogs) {
            List<Comentario> comentarios = comentarioServicio.obtenerComentariosPorBlogId(blog.getId());
            comentariosPorBlog.put(blog.getId(), comentarios);
        }
        model.addAttribute("comentariosPorBlog", comentariosPorBlog);
        return "vista/admin/inicio";
    }

    @GetMapping("/mantenimiento")
    public String accerderMantenimiento(Model model) {
        List<Blog> blogs = blogServicio.obtenerTodosLosBlogs();
        model.addAttribute("blogs", blogs);
        return "vista/admin/mantenimiento/mantenimiento";
    }

    @GetMapping("/mantenimiento/nuevo")
    public String mostrarFormularioCrearBlog(Model model) {
        Blog blog = new Blog();
        model.addAttribute("blog", blog);
        return "vista/admin/mantenimiento/crear-blog";
    }

    @PostMapping("/mantenimiento/nuevo")
    public String crearBlog(Blog blog, Model model) {
        blogServicio.guardarBlog(blog);
        return "redirect:/admin/inicio"; // Redirigir al inicio de sesión después de crear la cuenta
    }

    private Long blogId;
    @GetMapping("/mantenimiento/editar/{codigoBlog}")
    public String editarBlogFormulario(@PathVariable String codigoBlog, Model model) {
        Long idBlog=Long.parseLong(codigoBlog);
        setBlogId(idBlog);
        model.addAttribute("blog", blogServicio.obtenerBlogPorId(idBlog));       
        return "vista/admin/mantenimiento/editar-blog";
    }

    @PostMapping("/mantenimiento/editar")
    public String editarBlog(Blog blog) {
        blogServicio.actualizarBlog(blogId, blog);
        return "redirect:/admin/mantenimiento";
    }

    @RequestMapping("/mantenimiento/eliminar/{codigoBlog}")
    public String eliminarBlog(@PathVariable String codigoBlog) {
        Long idBlog=Long.parseLong(codigoBlog);
        blogServicio.eliminarBlog(idBlog);
        return "redirect:/admin/mantenimiento";
    }

    @GetMapping("/reporte")
    public String accerderReporte() {
        return "vista/admin/reporte";
    }

    @GetMapping("/configuracion")
    public String accerderConfiguracion(Model model) {
        List<Usuario> listaUsuarios = usuarioServicio.obtenerTodosLosUsuarios();
        model.addAttribute("listaUsuarios", listaUsuarios);
        return "vista/admin/configuracion/configuracion";
    }
 
    @GetMapping("/configuracion/nuevo")
    public String mostrarFormularioCrearUsuario(Model model) {
        Usuario usuario = new Usuario();
        model.addAttribute("usuario", usuario);
        return "vista/admin/configuracion/crear-usuario";
    }

    @PostMapping("/configuracion/nuevo")
    public String crearUsuario(Usuario usuario, Model model) {
        usuarioServicio.guardarUsuario(usuario);
        return "redirect:/admin/configuracion"; // Redirigir al inicio de sesión después de crear la cuenta
    }

    private Long id;
    @GetMapping("/configuracion/editar/{codigoUsuario}")
    public String editarUsuario(@PathVariable String codigoUsuario, Model model) {
        Long idUsuario=Long.parseLong(codigoUsuario);
        setId(idUsuario);
        model.addAttribute("usuario", usuarioServicio.obtenerUsuarioPorId(idUsuario));       
        return "vista/admin/configuracion/editar-usuario";
    }

    @PostMapping("/configuracion/editar")
    public String usuarioEditado(Usuario usuario) {
        usuarioServicio.actualizarUsuario(getId(), usuario);
        return "redirect:/admin/configuracion";
    }

    @RequestMapping("/configuracion/eliminar/{codigoUsuario}")
    public String eliminarUsuario(@PathVariable String codigoUsuario) {
        Long idUsuario=Long.parseLong(codigoUsuario);
        usuarioServicio.eliminarUsuario(idUsuario);
        return "redirect:/admin/configuracion";
    }

    @GetMapping("/salir")
    public String accederSalir(Model model) {
        model.addAttribute("admin", adminActual);
        return "vista/admin/salir";
    }

    @PostMapping("/salir/cambiarContraseña")
    public String cambiarContraseña(String contraseñaActual, String nuevaContraseña, Model model,
            RedirectAttributes attribute) {
        if (adminActual.getContraseña().equals(contraseñaActual)) {
            adminActual.setContraseña(nuevaContraseña);
            adminServicio.actualizarAdmin(adminActual.getId(), adminActual); // Asegúrate de guardar el cambio
                                                                                     // en la base de datos
            model.addAttribute("usuario", adminActual);
            return "redirect:/admin/salir";
        } else {
            attribute.addFlashAttribute("errorContraseña", "Contraseña actual incorrecta");
            return "redirect:/admin/salir";
        } 
    }

    @PostMapping("/salir/cerrarSesion")
    public String cerrarSesion() {
        return "redirect:/admin/login";
    }

}