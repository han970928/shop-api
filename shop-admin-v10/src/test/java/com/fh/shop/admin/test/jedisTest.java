package com.fh.shop.admin.test;

import org.junit.Test;
import redis.clients.jedis.Jedis;

public class jedisTest {
    @Test
    public void testJedis(){
                // 连接本地的 Redis 服务
                 Jedis jedis = new Jedis("192.168.42.135",7020);
                //set值
                jedis.set("111", "111");
                 //get值
                 String simayi = jedis.get("simayi");
                 System.out.println("司马懿的值：" + simayi);
                 System.out.println("连接本地的 Redis 服务成功！");
                 /*释放资源*/
                jedis.close();
             }
}
