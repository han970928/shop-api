package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.ResponseEnum;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.common.SystemConstant;
import com.fh.shop.admin.mapper.user.IUserMapper;
import com.fh.shop.admin.param.user.UserPassword;
import com.fh.shop.admin.param.user.UserSearch;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.po.user.UserPo;
import com.fh.shop.admin.po.user.UserRole;
import com.fh.shop.admin.utils.DateAndString;
import com.fh.shop.admin.utils.MailUtil;
import com.fh.shop.admin.utils.Md5Util;
import com.fh.shop.admin.vo.user.UserVo;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service("userService")
public class IUserServiceImpl implements IUserService {
    @Autowired
    private IUserMapper userMapper;


    @Override// 列表的名字展示
    public DateTable queryUserList(UserSearch userSearch) {
        //复选的条件查询
        queryUserSearch(userSearch);

        //查询总条数
        Integer count = userMapper.queryUserCount(userSearch);

        //po 转vo
        List<UserPo>  userPoList=userMapper.queryUserList(userSearch);
        List<UserVo> userVoList = po2vo(userPoList);
        DateTable dateTable=new DateTable(userSearch.getDraw(),count,count,userVoList);
        return dateTable;
    }

    private List<UserVo> po2vo(List<UserPo> userPoList) {
        List<UserVo>  userVoList=new ArrayList<>();
        for (UserPo u : userPoList) {
            UserVo userVo = getUserVo(u);
            List<String> userRoleName=userMapper.queryUserRoleName(u.getId());
            if(userRoleName.size() > 0){
               String roleName=StringUtils.join(userRoleName,",");
               userVo.setRoleNames(roleName);
            }
            userVoList.add(userVo);
        }
        return userVoList;
    }

    //复选框的条件查询
    private void queryUserSearch(UserSearch userSearch) {
        String roleIds = userSearch.getRoleIds();
        List<Integer> roleList=new ArrayList<>();
        if(StringUtils.isNoneEmpty(roleIds)){
            String[] roleStrIds = roleIds.split(",");
            for (String roleStrId : roleStrIds) {
                roleList.add(Integer.parseInt(roleStrId));
            }
            userSearch.setRoleList(roleList);
            userSearch.setRoleSize(roleList.size());
        }
    }
    //po 转 vo
    private UserVo getUserVo(UserPo u) {
        UserVo userVo=new UserVo();
        userVo.setId(u.getId());
        userVo.setAge(u.getAge());
        userVo.setEmail(u.getEmail());
        userVo.setPhone(u.getPhone());
        userVo.setRoleName(u.getRoleName());
        userVo.setUserName(u.getUserName());
        userVo.setSex(u.getSex());
        userVo.setCompensation(u.getCompensation().toString());
        userVo.setHiredate(DateAndString.date2String(u.getHiredate(),DateAndString.Y_M_D));
        userVo.setImgFilePath(u.getImgFilePath());
        userVo.setSalt(u.getSalt());
        userVo.setSuo(u.getErrorCount()==SystemConstant.USER_SUO);
        userVo.setAreaName(u.getAreaName());
        return userVo;
    }

    @Override
    public void add(UserPo userPo){
        String uuid = UUID.randomUUID().toString();
        userPo.setSalt(uuid);
        userPo.setPassword(Md5Util.md5(Md5Util.md5(userPo.getPassword())+uuid));
        //添加用户信息
        userMapper.add(userPo);
        // 添加用户和角色之间的关联关系
        userByRole(userPo);
    }

    //增加用户权限
    private void userByRole(UserPo userPo) {
        Long userPoId = userPo.getId();
        String roleids = userPo.getRoleids();
        String[] ids = roleids.split(",");
        if(StringUtils.isNoneEmpty(ids)){
            for (String id : ids) {
                UserRole userRole=new  UserRole();
                userRole.setUserId(userPoId);
                userRole.setRoleId(Long.parseLong(id));
                userMapper.addUserRole(userRole);
            }
        }
    }

    @Override
    public void del(long id)  {
        userMapper.delete(id);
        userMapper.del(id);
    }

