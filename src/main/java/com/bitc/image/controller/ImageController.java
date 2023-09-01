package com.bitc.image.controller;

import java.io.File;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bitc.common.utils.FileUtils;
import com.bitc.member.service.MemberService;
import com.bitc.member.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ImageController {

	private final MemberService ms;
	
	// 프로필 이미지 폴더 경로
	private final String uploadDir;
	// 피티 이미지 폴더 경로
	private final String uploadPartyDir;
	private final ServletContext context;	
	private String profileRealPath;
	private String partyRealPath;
	
	// 프로필 이미지 경로와 파티 이미지 경로 폴더 생성
	@PostConstruct
	public void init() {
		profileRealPath = context.getRealPath(File.separator+uploadDir);
		File file = new File(profileRealPath);
		if(!file.exists()) {
			file.mkdirs();
		}
		partyRealPath = context.getRealPath(File.separator+uploadPartyDir);
		File file1 = new File(partyRealPath);
		if(!file1.exists()) {
			file1.mkdirs();
		}
	}
	
	// 프로필 이미지 출력
	@GetMapping("image/printProfileImage")
	public ResponseEntity<byte[]> printProfileImage(String fileName) throws Exception{
		return new ResponseEntity<>(
				FileUtils.getBytes(profileRealPath, fileName),
				FileUtils.getHeaders(fileName),
				HttpStatus.OK
				);
	}
	
	// 프로필 이미지를 맴버 번호를 이용해 출력
	@GetMapping("image/printProfileImageNum")
	public ResponseEntity<byte[]> printProfileImageNum(int mnum) throws Exception{
		MemberVO member = ms.selectMember(mnum);
		String fileName = member.getProfileImageName();
		return new ResponseEntity<>(
				FileUtils.getBytes(profileRealPath, fileName),
				FileUtils.getHeaders(fileName),
				HttpStatus.OK
				);
	}
	
	// 파티 이미지 출력
	@GetMapping("image/printPartyImage")
	public ResponseEntity<byte[]> printPartyImage(String fileName) throws Exception{
		return new ResponseEntity<>(
				FileUtils.getBytes(partyRealPath, fileName),
				FileUtils.getHeaders(fileName),
				HttpStatus.OK
				);
	}
	
	// 프로필 이미지 업로드
	@PostMapping("user/image/uploadAjax")
	@ResponseBody
	public ResponseEntity<String> profileImageUpload(MultipartFile file) throws Exception{
		String savedName = FileUtils.uploadOriginalImage(profileRealPath, file);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/plain;charset=utf-8");
		return new ResponseEntity<>(savedName, headers, HttpStatus.OK);
	}

	// 이미지 삭제
	@DeleteMapping(value="user/image/deleteFile", produces="text/plain;charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> deleteFile(@RequestBody String fileName) throws Exception{
		ResponseEntity<String> entity = null;
		boolean isDeleted = FileUtils.deleteOriginalImage(profileRealPath, fileName);
		
		if(isDeleted) {
			entity = new ResponseEntity<>("삭제성공",HttpStatus.OK);
		}else {
			entity = new ResponseEntity<>("삭제실패",HttpStatus.CREATED);
		}
		return entity;
	}
}
