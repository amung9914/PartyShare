package com.bitc.member.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MemberVO {
	private int mnum;					// 멤버 번호
	private String mid;					// 멤버 아이디
	private String mpw;					// 멤버 비밀번호
	private String mname;				// 멤버 이름
	private String mnick;				// 멤버 닉네임
	private int mage;					// 멤버 나이
	private String mgender;				// 멤버 성별
	private String memail;				// 멤버 이메일
	private int mbanCnt;				// 신고받은 횟수
	private String maddr;				// 멤버 주소
	private int mjoinCnt;				// 파티 참여 횟수
	private String mblackYN;			// 멤버 정지 유무
	private String withdraw;			// 멤버 탈퇴 유무
	private String profileImageName;	// 멤버 프로필 이미지 경로
	
	// Security 권한 목록
	private List<String> authList;

	public MemberVO(String mid, String mpw) {
		this.mid = mid;
		this.mpw = mpw;
	}
	
	// 맴버 번호가 같으면 같은 객체라 판단
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof MemberVO) {
			MemberVO m = (MemberVO) obj;
			if(this.mnum == m.mnum) {
				return true;
			}
		}
		return false;
	}

	
	
}
