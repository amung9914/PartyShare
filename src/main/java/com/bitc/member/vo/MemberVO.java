package com.bitc.member.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class MemberVO {
	// VO 객체 생성시 아이디와 비밀번호 필수값 지정
	
	private int mnum;					// 멤버 번호
	private String mid;					// 아이디
	private String mpw;					// 비밀번호
	private String mname;				// 이름
	private String mnick;				// 닉네임
	private int mage;					// 나이
	private String mgender;				// 성별
	private String memail;				// 이메일
	private int mbancnt;				// 신고당한 횟수
	private String maddr;				// 주소
	private int mjoinCnt;				// 파티참여 횟수
	private String mblackYN;			// 블랙리스트 유무
	private String withdraw;			// 탈퇴
	private String profileImageName;	// 프로필 이미지
	
}
