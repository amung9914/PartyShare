package com.bitc.admin.controller;

import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.bitc.admin.service.AdminService;
import com.bitc.member.vo.MemberVO;
import com.bitc.notice.service.NoticeService;
import com.bitc.notice.vo.NoticeVO;
import com.bitc.search.service.SearchService;
import com.bitc.search.util.MakeQuery;
import com.bitc.search.vo.CategoryVO;
import com.bitc.search.vo.descriptionVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AdminController {
	private final SearchService ss;
	private final AdminService as;
	private final NoticeService ns;
	private final MakeQuery mq;
	// 관리자 카테고리 추가 메소드
	@PostMapping("search/addCategory")
	public ResponseEntity<String> addCategory(
          CategoryVO vo
    ) {
		ResponseEntity<String> entity = null;
		String message;
		String result;
		try {
			result = ss.addCategory(vo);
			message ="category등록 완료";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
//			System.out.println("addCategory success");
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON); //encode
			entity = new ResponseEntity<>(e.getMessage(),header,HttpStatus.BAD_REQUEST);
		}
		
        return entity; // ajax dataType = "text",
	}
	
	@PostMapping("search/addDescription")
	public ResponseEntity<String> addDescription(
          descriptionVO vo
    ) {
		ResponseEntity<String> entity = null;
		
		String result;
		try {
			result = ss.addDescription(vo);//			body 				status
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>("description등록 완료",header,HttpStatus.OK);
			System.out.println("addDescription success");
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON); //encode
			entity = new ResponseEntity<>(e.getMessage(),header,HttpStatus.BAD_REQUEST);
		}
        return entity; // ajax dataType = "text",
	}
	
	// 관리자 페이지에서 전체 카테고리 출력 메소드 <<deprecated>>
	
//	public List<CategoryVO> getCategory() throws Exception{
//		List<CategoryVO> list = as.getCategory();
//		return list;
//	}
	

	// 
	@PostMapping("search/modDate")
	public ResponseEntity<String> modDate() {
		ResponseEntity<String> entity = null;
		try {
			System.out.println("modDate : " );
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>("SUCCESS",header,HttpStatus.OK);
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON); //encode
			entity = new ResponseEntity<>(e.getMessage(),header,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 로케이션 위치 수정
 	@PostMapping("search/modLocation")
	public ResponseEntity<String> modLocation() {
		ResponseEntity<String> entity = null;
		try {
			System.out.println("modLocation : " );
			//AOP @AROUND 전처리
			
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON); //encode
			entity = new ResponseEntity<>(e.getMessage(),header,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
 	
 	
	
 	@GetMapping("admin/memberList")
 	public ResponseEntity<List<MemberVO>> memberList(){
 		ResponseEntity<List<MemberVO>> entity = null;
 		
 		try {
			List<MemberVO> list = as.memberList();
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON);
			entity = new ResponseEntity<>(list,header,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<MemberVO>>(HttpStatus.BAD_REQUEST);
		}
 		System.out.println(entity);
 		return entity;
 	}
 	

 	/////////////////
 	
 	/////////////////////
 	@PostMapping("admin/blackMember")
 	@ResponseBody
 	
 	public ResponseEntity<String > blackMember(
 			String target){
 		ResponseEntity<String> entity = null;
 		
 		String result = "";
		try {	// mId
			NoticeVO vo = new NoticeVO();
			System.out.println("new vo:" + vo);
			ns.blackPost(target, vo);
			result = mq.stringResult(as.blackMember(target));
			System.out.println(target+"은 블랙입니까?" + as.selectMember(target).getMblackYN());
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON); 
			entity = new ResponseEntity<String>(result,header,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
 		System.out.println(result);
 		System.out.println(entity);
 		return entity;
 	}
 	
 	
 	

	
 	/*
	  @GetMapping("admin/notice") public String notice() {
		  System.out.println("이거냐고"); 
		  return "/admin/notice";
	}
	 */
 	
	
	//  MESSAGE				 MESSAGE				 MESSAGE		 MESSAGE						
//	@GetMapping("/list")
//	public ResponseEntity<List<MessageVO>> readlist(){
//		ResponseEntity<List<MessageVO>> entity = null;
//		try {
//			List<MessageVO> list = ms.list();
//			entity = new ResponseEntity<>(list,HttpStatus.OK);
//		} catch (Exception e) {
//			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//		}
//		return entity;
//	}
//	
//	@PatchMapping("/read/{mno}/{uid}")
//	public ResponseEntity<Object> readMessage(
//				@PathVariable(name="mno") int mno,
//				@PathVariable(name="uid") String uid
//			){
//		ResponseEntity<Object> entity = null;
//		
//		try {
//			MessageVO vo = ms.readMessage(uid, mno);
//			entity = new ResponseEntity<>(vo, HttpStatus.OK);
//		} catch (Exception e) {
//			HttpHeaders headers = new HttpHeaders();
//			headers.setContentType(MediaType.APPLICATION_JSON);
//			entity = new ResponseEntity<>(
//							e.getMessage(), 
//							headers,
//							HttpStatus.BAD_REQUEST);
//		}
//		
//		return entity;
//	}
	
	// MESSAGE				 MESSAGE	 		 MESSAGE							
}
