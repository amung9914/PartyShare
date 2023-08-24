package com.bitc.partyDetail.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitc.partyDetail.dao.partyDetailMapper;
import com.bitc.partyDetail.vo.MapVO;
import com.bitc.partyDetail.vo.MemberVO;
import com.bitc.partyDetail.vo.PartyVO;

@Service
public class partyDetailServiceImpl implements partyDetailService{

	@Autowired
	private partyDetailMapper dao;
	
	// 테스트용 이미지 업로드
	@Override
	public void insertImageParty(int pnum, String savedName1, String savedName2, String savedName3) throws Exception {
		PartyVO vo = dao.readParty(pnum);
		vo.setPartyImage1(savedName1);
		vo.setPartyImage2(savedName2);
		vo.setPartyImage3(savedName3);
		dao.uploadParty(vo);
	}
	
	@Override
	public PartyVO readParty(int pNum) throws Exception {
		PartyVO vo = dao.readParty(pNum);
		return vo;
	}
	
	@Override
	public int NumberOfJoinMember(int pNum) throws Exception {
		int result = dao.NumberOfJoinMember(pNum);
		return result;
	}

	@Override
	public List<MemberVO> readJoinMember(int pNum) throws Exception {
		List<MemberVO> list = new ArrayList<>();
		list = dao.readJoinMember(pNum);
		return list;
	}

	@Override
	public double[] readGenderPercent(int pNum) throws Exception {
		List<MemberVO> list = new ArrayList<>();
		list = dao.readJoinMember(pNum);
		double[] genderPercent = new double[2];
		
		// 파티원 성별 비율
		int male = 0;
		int female = 0;
		
		for(MemberVO m : list) {
			if(m.getMgender().equals("M")) {
				male++;
			}else {
				female++;
			}
		}
		
		genderPercent[0] = Math.round((((double)male / list.size()) * 100) * 10.0) / 10.0;		// 남성 비율
		genderPercent[1] = Math.round((((double)female / list.size()) * 100) * 10.0) / 10.0;	// 여성 비율
		
		return genderPercent;
	}

	@Override
	public double[] readJoinCntPercent(int pNum) throws Exception {
		List<MemberVO> list = new ArrayList<>();
		list = dao.readJoinMember(pNum);
		double[] joinCntPercent = new double[4];
		
		// 파티원 파티 참여 횟수
		int first = 0;
		int second = 0;
		int third = 0;
		int olderFourth = 0;
		
		for(MemberVO m : list) {
			if(m.getMjoinCnt() == 0) {
				first++;
			}else if(m.getMjoinCnt() == 1) {
				second++;
			}else if(m.getMjoinCnt() == 2) {
				third++;
			}else {
				olderFourth++;
			}
		}
		
		joinCntPercent[0] = Math.round((((double)first / list.size()) * 100) * 10.0 ) / 10.0;		// 처음이에요
		joinCntPercent[1] = Math.round((((double)second / list.size()) * 100) * 10.0 ) / 10.0;		// 두 번째예요
		joinCntPercent[2] = Math.round((((double)third / list.size()) * 100) * 10.0 ) / 10.0;		// 세 번째예요	
		joinCntPercent[3] = Math.round((((double)olderFourth / list.size()) * 100) * 10.0 ) / 10.0;	// 네 번째 이상이에요
		
		return joinCntPercent;
	}

	@Override
	public double[] readAgePercent(int pNum) throws Exception {
		List<MemberVO> list = new ArrayList<>();
		list = dao.readJoinMember(pNum);
		double[] agePercent = new double[5];
		
		// 파티원 연령대별 비율
		int teen = 0;
		int twenty = 0;
		int thirty = 0;
		int fourty = 0;
		int olderFifty = 0;
		
		for(MemberVO m : list) {
			switch(m.getMage() / 10) {
			case 1:
				teen++;
				break;
			case 2:
				twenty++;
				break;
			case 3:
				thirty++;
				break;
			case 4:
				fourty++;
				break;
			default:
				olderFifty++;
			}
		}
		
		agePercent[0] = Math.round((((double)teen / list.size()) * 100) * 10.0) / 10.0;			// 10대
		agePercent[1] = Math.round((((double)twenty / list.size()) * 100) * 10.0) / 10.0;		// 20대
		agePercent[2] = Math.round((((double)thirty / list.size()) * 100) * 10.0) / 10.0;		// 30대
		agePercent[3] = Math.round((((double)fourty / list.size()) * 100) * 10.0) / 10.0;		// 40대
		agePercent[4] = Math.round((((double)olderFifty / list.size()) * 100) * 10.0) / 10.0;	// 50대
		
		return agePercent;
	}

	@Override
	public double[] readLocation(int pNum) throws Exception {
		MapVO map = dao.readLocation(pNum);
		String slat = map.getLat();
		String slng = map.getLng();
		double[] location = new double[2];
		location[0] = Double.parseDouble(slat);
		location[1] = Double.parseDouble(slng);
		return location;
	}

	@Override
	public void increaseView(HttpSession session, int pNum) throws Exception {
		Set<Integer> visitedPosts = (Set<Integer>) session.getAttribute("visitedPosts");
		
		if(visitedPosts == null) {
			visitedPosts = new HashSet<>();
			session.setAttribute("visitedPosts", visitedPosts);
		}
		
		if(!visitedPosts.contains(pNum)) {
			dao.increaseView(pNum);
			visitedPosts.add(pNum);
		}
	}
	
	@Override
	public int findJoinMember(int pNum, int mNum) throws Exception {
		int result = dao.findJoinMember(pNum, mNum);
		return result;
	}

	@Override
	public void joinMember(int pNum, int mNum) throws Exception {
		dao.joinMember(pNum, mNum);
	}
	
	@Override
	public void increaseJoinCnt(int mNum) throws Exception {
		dao.increaseJoinCnt(mNum);
	}
}
