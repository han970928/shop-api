package com.fh.shop.admin.controller.classify;

import com.fh.shop.admin.biz.classify.IClassifyService;
import com.fh.shop.admin.common.Logs;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.classify.Classify;
import com.fh.shop.admin.vo.classify.ClassifyVo;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/classify")
public class ClassifyController {
    @Resource(name="classifyService")
    private IClassifyService classifyService;

    @RequestMapping("/toList")
    public String  toList(){
        return "/classify/list";
    }

   @RequestMapping("/queryClassifyList")
   @ResponseBody
    public ServerResponse queryClassifyList(){
       List<ClassifyVo> classifyVoList = classifyService.queryClassifyList();
       return ServerResponse.success(classifyVoList);
   }

   @RequestMapping("/add")
   @ResponseBody
   @Logs("用户新增分类")
    public ServerResponse add(Classify classify){
       classifyService.add(classify);
        return  ServerResponse.success(classify.getId());
   }

   @RequestMapping("/update")
   @ResponseBody
   @Logs("用户修改分类")
    public ServerResponse update(Classify classify){
       classifyService.update(classify);
        return  ServerResponse.success();
   }

   @RequestMapping("/delAll")
   @ResponseBody
   @Logs("用户删除分类")
   public ServerResponse delAll(@RequestParam("list[]") List<Integer> list) {
       classifyService.delAll(list);
        return ServerResponse.success();
   }

   @RequestMapping("/queryClassify")
   @ResponseBody
   //三级联动
   public ServerResponse queryClassify(Long id){
        return classifyService.queryClassify(id);
   }
}
