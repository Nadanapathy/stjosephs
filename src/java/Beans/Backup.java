/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.awt.HeadlessException;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.security.CodeSource;
import javax.swing.JOptionPane;

/**
 *
 * @author unbox
 */
public class Backup {
    public static void Backupdbtosql() {
    try {

        /*NOTE: Getting path to the Jar file being executed*/
        /*NOTE: YourImplementingClass-> replace with the class executing the code*/
        CodeSource codeSource =Backup.class.getProtectionDomain().getCodeSource();
        File jarFile = new File(codeSource.getLocation().toURI().getPath());
        String jarDir = jarFile.getParentFile().getPath();


        /*NOTE: Creating Database Constraints*/
        String dbName = db.Dbconnection.Dbname;
        String dbUser =  db.Dbconnection.Dbuser;
        String dbPass =  db.Dbconnection.Dbpass;

        /*NOTE: Creating Path Constraints for folder saving*/
        /*NOTE: Here the backup folder is created for saving inside it*/
        String folderPath = "f:"+ "\\backup";

        /*NOTE: Creating Folder if it does not exist*/
        File f1 = new File(folderPath);
        f1.mkdir();

        /*NOTE: Creating Path Constraints for backup saving*/
        /*NOTE: Here the backup is saved in a folder called backup with the name backup.sql*/
         String savePath =folderPath + "\\backup.sql\"";
           System.out.println("Save Path :"+savePath);
        /*NOTE: Used to create a cmd command*/
        String executeCmd = "C:\\xampp\\mysql\\bin\\mysqldump -u" + dbUser + " -p" + dbPass + " --database " + dbName + " -r " + savePath;

        /*NOTE: Executing the command here*/
        Process runtimeProcess = Runtime.getRuntime().exec(executeCmd);
        int processComplete = runtimeProcess.waitFor();

        /*NOTE: processComplete=0 if correctly executed, will contain other values if not*/
        if (processComplete == 0) {
            System.out.println("Backup Complete");
        } else {
            System.out.println("Backup Failure");
        }

    } catch (URISyntaxException | IOException | InterruptedException ex) {
        JOptionPane.showMessageDialog(null, "Error at Backuprestore" + ex.getMessage());
    }
}
 
    
    public static void Restoredbfromsql() {
        try {
        //    System.out.println("1");
            /*NOTE: String s is the mysql file name including the .sql in its name*/
            /*NOTE: Getting path to the Jar file being executed*/
            /*NOTE: YourImplementingClass-> replace with the class executing the code*/
            CodeSource codeSource = Backup.class.getProtectionDomain().getCodeSource();
            File jarFile = new File(codeSource.getLocation().toURI().getPath());
            String jarDir = jarFile.getParentFile().getPath();
 //System.out.println("2");
            /*NOTE: Creating Database Constraints*/
             String dbName = "college1";
        String dbUser =  "Root";
        String dbPass =  "B2lsolutions@guna";

            /*NOTE: Creating Path Constraints for restoring*/
            String restorePath = "f:\\backup\\backup.sql";

            /*NOTE: Used to create a cmd command*/
            /*NOTE: Do not create a single large string, this will cause buffer locking, use string array*/
            String[] executeCmd = new String[]{"C:\\xampp\\mysql\\bin\\mysql", dbName, "-u" + dbUser, "-p" + dbPass, "-e", " source " + restorePath};
         
      //       System.out.println("3");
            /*NOTE: processComplete=0 if correctly executed, will contain other values if not*/
            Process runtimeProcess = Runtime.getRuntime().exec(executeCmd);
            int processComplete = runtimeProcess.waitFor();
 //System.out.println("4");
            /*NOTE: processComplete=0 if correctly executed, will contain other values if not*/
            if (processComplete == 0) {
                JOptionPane.showMessageDialog(null, "Successfully restored from SQL : " + restorePath);
            } else {
                JOptionPane.showMessageDialog(null, "Error at restoring");
            }


        } catch (URISyntaxException | IOException | InterruptedException | HeadlessException ex) {
            JOptionPane.showMessageDialog(null, "Error at Restoredbfromsql" + ex.getMessage());
        }

    }


        
    public static void main(String[] args) {
     //   Backup.Backupdbtosql();
        Backup.Restoredbfromsql();
        
    }

}
