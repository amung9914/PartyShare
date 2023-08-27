package com.bitc.admin.service;

import java.util.List;

import com.bitc.common.utils.Criteria;
import com.bitc.member.vo.MemberVO;



public interface AdminService {
	
	
	
	/**
	 *@retun id가 일치하는 memberVO
	 * 
	 * */
	MemberVO selectMember (String id)throws Exception;	//adminService
	
	/**
	 * @return 관리자가 불러오는 전체 member 리스트
	 * */
	List<MemberVO> memberList(Criteria cri) throws Exception;	//adminService

	
	/**
	 * @param 신고 대상의 ID 
	 * @return 블랙을 하면 1 
	 * */
	
	int blackMember(String targetId) throws Exception;	//adminService
	
	/**
	 * 닉네임으로 멤버 검색 신고 대상 목록
	 * */
	List<MemberVO> memberNick(String mnick) throws Exception;
	
	
	
	
	

	
	
}
