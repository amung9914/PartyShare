package com.bitc.party.controller;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.FileUtils;
import com.bitc.common.utils.PageMaker;
import com.bitc.map.vo.MapVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.service.CreatePartyService;
import com.bitc.party.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/party")
public class CreatePartyController {
	
	private final CreatePartyService ps;
	
	private final String uploadPartyDir;
	private final ServletContext context;
	
	private String realPath;
	
	// 파일 업로드 경로 설정
	@PostConstruct
	public void init() {
		realPath = context.getRealPath(File.separator+uploadPartyDir);
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdirs();
		}
	}
	
	// 파티 생성 페이지 이동
	@GetMapping("/createParty")
	public String createName(Model model) {
		List<String> list = null;
		try {
			list = ps.getDescriptionList();
			model.addAttribute("description", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "createParty/description";
	}
	
	// 파티 생성 - 파티 분류
	@PostMapping("/createDescription")
	public String createMainCategory(PartyVO vo, Model model) {
		List<String> list = null;
		try {
			list = ps.getCategoryList();
			model.addAttribute("category", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("vo", vo);
		return "createParty/category";
	}
	
	// 파티 생성 - 파티 분류
	@PostMapping("/createCategory")
	public String createSubCategory(PartyVO vo, Model model) {
		model.addAttribute("vo", vo);
		return "createParty/address";
	}
	
	// 파티 생성 - 파티 주소
	@PostMapping("/createAddress")
	public String createSubAddress(PartyVO vo, Model model, HttpServletRequest request) {
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		MapVO map = new MapVO(lat, lng);
		
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/period";
	}
	
	@PostMapping("/choosePeriod")
	public String choosePeriod(PartyVO vo, Model model, MapVO map, String period) {
		model.addAttribute(map);
		model.addAttribute("vo", vo);
		if(period.equals("짜릿한 일회성 만남")) {
			return "createParty/dateOne";
		}else {
			return "createParty/date";
		}
	}
	
	// 파티 생성 - 파티 날짜
	@PostMapping("/createDate")
	public String createDate(PartyVO vo, Model model, MapVO map) {
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/name";
	}
	
	// 파티 생성 - 파티 이름
	@PostMapping("/createName")
	public String createName(PartyVO vo, Model model, MapVO map) {
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/context";
	}
	
	// 파티 생성 - 파티 설명
	@PostMapping("/createContext")
	public String createContext(PartyVO vo, Model model, MapVO map) {
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/image";
	}
	
	// 파티 생성 - 파티 이미지 등록
	@PostMapping("/createImage")
	public String createParty(MultipartHttpServletRequest request, PartyVO vo, MapVO map) {
		MultipartFile file1 = request.getFile("image1");
		MultipartFile file2 = request.getFile("image2");
		MultipartFile file3 = request.getFile("image3");
		System.out.println(file1);
		String savedName = "";
		try {
			if(!file1.isEmpty()) {
				savedName = FileUtils.uploadThumbnailImage(realPath, file1);
				vo.setPartyImage1(savedName);
			}else {
				savedName = "/default.png";
				vo.setPartyImage1(savedName);
			}
			
			if(!file2.isEmpty()) {
				savedName = FileUtils.uploadOriginalImage(realPath, file2);
				vo.setPartyImage2(savedName);
			}else {
				savedName = "/default.png";
				vo.setPartyImage2(savedName);
			}
			
			if(!file3.isEmpty()) {
				savedName = FileUtils.uploadOriginalImage(realPath, file3);
				vo.setPartyImage3(savedName);
			}else {
				savedName = "/default.png";
				vo.setPartyImage3(savedName);
			}
			
			int pnum = ps.createParty(vo);
			map.setPnum(pnum);		
			
			ps.joinPartyMember(pnum, vo.getHost());
			ps.setLocation(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "createParty/success";
	}
	
	// 파티 리스트로
	@GetMapping("/partyList")
	public String partyList() {
		return "redirect:/";
	}
	
	// 파일의 경로를 리스트 내에 객체에 담아서 ${list.URL}
	@GetMapping("/partyList/{page}")
	@ResponseBody
	public Map<String, Object> partyList(@PathVariable(name="page") int page){
		Map<String, Object> map = new HashMap<>();
		Criteria cri = new Criteria(page, 20);
		List<PartyVO> partyList = null;
		PageMaker pm = null;
		try {
			partyList = ps.partyList(cri);
			pm = ps.getPageMaker(cri);
			map.put("pm", pm);
			map.put("list", partyList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	@GetMapping("/partyMemberBan")
	public String partyMemberBan(Model model, int mnum, int pnum, RedirectAttributes rttr) {
		try {
			String result = ps.partyMemberBan(pnum, mnum);
			model.addAttribute("message", result);
			rttr.addAttribute("pnum", pnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/party/partyHost";
	}
	
	@GetMapping("/partyFinish")
	public String partyFinish(int pnum, RedirectAttributes rttr) {
		String result = null;
		try {
			result = ps.setPartyFinish(pnum);
			rttr.addFlashAttribute("message", result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/";
	}
	
	@GetMapping("/partyDetail")
	public String partyDetail(int pnum, Model model) {
		try {
			PartyVO vo = ps.selectParty(pnum);
			model.addAttribute("party", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "partyDetail";
	}
}
