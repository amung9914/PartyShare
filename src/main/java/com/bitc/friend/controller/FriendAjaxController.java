package com.bitc.friend.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bitc.friend.service.FriendService;
import com.bitc.friend.vo.FriendVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/friend")
@RequiredArgsConstructor
public class FriendAjaxController {

	private final FriendService fs;

	/**
	 * 아이디로 사용자 검색
	 */
	@GetMapping("searchId/mid/{target}") 
	public List<MemberVO> searchId(
			@PathVariable(name="target") String target ) throws Exception{
		List<MemberVO> list = fs.searchId(target); 
		return list; 
	}
	
	/**
	 * 닉네임으로 사용자 검색
	 */
	 @GetMapping("searchId/mnick/{target}") 
	 public List<MemberVO> searchNick(
			 @PathVariable(name="target") String target ) throws Exception{
		 List<MemberVO> list = fs.searchNick(target); 
		return list; 
	 }
	 
	 /**
	  * 친구 신청
	  */
	 @PostMapping("create")
	 public ResponseEntity<String> create(FriendVO vo) {
		 ResponseEntity<String> entity = null;
		 FriendVO confirm1 = null;
		 FriendVO confirm2 = null;
		 String result = null;
		 HttpHeaders header = new HttpHeaders();
		 header.add("Content-Type","text/plain;charset=utf-8");
		 try {
			 // 기존에 요청한 사람인지 확인 
			 confirm1 = fs.confirmRequest(vo);
			 if(confirm1 != null) {
				 entity = new ResponseEntity<>("이미 친구요청을 보냈습니다.",header,HttpStatus.BAD_REQUEST);
				 return entity;
			 }
				
			// 이미 친구인지 아닌지 확인
			 confirm2 = fs.confirmFriend(vo);
			 if(confirm2 != null) {
				 entity = new ResponseEntity<>("친구목록에 존재하는 사용자입니다.",header,HttpStatus.BAD_REQUEST);
				 return entity;
			 }
			 // 친구요청 실행
			result = fs.create(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
		 if(result.equals("SUCCESS")) {
			 entity = new ResponseEntity<>("친구신청이 정상적으로 완료되었습니다.",header,HttpStatus.OK);
		 }else {
			 entity = new ResponseEntity<>("친구신청실패",header,HttpStatus.BAD_REQUEST);
		 }
		 return entity;
	 }
	
	 /**
	  * 친구요청삭제
	  * @param fto
	  */
	 @DeleteMapping("deleteRequest/{fto}")
	 public ResponseEntity<String> deleteRequest(
			 HttpSession session, 
			 @PathVariable int fto){
		 ResponseEntity<String> entity = null;
		 String result = null;
		 HttpHeaders header = new HttpHeaders();
		 header.add("Content-Type", "text/plain;charset=utf-8");
		 try {
			result = fs.deleteRequest(session, fto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 if(result.equals("SUCCESS")) {
			 entity = new ResponseEntity<>("친구요청이 취소되었습니다.",header,HttpStatus.OK);
		 }else {
			 entity = new ResponseEntity<>("이미 수락한 상태입니다.",header,HttpStatus.BAD_REQUEST);
		 }
		 
		 return entity;
	 }
	 
	 /**
	  * 친구요청 거절
	  * @param ffrom
	  */
	 @DeleteMapping("reject/{ffrom}")
	 public ResponseEntity<String> reject(
			 HttpSession session, 
			 @PathVariable int ffrom){
		 ResponseEntity<String> entity = null;
		 String result = null;
		 HttpHeaders header = new HttpHeaders();
		 header.add("Content-Type", "text/plain;charset=utf-8");
		 try {
			result = fs.deleteRequest(session, ffrom);
			System.out.println(ffrom);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 if(result.equals("SUCCESS")) {
			 entity = new ResponseEntity<>("친구요청이 취소되었습니다.",header,HttpStatus.OK);
		 }else {
			 entity = new ResponseEntity<>("친구거절 실패",header,HttpStatus.BAD_REQUEST);
		 }
		 
		 return entity;
	 }
	 
	 /**
	  * 친구요청 수락
	  */
	 @PutMapping("accept/{ffrom}")
	 public ResponseEntity<String> accept(
			 HttpSession session, 
			 @PathVariable int ffrom){
		 ResponseEntity<String> entity = null;
		 String result = null;
		 HttpHeaders header = new HttpHeaders();
		 header.add("Content-Type", "text/plain;charset=utf-8");
		 	try {
				result=fs.accept(session, ffrom);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 if(result.equals("SUCCESS")) {
			 entity = new ResponseEntity<>("친구가 되셨습니다.",header,HttpStatus.OK);
		 }else {
			 entity = new ResponseEntity<>("친구수락 실패",header,HttpStatus.BAD_REQUEST);
		 }
		 return entity;
	 }
	
	 /**
	  * 친구의 진행중인 파티 정보를 가져온다.
	  */
	 @GetMapping("ongoingParty/{mnum}")
	 public List<PartyVO> ongoingParty(
			 @PathVariable int mnum){
		 List<PartyVO> list = null;
		try {
			list = fs.ongoingParty(mnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return list;
	 }
	 
	 /**
	  * 친구의 참여했었던 파티 정보를 가져온다.
	  */
	 @GetMapping("previousParty/{mnum}")
	 public List<PartyVO> previousParty(
			 @PathVariable int mnum){
		 List<PartyVO> list = null;
		try {
			list = fs.previousParty(mnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return list;
	 }
	 
	 /**
	  *  친구 삭제 처리
	  */
	 @DeleteMapping("deleteFriend/{mnum}")
	 public ResponseEntity<String> deleteFriend(
			 HttpSession session, @PathVariable int mnum){
		 ResponseEntity<String> entity = null;
		 String result = null;
		 HttpHeaders header = new HttpHeaders();
		 header.add("Content-Type", "text/plain;charset=utf-8");
		 	try {
				result=fs.deleteFriend(session, mnum);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 if(result.equals("SUCCESS")) {
			 entity = new ResponseEntity<>("친구 삭제가 완료되었습니다.",header,HttpStatus.OK);
		 }else {
			 entity = new ResponseEntity<>("친구 삭제 실패",header,HttpStatus.BAD_REQUEST);
		 }
		 return entity;
		 
	 }
	 
}
