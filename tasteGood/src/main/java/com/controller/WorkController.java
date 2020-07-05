package com.controller;

import com.domain.Menu;
import com.domain.Works;
import com.service.WorksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/work")
public class WorkController {

    @Autowired
    private WorksService worksService;

    @RequestMapping("/addWork")
    public String addWork(@RequestParam("menuId")Integer menuId, @RequestParam("menuName")String menuName,Model model){
        model.addAttribute("menuId",menuId);
        model.addAttribute("menuName",menuName);
        return "addWork";
    }

    @RequestMapping("/saveWork")
    @ResponseBody
    public void saveWork(Works works, HttpServletResponse response, HttpServletRequest request) throws Exception{
        works.setLikes(0);
        HttpSession session=request.getSession();//获取用户id
        Integer uid=(Integer)session.getAttribute("userId");
        works.setUserId(uid);
        Date time=new Date();
        works.setWorkTime(time);
        worksService.saveWorks(works);
        response.sendRedirect(request.getContextPath()+"/userInfo/homePage");
    }

    //根据用户id查询用户作品
    @RequestMapping("/userWorks")
    public String userWorks(Model model,HttpServletRequest request,HttpServletResponse response){
        HttpSession session=request.getSession();
        Integer uid=(int)session.getAttribute("userId");
        List<Works> works=worksService.findWorksByUserId(uid);
        model.addAttribute("userWorks",works);
        return "userWorks";
    }

    //根据workId查询作品，跳到修改页面
    @RequestMapping("/modifyWork")
    public String modifyWork(@RequestParam("workId")Integer workId,Model model){
        Works work=worksService.findWorksByWorkId(workId);
        model.addAttribute("work",work);
        return "modifyWork";
    }

    //用户更新作品信息
    @RequestMapping("/updateWork")
    public void updateWork(Works works,HttpServletResponse response, HttpServletRequest request)throws Exception{
        String summary=works.getSummary();
        String workPhoto=works.getWorkPhoto();
        Integer workId=works.getWorkId();
        Date workTime=new Date();
        worksService.updateWork(workPhoto,summary,workId,workTime);
        response.sendRedirect(request.getContextPath()+"/userInfo/homePage");
    }

    //根据workId查询作品
    @RequestMapping("/getWork")
    @ResponseBody
    public Works getWork(@RequestParam("workId") Integer workId){
        Works work=worksService.findWorksByWorkId(workId);
        return work;
    }

    //作品模块看作品
    @RequestMapping("/showWorks")
    public String showWorks(Model model){
        List<Works> works=worksService.showWorks();
        model.addAttribute("works",works);
        return "showWorks";
    }

}
