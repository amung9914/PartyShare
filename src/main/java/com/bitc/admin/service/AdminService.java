package com.bitc.admin.service;

import java.util.List;

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
	List<MemberVO> memberList() throws Exception;	//adminService

	
	/**
	 * @param 신고 대상의 ID 
	 * @return 블랙을 하면 1 
	 * */
	
	int blackMember(String targetId) throws Exception;	//adminService
	

	
	
	
	
	

	
	
}
