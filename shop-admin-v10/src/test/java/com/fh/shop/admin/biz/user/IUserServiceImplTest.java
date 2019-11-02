package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.param.user.UserSearch;
import com.fh.shop.admin.po.user.UserPo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-common.xml"})
public class IUserServiceImplTest extends AbstractJUnit4SpringContextTests {

    @Resource(name="userService")
    private IUserService userService;

    @Test
    public void add(){
        UserPo user=new UserPo();
        user.setUserName("卤蛋");
        user.setAge(18);
        user.setPhone("13838814438");
        user.setSex(1);
        user.setEmail("836756848@qq.com");
        user.setRoleids("1,2,3");
        userService.add(user);
    }
    @Test
    public void del(){
        userService.del(162);
    }
    @Test
    public void update(){
        UserPo user=new UserPo();
        user.setUserName("卤蛋");
        user.setAge(18);
        user.setPhone("13838814438");
        user.setSex(1);
        user.setEmail("836756848@qq.com");
        user.setRoleids("3,4,5");
        user.setId(159L);
        userService.update(user);
    }
    @Test
    public void queryUserList(){
        UserSearch userSearch=new UserSearch();
        userSearch.setDraw(1);
        userSearch.setStart(1);
        userSearch.setLength(3);
        DateTable dateTable = userService.queryUserList(userSearch);
        System.out.println(dateTable);
    }
}
