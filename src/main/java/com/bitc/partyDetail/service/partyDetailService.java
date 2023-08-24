package com.bitc.partyDetail.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

public interface partyDetailService {
	
	// 테스트용 이미지 업로드
	void insertImageParty(int pnum, String savedName1, String savedName2, String savedName3) throws Exception;
	
	// Party 정보 전달
	public PartyVO readParty(int pNum) throws Exception;
	
	// 파티원 인원수 전달
	public int NumberOfJoinMember(int pNum) throws Exception;
	
	// 파티원 목록 전달
	public List<MemberVO> readJoinMember(int pNum) throws Exception;
	
	// 파티원 성별 비율 전달
	public double[] readGenderPercent(int pNum) throws Exception;
	
	// 파티원 파티 참여 횟수 전달
	public double[] readJoinCntPercent(int pNum) throws Exception;
		
	// 파티원 연령대별 비율 전달
	public double[] readAgePercent(int pNum) throws Exception;
		
	// 파티 위도 경도 전달
	public double[] readLocation(int pNum) throws Exception;
	
	// 파티 조회수 증가
	public void increaseView(HttpSession session, int pNum) throws Exception;
	
	// 파티 중복 멤버 조사
	public int findJoinMember(int pNum, int mNum) throws Exception;
	
	// 파티 참여 멤버 증가
	public void joinMember(int pNum, int mNum) throws Exception;
	
	// 멤버 파티 참여 횟수 증가
	public void increaseJoinCnt(int mNum) throws Exception;
}
