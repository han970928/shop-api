package com.fh.shop.admin.utils;

import redis.clients.jedis.Jedis;

public class RedisUtil {

    //设置值
    public static void set(String key,String value){
        Jedis jedis=null;
        try {
             jedis = RedisPool.getJedisPool();
             jedis.set(key, value);
        } catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
        } finally {
            if(jedis!=null){
                jedis.close();
            }
        }
    }

    //获取值
    public static String get(String key){
        Jedis jedis=null;
        String s=null;
        try {
            jedis = RedisPool.getJedisPool();
            s = jedis.get(key);
        } catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
        } finally {
            if(jedis!=null){
                jedis.close();
            }
        }
        return s;
    }

    // 删除值，清空redis 缓存中的值
    public static  void del(String key){
        Jedis jedis =null;
        try {
             jedis = RedisPool.getJedisPool();
             jedis.del(key);
        } catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
        } finally {
            if(jedis!=null){
                jedis.close();
            }
        }
    }

    //存活时间
    public static void setSeconds(String key,int seconds){
        Jedis jedis =null;
        try {
            jedis = RedisPool.getJedisPool();
            jedis.expire(key,seconds);
        } catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
        } finally {
            if(jedis!=null){
                jedis.close();
            }
        }
    }

    public static void setEx(String key,int miao,String value){
        Jedis jedis =null;
        try {
            jedis = RedisPool.getJedisPool();
            jedis.setex(key,miao,value);
        } catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
        } finally {
            if(jedis!=null){
                jedis.close();
            }
        }

    }
}
