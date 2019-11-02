package com.fh.shop.admin.test;

import org.junit.Test;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class FeiBotest {
    public static void main(String[] args) {
        System.out.println(test1(5));
        System.out.println(test2(5));
        System.out.println(test3(5));
    }
    public static   int test1(int n){
        if(n==1){
            return 1;
        }else{
            return n * test1( n - 1);
        }
    }
    public static long test2(long n){
        if(n <= 0) {
            return 0;
        } else if(1 == n) {
            return 1;
        } else{
            return  n * test2(n - 1);
        }
    }
    public static long test3(int n){
        if(n==1||n==2){
            return 1;
        }
        return  test3(n-1)+test3(n-2);
    }
    @Test
    public void test4(){
        Map<String,String> map=new HashMap<>();
        map.put("name","漳卅");
        map.put("age","12");
        map.put("sex","男");
        Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
        while (iterator.hasNext()){
            Map.Entry<String, String> next = iterator.next();
            System.out.println(next.getKey()+":::"+next.getValue());
        }
    }
}
