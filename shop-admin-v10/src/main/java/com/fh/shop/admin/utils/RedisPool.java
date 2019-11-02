package com.fh.shop.admin.utils;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisPool {
    // 私有化方法
    private RedisPool(){};

    // 创建 配置文件对象的实例
    private static   JedisPool jedisPool;

    private static void jedisResources(){
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        // 设置最大空闲时间
        jedisPoolConfig.setMaxIdle(100);
        // 设置最小空闲时间
        jedisPoolConfig.setMinIdle(100);
        // 设置最大连接数
        jedisPoolConfig .setMaxTotal(1000);
        // 查看是否和 jidis  连接成功
        jedisPoolConfig.setTestOnReturn(true);
        jedisPoolConfig.setTestOnBorrow(true);
        // 设置Ip地址  端口号
        jedisPool = new JedisPool(jedisPoolConfig,"192.168.42.135", 7020);
    }

    //静态代码块，类加载，加载配置文件，只加载一次
    static{
        jedisResources();
    }

    public static Jedis getJedisPool(){
        return jedisPool.getResource();
    }
}
