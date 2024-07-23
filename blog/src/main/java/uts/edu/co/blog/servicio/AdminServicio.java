package uts.edu.co.blog.servicio;

import uts.edu.co.blog.modelo.Admin;

public interface AdminServicio {
    public Admin obtenerAdminPorId(Long id);

    public Admin obtenerAdminPorCorreo(String correo);

    public Admin guardarAdmin(Admin admin);

    public Admin actualizarAdmin(Long id, Admin admin) ;

    public void eliminarAdmin(Long id);


}
