package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.user.UserPassword;
import com.fh.shop.admin.param.user.UserSearch;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.po.user.UserPo;
import com.fh.shop.admin.vo.user.UserVo;

import java.util.Date;
import java.util.List;

public interface IUserService {


    DateTable queryUserList(UserSearch userSearch);

    void add(UserPo userPo);

    void del(long id) ;

    UserVo toupdate(long id);

    void update(UserPo userPo);

    void delAll(List<Integer> list);

    UserPo queryUserByName(String userName);

    List<UserPo> queryUserExcel(UserSearch userSearch);

    void updateLoginDate(Long id, Date date);

    void updateTocount(Long id);

    void initCount(Long id);


    void initerrorCount(Long id);

    void updateErrorDateAndErrorCount(Date date, Long id);

    void updateErrorCount(Date date, Long id, Integer errorCount);

    ServerResponse updatePassword(UserPassword userPassword);

    ServerResponse resetPassword(Long id);

    ServerResponse forGetPassword(String email);
}