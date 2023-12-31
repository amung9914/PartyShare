package com.bitc.party.controller;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.common.utils.FileUtils;
import com.bitc.map.service.MapService;
import com.bitc.map.vo.MapVO;
import com.bitc.member.service.MemberService;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.service.PartyService;
import com.bitc.party.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@PropertySource("classpath:/prop/maria.properties") // api숨김
@RequiredArgsConstructor
@Controller
public class PartyController {

	@Value("${kakao.key}")
	private String apiKey;
	
	private final MemberService ms;
	private final PartyService ps;
	private final MapService maps;
	
	// 이미지 파일 업로드
	private final String uploadPartyDir;
	private final ServletContext context;
	private String realPath;
	
	@PostConstruct
	public void initPath() {
		realPath = context.getRealPath(File.separator+uploadPartyDir);
		System.out.println(realPath);
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdirs();
		}
				
	}
	
	/**
	 * 사진출력
	 */
	@ResponseBody
	@GetMapping("/party/printImg")
	   public ResponseEntity<byte[]> displayImg(String fileName) throws Exception{
	      return new ResponseEntity<>(
	            FileUtils.getBytes(realPath, fileName),
	            FileUtils.getHeaders(fileName),
	            HttpStatus.OK
	            );
	   }
	
	// 내가 개설한 파티 리스트 페이지 이동
	@GetMapping("/host/party/hostingList")
	public String partyHost(HttpSession session, Model model) {
		//model에 담아서 주기
		List<PartyVO> list = null;
		try {
			list = ps.HostingList(session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list",list);
		return "/party/hostingList";
	}
	
	// 파티관리 페이지
	@GetMapping("/host/party/partyHost")
	public String partyHost(int pnum,Model model) {
		PartyVO vo = null;
		List<MemberVO> list = null;
		try {
			vo = ps.read(pnum);
			list = ps.getJoinPartyMemberList(pnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("partyJoinMember",list);
		model.addAttribute("party",vo);
		return "party/partyHost";
	}
	
	//파티수정 페이지
	@GetMapping("/host/party/updateParty")
	public String updateParty(int pnum,Model model) {
		PartyVO vo = null;
		MapVO map = null;
		List<String> description = null;
		List<String> category = null;
		try {
			vo = ps.read(pnum);
			map = maps.readLocation(pnum);
			description = ps.description();
			category = ps.category();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("apiKey",apiKey);
		model.addAttribute("party",vo);
		model.addAttribute("map", map);
		model.addAttribute("description", description);
		model.addAttribute("category",category);
		return "party/updateParty";
	}
	
	// mapVO, partyVO 수정처리
	@PostMapping("/host/party/updateParty")
	public String updateSubmit(
			MultipartHttpServletRequest request,
			MapVO map, PartyVO vo, RedirectAttributes rttr) {
		String result = "FAILED";
		String result1 = null;
		String result2 = null;
		String result3 = null;
		MultipartFile file1 = request.getFile("image1");
		MultipartFile file2 = request.getFile("image2");
		MultipartFile file3 = request.getFile("image3");
		
		String savedName1 = null;
		String savedName2 = null;
		String savedName3 = null;
		if(!file1.isEmpty()) {
			
			try {
				savedName1 = FileUtils.uploadThumbnailImage(realPath, file1);
				vo.setPartyImage1(savedName1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		if(!file2.isEmpty()) {
			try {
				savedName2 = FileUtils.uploadOriginalImage(realPath, file2);
				vo.setPartyImage2(savedName2);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(!file3.isEmpty()) {
			try {
				savedName3 = FileUtils.uploadOriginalImage(realPath, file3);
				vo.setPartyImage3(savedName3);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		try {
			result1 = maps.updateLocation(map);
			
			if(vo.getPartyImage1()!=null) {
				result2 = "SUCCESS";
			}
			
			result3 = ps.update(vo);
			
			// 파일업로드
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result1.equals("SUCCESS") && result1.equals(result2) && result1.equals(result3)) {
			result = "SUCCESS";
		}
		rttr.addFlashAttribute("result",result);
		rttr.addAttribute("pnum",vo.getPnum());
		return "redirect:/host/party/partyHost"; 
	}
	
	// 참여중인 파티 페이지 이동
	@GetMapping("/user/party/myParty")
	public String myParty(HttpSession session, Model model) {
		//model에 담아서 주기
				List<PartyVO> list = null;
				try {
					list = ps.myPartyList(session);
				} catch (Exception e) {
					e.printStackTrace();
				}
				model.addAttribute("list",list);
		return "/party/myPartyList";
	}
	
	@GetMapping("/user/party/calender")
	public String calender(HttpSession session, Model model) {
		//model에 담아서 주기
		List<PartyVO> list = null;
		try {
			list = ps.myPartyList(session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list",list);
		return "party/calender";
	}
	
	
	/**
	  * 파티탈퇴
	  */
	 @ResponseBody
	 @DeleteMapping("/user/party/withdraw/{pnum}")
	 public ResponseEntity<String> withdraw(
			 HttpSession session,
			 @PathVariable int pnum){
		 ResponseEntity<String> entity = null;
		 String result = null;
		 HttpHeaders header = new HttpHeaders();
		 header.add("Content-Type", "text/plain;charset=utf-8");
		 try {
			result = ps.withdraw(session,pnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 if(result.equals("SUCCESS")) {
			 entity = new ResponseEntity<>("정상 처리 되었습니다.",header,HttpStatus.OK);
		 }else {
			 entity = new ResponseEntity<>("실패하셨습니다",header,HttpStatus.BAD_REQUEST);
		 }
		 
		 return entity;
	 }
	
	 
}

