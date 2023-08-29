package com.bitc.party.controller;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
import com.bitc.wishlist.vo.WishlistVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CreatePartyController {
	
	private final CreatePartyService ps;
	// 파티 이미지 경로
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
	@GetMapping("/user/party/createParty")
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
	@PostMapping("/user/party/createDescription")
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
	@PostMapping("/user/party/createCategory")
	public String createSubCategory(PartyVO vo, Model model) {
		model.addAttribute("vo", vo);
		return "createParty/address";
	}
	
	// 파티 생성 - 파티 주소
	@PostMapping("/user/party/createAddress")
	public String createSubAddress(PartyVO vo, Model model, HttpServletRequest request) {
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		MapVO map = new MapVO(lat, lng);
		
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/period";
	}
	
	@PostMapping("/user/party/choosePeriod")
	public String choosePeriod(PartyVO vo, Model model, MapVO map, String period) {
		model.addAttribute(map);
		model.addAttribute("vo", vo);
		if(period.equals("짜릿한 일회성 만남")) {
			// 하루 선택 달력
			return "createParty/dateOne";
		}else {
			// 범위 선택 달력
			return "createParty/date";
		}
	}
	
	// 파티 생성 - 파티 날짜
	@PostMapping("/user/party/createDate")
	public String createDate(PartyVO vo, Model model, MapVO map) {
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/name";
	}
	
	// 파티 생성 - 파티 이름
	@PostMapping("/user/party/createName")
	public String createName(PartyVO vo, Model model, MapVO map) {
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/context";
	}
	
	// 파티 생성 - 파티 설명
	@PostMapping("/user/party/createContext")
	public String createContext(PartyVO vo, Model model, MapVO map) {
		model.addAttribute("vo", vo);
		model.addAttribute(map);
		return "createParty/image";
	}
	
	// 파티 생성 - 파티 이미지 등록
	@PostMapping("/user/party/createImage")
	public String createParty(MultipartHttpServletRequest request, PartyVO vo, MapVO map) {
		List<MultipartFile> imageList = new ArrayList<>();
		imageList.add(request.getFile("image1"));
		imageList.add(request.getFile("image2"));
		imageList.add(request.getFile("image3"));
		System.out.println("contentType : " + imageList.get(0).getContentType());
		
		String savedName = "";
		// 이미지 업로드
		for(MultipartFile file : imageList) {
			if(file.getContentType().indexOf("image") < 0) {
				// 이미지가 아니거나 없으면 default 이미지 경로 저장
				savedName = "/default.png";
				vo.setPartyImage1(savedName);
			}else {
				// 이미지면 파일 업로드 후 경로 저장
				try {
					savedName = FileUtils.uploadThumbnailImage(realPath, file);
				} catch (Exception e) {
					e.printStackTrace();
				}
				vo.setPartyImage1(savedName);
			}
		}
		
		try {
			// 파티 등록 후 파티 pnum가져와서 맵 테이블에 저장
			int pnum = ps.createParty(vo);
			map.setPnum(pnum);		
			ps.setLocation(map);
			// 파티 참여 맴버 저장
			ps.joinPartyMember(pnum, vo.getHost());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "createParty/success";
	}
	
	// 사용자가 헤더에 입력한 키워드를 가지고 파티 리스트로
	@GetMapping("/party/partyList")
	public String partyList(String keyword, RedirectAttributes rttr) {
		if(keyword == null) {
			keyword="";
		}
		rttr.addFlashAttribute("searchValue", keyword);
		return "redirect:/";
	}
	
	// 파티 맴버 강퇴
	@GetMapping("/host/party/partyMemberBan")
	public String partyMemberBan(Model model, int mnum, int pnum, RedirectAttributes rttr) {
		try {
			String result = ps.partyMemberBan(pnum, mnum);
			model.addAttribute("message", result);
			rttr.addAttribute("pnum", pnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/host/party/partyHost";
	}
	
	// 파티 종료 
	@GetMapping("/host/party/partyFinish")
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
	
	// 페이징 처리, 검색된 파티 리스트 출력
	@GetMapping("/party/searchPartyList/{page}")
	@ResponseBody
	public Map<String, Object> searchPartyList(@PathVariable(name="page") int page, String keyword, HttpSession session){
		// 위시리스트로 등록한 파티 표시를 위한 현재 사용자 정보
		MemberVO m = (MemberVO) session.getAttribute("loginMember");
		
		// 파티 리스트와 위시리스트 pm을 저장
		Map<String, Object> map = new HashMap<>();
		Criteria cri = new Criteria(page, 20);
		List<PartyVO> partyList = null;
		PageMaker pm = null;
		
		// 로그인이 되어있으면 위시리스트 가져옴
		if(m != null) {
			int mnum = m.getMnum();
			List<WishlistVO> wishlist = null;
			wishlist = ps.getWishlist(mnum);
			map.put("wishlist", wishlist);
		}
		
		try {
			partyList = ps.searchPartyList(cri, keyword);
			pm = ps.getPageMaker(cri);
			map.put("pm", pm);
			map.put("list", partyList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
}
