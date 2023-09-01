package com.bitc.comment.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class FreeBoardCommentVO {
	
	int cno;			 // 댓글 번호
	int bno;			 // 댓글이 작성된 게시글 번호
	String commentText;	 // 댓글 내용
	String mnick;		 // 작성자 닉네임
	String mid;			 //	작성자 아이디
	Date regdate;		 //	댓글 작성 일시	(Date)
	String regdateStr;	 // 댓글 작성 일시 (String)
	String showBoard;    // 댓글 블라인드 처리 유무
	
	public void setRegdateStr() {
	    String regdateStr = null;
	    try {
	        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        regdateStr = inputFormat.format(this.regdate);

	        SimpleDateFormat outputFormat;
	        Date today = new Date();
	        if (regdateStr.substring(0, 10).equals(inputFormat.format(today).substring(0, 10))) {
	            outputFormat = new SimpleDateFormat("HH:mm:ss");
	        } else {
	            outputFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
	        }
	        regdateStr = outputFormat.format(this.regdate);
	    } catch (Exception e) {
	        System.out.println("getFormatDate에서 오류 발생");
	    }
	    this.regdateStr = regdateStr;
	}
	
}
