package uts.edu.co.blog.servicio.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import uts.edu.co.blog.modelo.Cuenta;
import uts.edu.co.blog.repositorio.CuentaRepositorio;
import uts.edu.co.blog.servicio.CuentaServicio;


@Service
public class CuentaServicioImpl implements CuentaServicio {
    @Autowired
    private CuentaRepositorio cuentaRepository;
 
    
    @Override
    public Cuenta obtenerCuentaPorId(Long id) {
        return cuentaRepository.findById(id).orElse(null);
    }

    @Override
    public Cuenta guardarCuenta(Cuenta cuenta) {
        cuenta.setRegistrado(true);
        return cuentaRepository.save(cuenta);
    }

    @Override
    public Cuenta actualizarCuenta(Long id, Cuenta cuentaDetalles) {
        Cuenta cuenta = obtenerCuentaPorId(id);

        if (cuenta != null) {
            cuenta.setNombre(cuentaDetalles.getNombre());
            cuenta.setCorreo(cuentaDetalles.getCorreo());
            cuenta.setContraseña(cuentaDetalles.getContraseña());
            return cuentaRepository.save(cuenta);
        }

        return null;
    }

    @Override
    public void eliminarCuenta(Long id) {
        cuentaRepository.deleteById(id);
    }

    @Override
    public boolean cuentaRegistrada(Cuenta cuenta) {
        return cuenta.isRegistrado();
    }

}
