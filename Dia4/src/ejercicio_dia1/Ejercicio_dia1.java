/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package ejercicio_dia1;

import com.sun.jdi.connect.spi.Connection;
import java.sql.Statement;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author camper
 */
public class Ejercicio_dia1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       
        Conexion con;
        try{
            con = new Conexion();
            Statement st;
            ResultSet rs;
            try {
                
                st = con.connection.createStatement();
                rs = st.executeQuery("select marca from vehiculo where id = 0;");
                        while (rs.next()) {
                            System.out.println("Marca: " + rs.getString("marca"));
                            System.out.println("-------------------------");
                        }

            } catch (SQLException e) {
                    e.printStackTrace();
                }
        } catch(IOException s){
            s.printStackTrace();
        }
            
    }
}