package com.bitc.partyshare.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.ui.Model;

import com.bitc.partyshare.vo.MemberVO;
import com.bitc.partyshare.vo.PartyVO;

public interface PartyService {

	/**
	 * 내가 호스트인 파티 목록
	 */
	List<PartyVO> HostingList(HttpSession session) throws Exception;
	
	/**
	 * 내가 참여중인 파티 목록
	 */
	List<PartyVO> myPartyList(HttpSession session) throws Exception;
	
	/**
	 * 파티 상세정보 출력 
	 */
	PartyVO read(int pnum, Model model) throws Exception;
	
	/**
	 * 파티 정보 수정
	 */
	String update(PartyVO vo) throws Exception;

	/**
	 * 파티 사진 수정
	 */
	String updateImage(PartyVO vo) throws Exception;

	
	/**
	 * description 목록
	 */
	List<String> description() throws Exception;
	
	/**
	 * category 목록
	 */
	List<String> category() throws Exception;
	

}
