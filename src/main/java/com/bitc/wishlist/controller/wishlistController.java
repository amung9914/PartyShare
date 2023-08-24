package com.bitc.wishlist.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitc.partyDetail.vo.MemberVO;
import com.bitc.partyDetail.vo.PartyVO;
import com.bitc.wishlist.service.wishlistService;
import com.bitc.wishlist.vo.WishlistVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/wishlist/*")
@RequiredArgsConstructor
public class wishlistController {
	
	private final wishlistService ws;
	
	@GetMapping("/wishlist")
	public void wishlist(HttpSession session, Model model) {
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		try {
			List<WishlistVO> wishlist = ws.readWishlist(member.getMnum());
			model.addAttribute("wishlist", wishlist);
		} catch (Exception e) {
			System.out.println("wishlist하다가 오류 났어요");
		}
	}
	
	@GetMapping("/perWishlist")
	public void perWishlist(HttpServletRequest request, Model model) {
		String alias = request.getParameter("alias");
		
		try {
			List<PartyVO> parties = ws.readPerWishlist(alias);
			model.addAttribute("alias", alias);
			model.addAttribute("parties", parties);
		} catch (Exception e) {
			System.out.println("perWishlist하다가 오류 났어요");
		}
	}
	
	@PostMapping("/addWishlist")
	public ResponseEntity<String> addWishList(@RequestParam("pNum") int pNum, @RequestParam("alias") String alias, HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("loginMember");
	    if (member != null) {
	        // dao.addWishlist() 호출
	    	try {
				ws.addWishlist(member.getMnum(), pNum, alias);
			} catch (Exception e) {
				System.out.println("addWishlist하다가 오류났어요.");
			}
	        // 성공하면 HttpStatus.OK를 리턴하거나 원하는 응답을 생성
	        return new ResponseEntity<>("Wish List added", HttpStatus.OK);
	    } else {
	        // 로그인되지 않은 경우 에러 응답을 생성 (예: HttpStatus.UNAUTHORIZED)
	        return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
	    }
	}

	@PostMapping("/deleteWishlist")
	public ResponseEntity<String> deleteWishList(@RequestParam("pNum") int pNum, HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("loginMember");
	    if (member != null) {
	        // dao.deleteWishlist() 호출
	    	try {
				ws.deleteWishlist(member.getMnum(), pNum);
			} catch (Exception e) {
				System.out.println("deleteWishlist하다가 오류났어요.");
			}
	        // 성공하면 HttpStatus.OK를 리턴하거나 원하는 응답을 생성
	        return new ResponseEntity<>("Wish List deleted", HttpStatus.OK);
	    } else {
	        // 로그인되지 않은 경우 에러 응답을 생성 (예: HttpStatus.UNAUTHORIZED)
	        return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
	    }
	}
	
}
