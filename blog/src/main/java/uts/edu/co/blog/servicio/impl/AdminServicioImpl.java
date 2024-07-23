package uts.edu.co.blog.servicio.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import uts.edu.co.blog.modelo.Admin;
import uts.edu.co.blog.repositorio.AdminRepositorio;
import uts.edu.co.blog.servicio.AdminServicio;

@Service
public class AdminServicioImpl implements AdminServicio {

    @Autowired
    private AdminRepositorio adminRepository;

    @Override
    public Admin obtenerAdminPorId(Long id) {
        return adminRepository.findById(id).orElse(null);
    }

    @Override
    public Admin obtenerAdminPorCorreo(String correo) {
        return adminRepository.findByCorreo(correo).orElse(null);
    }

    @Override
    public Admin guardarAdmin(Admin admin) {
        return adminRepository.save(admin);
    }

    @Override
    public Admin actualizarAdmin(Long id, Admin adminDetalles) {
        Admin admin = obtenerAdminPorId(id);

        if (admin != null) {
            admin.setNombre(adminDetalles.getNombre());
            admin.setCorreo(adminDetalles.getCorreo());
            admin.setContraseña(adminDetalles.getContraseña());
            return adminRepository.save(admin);
        }

        return null;
    }

    @Override
    public void eliminarAdmin(Long id) {
        adminRepository.deleteById(id);
    }

    

   
}
