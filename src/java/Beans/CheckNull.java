/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

/**
 *
 * @author B2L PC
 */
public class CheckNull {
    public static boolean isNull(String value){
        boolean isnull;
        
        try{
            if(value.length()>0){
                isnull=false;
            }else{
                isnull=true;
            }
        }catch(NullPointerException ne){
            isnull=true;
        }
        
        return isnull;
    }
    
//  public static manageNullValues(){
//      
//  }  
}
