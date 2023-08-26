package com.bitc.member.vo;

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
	private int mnum;
	private String mid;
	private String mpw;
	private String mname;
	private String mnick;
	private int mage;
	private String mgender;
	private String memail;
	private int mbanCnt;
	private String maddr;
	private int mjoinCnt;
	private String mblackYN;
	private String withdraw;
	private String profileImageName;

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