    @Override
    public UserVo toupdate(long id) {
        UserPo toupdate = userMapper.toupdate(id);
        UserVo userVo = getUserVo(toupdate);
        userVo.setPassword(toupdate.getPassword());
        userVo.setAreaName(toupdate.getAreaName());
        List<Integer>  roleids=userMapper.queryUserRoleIds(id);
        userVo.setRoleIds(roleids);
        return userVo;
    }

    @Override
    public void update(UserPo userPo) {
        userMapper.delete(userPo.getId());
        userByRole(userPo);
        userMapper.update(userPo);
    }

    @Override
    public void delAll(List<Integer> list) {
        userMapper.delAll(list);
        userMapper.delUserRole(list);
    }

    @Override
    public UserPo queryUserByName(String userName) {
        return userMapper.queryUserByName(userName);
    }


    @Override
    public List<UserPo> queryUserExcel(UserSearch userSearch) {
        return userMapper.queryUserExcel(userSearch);
    }

    @Override
    public void updateLoginDate(Long id, Date date) {
        userMapper.updateLoginDate(id,date);
    }

    @Override
    public void updateTocount(Long id) {
        userMapper.updateTocount(id);
    }

    @Override
    public void initCount(Long id) {
        userMapper.initCount(id);
    }

    @Override
    public void initerrorCount(Long id) {
        userMapper.initerrorCount(id);
    }

    @Override
    public void updateErrorDateAndErrorCount(Date date, Long id) {
        userMapper.updateErrorDateAndErrorCount(date,id);
    }

    @Override
    public void updateErrorCount(Date date, Long id, Integer errorCount) {
        userMapper.updateErrorCount(date,id,errorCount);
    }

    @Override
    public ServerResponse updatePassword(UserPassword userPassword) {
        // 先判断前台密码都不为空
        if( StringUtils.isEmpty(userPassword.getOldPassword()) ||  StringUtils.isEmpty(userPassword.getNewPassword()) ||  StringUtils.isEmpty(userPassword.getConfirmPassword())){
            return ServerResponse.error(ResponseEnum.USER_PASSWORD_NULL);
        }
        //判断新密码和确定密码是否一致
        if(!userPassword.getNewPassword().equals(userPassword.getConfirmPassword())){
            return ServerResponse.error(ResponseEnum.USER_PASSWORD_NEW_CONFIRM_NO);
        }
        //根据此用户查询出数据库的密码
        UserPo userPo = userMapper.toupdate(userPassword.getUserId());
        String passwordPo = userPo.getPassword();
        String salt = userPo.getSalt();
        //判断原密码是否一致
        String newPassword = Md5Util.buildMd5(userPassword.getOldPassword(), salt);
        if(!passwordPo.equals(newPassword)){
            return ServerResponse.error(ResponseEnum.USER_OLDPASSWORD_ERROR);
        }
        //将新密码进行加密
        userPassword.setNewPassword( Md5Util.buildMd5(userPassword.getNewPassword(), salt));
        userMapper.updatePassword(userPassword);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse resetPassword(Long id) {
        UserPo userPo = userMapper.toupdate(id);
        if(userPo ==null){
            return ServerResponse.error(ResponseEnum.USERNAME_IS_ERROR);
        }
        String salt = userPo.getSalt();
        String password = Md5Util.buildMd5(SystemConstant.RESETPASSWORD, salt);
        userMapper.resetPassword(password,id);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse forGetPassword(String email) {
        UserPo userPo = userMapper.forGetPassword(email);
        if(userPo==null){
            return ServerResponse.error(ResponseEnum.USEREMAIL_IS_ERROR);
        }
        //生成一个字母，数字的随机数
        String randomAlphabetic = RandomStringUtils.randomAlphabetic(6);
        String salt = userPo.getSalt();
        //将新密码进行加密，保存到数据库
        String buildMd5 = Md5Util.buildMd5(randomAlphabetic, salt);
        //进行修改
        userMapper.resetPassword(buildMd5,userPo.getId());
        //发送邮件
        MailUtil.bulidMail("修改密码成功","新密码为"+randomAlphabetic,userPo.getEmail());
        return ServerResponse.success();
    }


}
