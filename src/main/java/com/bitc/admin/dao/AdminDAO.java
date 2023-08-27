package com.bitc.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.member.vo.MemberVO;

public interface AdminDAO {
	
	/**
	 * 
	 * @param mainCategory subCategory
	 * 를 받아와 
	 * 추가된 열을 
	 * @return 1 or 0
	 * */
//	@Insert("INSERT INTO category (category) VALUES (#{category}")
//	public int addCategory(CategoryVO vo) throws Exception;
	@Select("SELECT * FROM member ORDER BY mnum  LIMIT #{cri.startRow}, #{cri.perPageNum}")
	public List<MemberVO> memberList(@Param("cri") Criteria cri) throws Exception;	// adminDAO
	
	@Select("SELECT * FROM member WHERE mnick = #{mnick}")
	public MemberVO selectMember(String mnick) throws Exception; // adminDAO
	

	@Update("UPDATE member SET mblackYN = 'Y' WHERE mid = #{targetId}")
	public int blackMember(String targetId);	// adminDAO
	
	@Select("SELECT * FROM member WHERE mnick LIKE CONCAT('%', #{mnick}, '%')")
	public List<MemberVO> memberNick(String mnick) throws Exception;
	


	

	

	
	
}
