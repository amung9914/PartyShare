package com.bitc.freeboard.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class FreeBoardVO {

	int bno;
	String category;
	String title;
	String context;
	Date date;
	String mnick;
	int viewCnt;
	String mid;
	int origin;
	int depth;
	int seq;
	String showBoard;
	int commentCount;
	
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
