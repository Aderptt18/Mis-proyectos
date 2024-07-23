package uts.edu.co.blog.servicio;

import uts.edu.co.blog.modelo.Cuenta;

public interface CuentaServicio {
    public Cuenta obtenerCuentaPorId(Long id);

    public Cuenta guardarCuenta(Cuenta cuenta);

    public Cuenta actualizarCuenta(Long id, Cuenta cuenta) ;

    public void eliminarCuenta(Long id);

    public boolean cuentaRegistrada(Cuenta cuenta);
     
} 
