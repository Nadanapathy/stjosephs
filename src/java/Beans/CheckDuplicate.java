/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeSet;

/**
 *
 * @author UnboxMovie
 */
public class CheckDuplicate {
    
    public static String[] removeAndSetFirst(String[] data,String firststring) {
      
        
      
        ArrayList a=new ArrayList();
        for(String tmp:data){
            a.add(tmp);
        }
        
       // System.out.println(ts);
        a.remove(firststring);
        
        String ss[]=new String[a.size()+1];
        
        Iterator it=a.iterator();
        
        ss[0]=firststring;
        // System.out.println(ss[0]);
         
       for(int i=1;it.hasNext();i++){
            ss[i]=it.next().toString();
         //  System.out.println(ss[i]);
        }
       
//       for(String tmp:ss){
//           System.out.println(tmp);
//       }
       
       return ss;
    }
    
    public static void main(String[] args) {
        String[] s=new String[]{"hi","hello","how","Are","your","Are","Are"};
        
        String[] c=CheckDuplicate.removeAndSetFirst(s, "Are");
        for(String ss:c){
            System.out.println(ss);
        }
    }
   
}
