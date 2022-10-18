package jee.support.wx;

import java.io.File;

public class SimpleTest {
    public static void main(String[] args) {
        String str = "1122332211";
        if(check(str)){
            System.out.println("是回文");
        }else{
            System.out.println("不是回文");
        }
    }

    public static boolean check(String str){
        //charAt实现
        for(int i=0;i<str.length()/2;i++){
            if(str.charAt(i)!=str.charAt(str.length()-1-i)){
                return false;
            }
        }
        return true;

    }
}
