package com.bitc.login.controller;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bitc.common.utils.FileUtils;
import com.bitc.login.service.JoinService;
import com.bitc.login.vo.LoginDTO;
import com.bitc.member.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class LoginHomeController {

    private final JoinService js;
    
    @Qualifier(value="uploadDir")
    private final String uploadDir;  
    private final ServletContext context;

    private String realPath;

    public LoginHomeController(JoinService js, String uploadDir, ServletContext context) {
        this.js = js;
        this.uploadDir = uploadDir;
        this.context = context;
    }

    @PostConstruct
    public void initPath() {
        realPath = context.getRealPath(File.separator + uploadDir);
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
            System.out.println("디렉토리 생성 완료");
        }
        System.out.println("Controller 생성 및 사용준비 완료");
    }

    
    private static final String[] ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png"};
    
    //2023-08-22
    
    @PostMapping("/join")
    public String join(MemberVO vo,@RequestParam("file") MultipartFile file, Model model)  {
       
       if (!file.isEmpty()) {            
            //-- 이미지처리
            String originalFilename = file.getOriginalFilename();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);

            for (String allowedExtension : ALLOWED_EXTENSIONS) {
                if (fileExtension.equalsIgnoreCase(allowedExtension)) {
                    // 파일 처리 로직 추가
                	 try {
						String savedName = FileUtils.uploadOriginalImage(realPath, file);
               vo.setProfileImageName(savedName);
               js.Join(vo);
					} catch (Exception e) {
						return "error500";
					}
                   
                   // 8 23 수정
                                      
                   return "redirect:/member/login";
                }
            }
        }      
		vo.setProfileImageName("/default.jpg");
		try {
			js.Join(vo);
		} catch (Exception e) {
			
			return "error500";
			
		}
		 
       return "redirect:/member/login"; // 여기서 이미지 넣어야함
    }
    
    //2023-08-22 
    
    @GetMapping("/goJoin")
    public String goJoin () {
    	return "member/join";
    }

    @GetMapping("/login")
    public String goLogin() { 
        return "member/login";
    }
    
    @GetMapping("/loginFailed")
    public String loginFailed() {
    	return "member/loginFailed";
    }

    @PostMapping("/loginCheck")
    public String loginCheck(LoginDTO dto, ModelAndView mav,HttpSession session) throws Exception {
       return js.login(dto, session);
    }
/*
    @RequestMapping("/error500", "/error404" }, method = {RequestMethod.POST })
    public String error500() {
        return "error500"; // 에러 페이지의 뷰 이름
    }
*/	
    @PostMapping("error500") 
    public String error500() {
    	return "error500";
    }
    
    @PostMapping("error404") 
    public String error404() {
    	return "error404";
    }
    

   /*
    * @PostMapping("uploadImg") public String uploadImg() { return "test"; }
    */

   /*
    * @PostMapping("uploadForm") public String uploadForm(@RequestParam("file")
    * MultipartFile file, Model model) throws IOException { if (!file.isEmpty()) {
    * byte[] bytes = file.getBytes(); String savedName =
    * uploadFile(file.getOriginalFilename(), bytes);
    * model.addAttribute("savedName", savedName); } return "test"; }
    */

    public String uploadFile(String original, byte[] fileData) throws IOException {
        String savedName = "";
        UUID uuid = UUID.randomUUID();
        savedName = uuid.toString().replace("-", "") + "_" + original;
        FileCopyUtils.copy(fileData, new File(realPath, savedName));
        return savedName;
    }
    

}