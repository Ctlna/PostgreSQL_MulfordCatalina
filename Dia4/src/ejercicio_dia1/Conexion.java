/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ejercicio_dia1;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author camper
 */
public class Conexion {
    
    public Connection connection;

    public Conexion() throws IOException {
        
        Properties properties = new Properties();
        
        try (InputStream input = new FileInputStream("src/Properties.properties")) {
            
            if(input == null){
                throw new IllegalStateException("Archivo no existente :(");
            }
            
            properties.load(input);
            String usuario = properties.getProperty("user");
            String clavezita = properties.getProperty("password");

                
            String url = "jdbc:postgresql://172.16.101.149/campusCars?user="+usuario+"&password="+clavezita;
                
            Class.forName("org.postgresql.Driver");
                
            System.out.println("Conexión establecida con PostgreSQL");
                
            connection = DriverManager.getConnection(url);
                
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}