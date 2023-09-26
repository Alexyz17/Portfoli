/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lordofsteel;

/**
 *
 * @author alex
 */
public abstract class MitjaCaos extends Mitja implements Caos {

    public MitjaCaos(String NOM, int FOR, int CON, int VEL, int INT, int SOR, Armes arma) {
        super(NOM, FOR, CON, VEL, INT, SOR, arma);
    }

    public int atacPAReduida(Personatge personatge) {
        int paReduida = (personatge.getPA()/2);
        return paReduida;
    }

}