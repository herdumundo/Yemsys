/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

/**
 *
 * @author hvelazquez
 */
public class embarque {
   
    public static String nro_fact;
    public static String cod_chofer;
    public static String cod_camion;
    public static String fecha;


    public embarque(String nro_fact, String cod_chofer, String cod_camion,String fecha) {
        this.nro_fact = nro_fact;
        this.cod_chofer = cod_chofer;
        this.cod_camion = cod_camion;
        this.fecha = fecha;
     }

    public embarque(){

    }

    public String getnro_fact() {
        return nro_fact;
    }

    public void setnro_fact(String nro_fact) {
        this.nro_fact = nro_fact;
    }

    public String getcod_chofer() {
        return cod_chofer;
    }

    public void setcod_chofer(String cod_chofer) {
        this.cod_chofer = cod_chofer;
    }




    public String getfecha() {
        return fecha;
    }

    public void setfecha(String fecha) {
        this.fecha = fecha;
    }

    public String getcod_camion() {
        return cod_camion;
    }

    public void setcod_camion(String cod_camion) {
        this.cod_camion = cod_camion;
    }


 
}
