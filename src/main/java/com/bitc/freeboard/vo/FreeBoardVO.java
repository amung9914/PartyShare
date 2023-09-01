package com.bitc.freeboard.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class FreeBoardVO {

	int bno;				// 게시글 번호
	String category;		// 게시글 카테고리(공지, 일반)
	String title;			// 게시글 제목
	String context;			// 게시글 내용
	Date date;				// 게시글 작성일시
	String mnick;			// 게시글 작성자 닉네임
	int viewCnt;			// 게시글 조회수
	String mid;				// 게시글 작성자 아이디
	int origin;				// 원본 게시글 번호 (답변글 작성용)
	int depth;				// 딥변글 들여쓰기 깊이
	int seq;				// 답변글 순서
	String showBoard;		// 게시글 블라인드 처리 유무
	int commentCount;		// 게시글 댓글수
	
	// 검색필터
	private String type; 	// 검색 타입
	private String keyword; // 검색 내용
	
	public String getFormatDate() {
	    String newDate = null;
	    try {
	        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        newDate = inputFormat.format(this.date);

	        SimpleDateFormat outputFormat;
	        Date today = new Date();
	        if (newDate.substring(0, 10).equals(inputFormat.format(today).substring(0, 10))) {
	            outputFormat = new SimpleDateFormat("HH:mm:ss");
	        } else {
	            outputFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
	        }
	        newDate = outputFormat.format(this.date);
	    } catch (Exception e) {
	        System.out.println("getFormatDate에서 오류 발생");
	    }
	    return newDate;
	}
	
}
