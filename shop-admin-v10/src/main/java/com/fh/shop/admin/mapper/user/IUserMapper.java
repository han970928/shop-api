package com.fh.shop.admin.mapper.user;

import com.fh.shop.admin.param.user.UserPassword;
import com.fh.shop.admin.param.user.UserSearch;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.po.user.UserPo;
import com.fh.shop.admin.po.user.UserRole;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface IUserMapper {

    Integer queryUserCount(UserSearch userSearch);

    List<UserPo> queryUserList(UserSearch userSearch);

    void add(UserPo userPo);

    void del(long id);

    UserPo toupdate(long id);

    void update(UserPo userPo);

    void addUserRole(UserRole userRole);

    List<String> queryUserRoleName(Long id);

    List<Integer> queryUserRoleIds(long id);

    void delete(Long id);

    void delAll(List<Integer> list);

    void delUserRole(List<Integer> list);

    UserPo queryUserByName(String userName);

    List<UserPo> queryUserExcel(UserSearch userSearch);

    void updateLoginDate(@Param("id") Long id,@Param("data") Date date);

    void updateTocount(Long id);

    void initCount(Long id);

    void initerrorCount(Long id);

    void updateErrorDateAndErrorCount(@Param("date")Date date,@Param("id")Long id);

    void updateErrorCount(@Param("date")Date date,@Param("id") Long id,@Param("errorCount") Integer errorCount);

    void updatePassword(UserPassword userPassword);

    void resetPassword(@Param("password")String password,@Param("id") Long id);

    UserPo forGetPassword(String email);
}
