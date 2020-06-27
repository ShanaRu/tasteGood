package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/images")
public class ImagesController {

    @RequestMapping("/upload")
    @ResponseBody
    public Map<String, Object> upload(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        Map<String,Object> map=new HashMap<>();
        if(file.isEmpty()){
            System.out.println("文件为空");
            map.put("code",500);
            map.put("msg","");
        }
        System.out.println("springmvc文件上传...");
        String path = request.getSession().getServletContext().getRealPath("/picture/");
        File files=new File(path);
        if(!files.exists()){
            // 创建该文件夹
            files.mkdirs();
        }
        //改文件名
        String filename = file.getOriginalFilename();
        // 把文件的名称设置唯一值，uuid
        String uuid = UUID.randomUUID().toString().replace("-", "");
        filename = uuid+"_"+filename;
        // 完成文件上传
        file.transferTo(new File(path,filename));
        System.out.println("图片路径为"+path);
        //换成json返回去
        map.put("code",0);
        map.put("msg","用户头像");
        map.put("src","picture/"+filename);
        System.out.println(map);
        return map;

    }
}
