package com.controller;

import com.domain.Menu;
import com.domain.UserInfo;
import com.domain.Works;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.UserInfoService;
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

    @Autowired
    private UserInfoService userInfoService;

    @RequestMapping("/addWork")
    public String addWork(@RequestParam("menuId")Integer menuId, @RequestParam("menuName")String menuName,Model model){
        model.addAttribute("menuId",menuId);
        model.addAttribute("menuName",menuName);
        List<Works> works=worksService.recommendWork();
        model.addAttribute("works",works);
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
    public String userWorks(@RequestParam("userId")Integer userId,Model model,HttpServletRequest request,@RequestParam("page") Integer page,@RequestParam("size") Integer size){
        Integer follow=userInfoService.countFollow(userId);
        Integer followed=userInfoService.countFollowed(userId);
        model.addAttribute("follow",follow);
        model.addAttribute("followed",followed);
        HttpSession session=request.getSession();
        Integer myUserId=(int)session.getAttribute("userId");//自己的
        model.addAttribute("myUserId",myUserId);
        List<Works> works=worksService.findWorksByUserId(userId,page,size);
        PageInfo<Works> pageInfo=new PageInfo<>(works);
        model.addAttribute("pageInfo",pageInfo);
        UserInfo userInfo=userInfoService.findUserById(userId);
        model.addAttribute("userInfo",userInfo);
        return "userWorks";
    }

    //根据workId查询作品，跳到修改页面
    @RequestMapping("/modifyWork")
    public String modifyWork(@RequestParam("workId")Integer workId,Model model){
        Works work=worksService.findWorksByWorkId(workId);
        model.addAttribute("work",work);
        List<Works> works=worksService.recommendWork();
        model.addAttribute("works",works);
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
        return worksService.findWorksByWorkId(workId);
    }

    //作品模块看作品
    @RequestMapping("/showWorks")
    public String showWorks(Model model,@RequestParam("page") Integer page,@RequestParam("size") Integer size){
        List<Works> works=worksService.showWorks(page,size);
        PageInfo<Works> pageInfo=new PageInfo<>(works);
        model.addAttribute("pageInfo",pageInfo);
        return "showWorks";
    }

    //删除作品
    @RequestMapping("/deleteWork")
    @ResponseBody
    public String deleteWork(@RequestParam("workId") Integer workId){
        System.out.println(workId);
        worksService.deleteWork(workId);
        return "200";
    }

    //点赞+1
    @RequestMapping("/addLikes")
    @ResponseBody
    public String addLikes(@RequestParam("workId") Integer workId){
        Works work=worksService.findWorksByWorkId(workId);
        Integer likes=work.getLikes()+1;
        worksService.addLikes(workId,likes);
        return "200";
    }
}
