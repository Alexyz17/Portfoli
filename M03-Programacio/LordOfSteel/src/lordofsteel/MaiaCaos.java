/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lordofsteel;

/**
 *
 * @author alex
 */
public class MaiaCaos extends Maia implements Caos {

    public MaiaCaos(String NOM, int FOR, int CON, int VEL, int INT, int SOR, Armes arma) {
        super(NOM, FOR, CON, VEL, INT, SOR, arma);
    }
    @Override
    public int atacPAReduida(Personatge personatge) {
        int paReduida = (personatge.getPA()/2);
        return paReduida;
    }
}