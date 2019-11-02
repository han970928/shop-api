package com.fh.shop.admin.controller.user;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.biz.menu.IMenuService;
import com.fh.shop.admin.biz.user.IUserService;
import com.fh.shop.admin.common.*;
import com.fh.shop.admin.param.user.UserPassword;
import com.fh.shop.admin.param.user.UserSearch;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.po.user.UserPo;
import com.fh.shop.admin.utils.*;
import com.fh.shop.admin.vo.user.UserVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {
    @Resource(name="userService")
    private IUserService userService;
    @Resource(name="menuService")
    private IMenuService menuService;
    @Autowired
    private HttpServletRequest request;
    @Resource
    private HttpServletResponse response;


    @RequestMapping("/toList")
    public String toList(){
        return "/user/list";
    }

    @RequestMapping("/add")
    @ResponseBody
    @Logs("用户增加")
    public ServerResponse add(UserPo userPo){
            userService.add(userPo);
            return  ServerResponse.success();
    }

    @RequestMapping("/queryUserList")
    @ResponseBody
    public ServerResponse queryUserList(UserSearch userSearch){
        DateTable dateTable = userService.queryUserList(userSearch);
        return ServerResponse.success(dateTable);
    }

    @RequestMapping("/del")
    @ResponseBody
    @Logs("用户删除")
    public ServerResponse del(long id) {
            userService.del(id);
           return ServerResponse.success();
    }

    @RequestMapping("/toupdate")
    @ResponseBody
    public ServerResponse toupdate(long id){
            UserVo user=userService.toupdate(id);
            return ServerResponse.success(user);
    }

    @RequestMapping("/update")
    @ResponseBody
    @Logs("用户修改")
    public ServerResponse update(UserPo userPo){
            UserPo userByName = userService.queryUserByName(userPo.getUserName());
            userPo.setSalt(userByName.getSalt());
            if(!userPo.getPassword().equals(userByName.getPassword())){
                String uuid = UUID.randomUUID().toString();
                userPo.setSalt(uuid);
                userPo.setPassword(Md5Util.md5(Md5Util.md5(userPo.getPassword())+uuid));
            }
            userService.update(userPo);
           return ServerResponse.success();
    }

    @RequestMapping("/delAll")
    @ResponseBody
    @Logs("用户批量删除")
    public ServerResponse delAll(@RequestParam("list[]") List<Integer> list){
            userService.delAll(list);
          return ServerResponse.success();
    }

    @RequestMapping("/login")
    @ResponseBody
    @Logs("用户登陆")
    public ServerResponse login(UserPo userPo){
        String userName = userPo.getUserName();
        String password = userPo.getPassword();
        String imgCode = userPo.getImgCode();
        // 方向判断 // 为空返回
        if(StringUtils.isEmpty(userName) || StringUtils.isEmpty(password) || StringUtils.isEmpty(imgCode)){
            return ServerResponse.error(ResponseEnum.USERNAME_PASSWORD_IS_NULL);
        }
        //String sessionImgCode = (String) request.getSession().getAttribute("checkcode");
        String sessionId = DistributedSession.getSession(request, response);
        String sessionCode = RedisUtil.get(KeyUtil.buildCodeKey(sessionId));

        if(!imgCode.equalsIgnoreCase(sessionCode)){
            return ServerResponse.error(ResponseEnum.IMG_ERROR);
        }
        UserPo name=userService.queryUserByName(userName);
        //判断名字是否存在
        if(name == null){
            return ServerResponse.error(ResponseEnum.USERNAME_IS_ERROR);
        }
        //判断密码错误次数
        if(name.getErrorCount()==SystemConstant.USER_SUO){
            //上次错误时间
            Date ErrorDate = DateAndString.string2Date(DateAndString.date2String(name.getErrorDate(), DateAndString.Y_M_D), DateAndString.Y_M_D);
            //当前时间
            Date newDate = DateAndString.string2Date(DateAndString.date2String(new Date(), DateAndString.Y_M_D), DateAndString.Y_M_D);
            //之后代表是新的一天
            if(newDate.after(ErrorDate)){
                //初始为1
                userService.initerrorCount(name.getId());
            }else{
                //还是当天
                return ServerResponse.error(ResponseEnum.USERNAME_IS_SUO);
            }
        }
        String salt = name.getSalt();
        //判断密码是否正确
        if(!name.getPassword().equals(Md5Util.buildMd5(password,salt))){
            //如果上次没有错误时间， 就给一个第一次错误时间
            if(name.getErrorDate()==null){
                userService.updateErrorDateAndErrorCount(new Date(),name.getId());
            }else{
                Date ErrorDate = DateAndString.string2Date(DateAndString.date2String(name.getErrorDate(), DateAndString.Y_M_D), DateAndString.Y_M_D);
                Date newDate = DateAndString.string2Date(DateAndString.date2String(new Date(), DateAndString.Y_M_D), DateAndString.Y_M_D);
                //判断当前时间在不在上次错误时间之后
                if(newDate.after(ErrorDate)){
                    //将错误时间修改成这次的时间，错误次数至为1
                    userService.updateErrorCount(new Date(),name.getId(),name.getErrorCount());
                    name.setErrorCount(1);
                }else{
                    userService.updateErrorDateAndErrorCount(new Date(),name.getId());
                    name.setErrorCount(name.getErrorCount()+1);
                }
                if(name.getErrorCount()==SystemConstant.USER_SUO){
                    MailUtil.bulidMail("账户非法登录","您的账号存在安全隐患，如非您本人操作，请立即修改密码",name.getEmail());
                }
            }
            return ServerResponse.error(ResponseEnum.PASSWORD_ID_ERROR);
        }
        //如果上次登录的时间为空，说明是第一次登录，就给一个初始值
        if(name.getLoginDate()==null){
            //初始化第一次登录
            userService.initCount(name.getId());
            //页面展示的
            name.setTocount(1);
        }else{
            //获取到当前登录时间 转换成 日期格式的 年月日格式
            Date newDate = DateAndString.string2Date(DateAndString.date2String(new Date(), DateAndString.Y_M_D), DateAndString.Y_M_D);
            //获取用户上一次登录的时间
            Date loginDate = DateAndString.string2Date(DateAndString.date2String(name.getLoginDate(), DateAndString.Y_M_D), DateAndString.Y_M_D);
            // 看当前时间是不是在上次登录时间之后，不如是，则是第二天，然后重新初始化
            if(newDate.after(loginDate)){
                userService.initCount(name.getId());
                name.setTocount(1);
            }else{
                // 如果不是在上次登录时间之后，就代表还是在当天，然后将登录次数加一
                userService.updateTocount(name.getId());
                name.setTocount(name.getTocount()+1);
            }
        }
        //登陆成功将错误次数至为0
        userService.initerrorCount(name.getId());
        //查询当前登陆的用户所拥有的所有菜单
        List<Menu> userMenuList=menuService.queryUserMenuList(name.getId());
        //查询当前登陆的用户所拥有的菜单资源
        List<Menu> menuList=menuService.queryMenuListByUserId(name.getId());
        //查询菜单列表
        List<Menu> menuListAll=menuService.findMenuListAll();

        //查询当前登陆的用户所拥有的所有菜单
        //request.getSession().setAttribute(SystemConstant.USER_MENU_LIST,userMenuList);
        String userMenuListJson = JSONObject.toJSONString(userMenuList);
        RedisUtil.setEx(KeyUtil.buildMenuKey(sessionId),SystemConstant.USER_EXPIRE,userMenuListJson);

        //根据当前登陆的用户Id 查询 用户对应的菜单，用户找角色，角色找菜单， 返回菜单集合
        //request.getSession().setAttribute(SystemConstant.MENU_LIST_BY_USER,menuList);
        String menuListJson = JSONObject.toJSONString(menuList);
        RedisUtil.setEx(KeyUtil.buildUserMenuListKey(sessionId),SystemConstant.USER_EXPIRE,menuListJson );

        //查询菜单列表
        // request.getSession().setAttribute(SystemConstant.MENU_ALL,menuListAll);
        String menuListAllJson = JSONObject.toJSONString(menuListAll);
        RedisUtil.setEx(KeyUtil.buildMenuListAllKey(sessionId),SystemConstant.USER_EXPIRE,menuListAllJson );

        //当前登陆成功的用户
        //request.getSession().setAttribute(SystemConstant.CURRENT_NAME,name);
        String nameJson = JSONObject.toJSONString(name);
        RedisUtil.setEx(KeyUtil.buildUserKey(sessionId),SystemConstant.USER_EXPIRE,nameJson);
        // 如果用户之前未登录过，则记录此次登录的时间，页面展示的是从session里面拿到的空数据，前台进行判断
        userService.updateLoginDate(name.getId(),new Date());
        return ServerResponse.success();
    }

    @RequestMapping("/loginOut")
    @Logs("用户退出")
    public String loginOut(){
        //request.getSession().invalidate();
        String sessionId = DistributedSession.getSession(request, response);
        RedisUtil.del(KeyUtil.buildUserKey(sessionId));
        RedisUtil.del(KeyUtil.buildMenuKey(sessionId));
        RedisUtil.del(KeyUtil.buildMenuListAllKey(sessionId));
        RedisUtil.del(KeyUtil.buildUserMenuListKey(sessionId));
        return "redirect:/indexTwo.jsp";
    }

    @RequestMapping("/downExcel")
    @Logs("用户下载downExcel")
    public void downExcel(UserSearch userSearch, HttpServletResponse response){
        //获取数据
        List<UserPo> userPoList = userService.queryUserExcel(userSearch);
        //创建操作对象
        String[] heads={"账户名称","真实姓名","用户年龄","邮箱地址","用户性别","手机号码","入职时间","用户薪资","所属地区"};
        String[] propes={"userName","roleName","age","email","sex","phone","hiredate","compensation","areaName",};
        XSSFWorkbook xssfWorkbook = ExcelUtil.downExcels("用户", heads, userPoList, propes, UserPo.class);
        //进行下载
        FileUtil.excelDownload(xssfWorkbook,response);
    }

    @RequestMapping("/uploadFile")
    public void uploadFile(HttpServletRequest request, @RequestParam("imgss") CommonsMultipartFile file, HttpServletResponse response) throws IOException {
        String realPath = request.getServletContext().getRealPath("/");
        String imgDir=realPath+"/imgs";
        File f=new File(imgDir);
        if(!f.exists()){//不存在就创建
            f.mkdirs();
        }
        //获取上传的文件名
        String filename = file.getOriginalFilename();
        int indexOf = filename.lastIndexOf(".");
        String string = filename.substring(indexOf);
        String uuid = UUID.randomUUID().toString();
        String newName=uuid+string;
        //将上传的文件  拷贝到指定位置  transferTo转换成file
        file.transferTo(new File(imgDir+"/"+newName));
        Map<String, Object> map=new HashMap<String, Object>();
        map.put("imgs", "/imgs/"+newName);
        String jsonString = JSONObject.toJSONString(map);
        response.setCharacterEncoding("utf-8");
        //表示响应的内容区数据的媒体类型为json格式
        response.setContentType("application/json");
        PrintWriter writer = response.getWriter();
        writer.write(jsonString);
        writer.close();
    }

    @RequestMapping("/updateSuo")
    @ResponseBody
    @Logs("解锁用户")
    public ServerResponse updateSuo(Long id){
        userService.initerrorCount(id);
        return ServerResponse.success();
    }

    @RequestMapping("/toUpdatePassword")
    public String toUpdatePassword(){
        return "/user/updatePassword";
    }

    @RequestMapping("/updatePassword")
    @ResponseBody
    @Logs("用户修改密码")
    public ServerResponse updatePassword(UserPassword userPassword){
        return  userService.updatePassword(userPassword);
    }

    @RequestMapping("/resetPassword")
    @ResponseBody
    @Logs("用户重置密码")
    public ServerResponse resetPassword(Long id){
        return  userService.resetPassword(id);
    }

    @RequestMapping("/forGetPassword")
    @ResponseBody
    @Logs("修改忘记密码")
    public ServerResponse forGetPassword(String email){
        return  userService.forGetPassword(email);
    }


    @RequestMapping("/initTop")
    @ResponseBody
    //导航条展示
    public ServerResponse initTop(){
        String sessionId = DistributedSession.getSession(request, response);
        String userJson= RedisUtil.get(KeyUtil.buildUserKey(sessionId));
        UserPo userPo = JSONObject.parseObject(userJson, UserPo.class);
        userPo.setLoginDateString(DateAndString.date2String(userPo.getLoginDate(),DateAndString.Y_M_D_H_M_S));
        return  ServerResponse.success(userPo);
    }
}

