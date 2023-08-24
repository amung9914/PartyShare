package com.bitc.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
	@Select("SELECT * FROM member ORDER BY mNum ")
	public List<MemberVO> memberList() throws Exception;	// adminDAO
	
	@Select("SELECT * FROM member WHERE mId = #{id}")
	public MemberVO selectMember(String id) throws Exception;	// adminDAO
	

	@Update("UPDATE member SET mBlackYN = 'Y' WHERE mId = #{targetId}")
	public int blackMember(String targetId);	// adminDAO
	

	


	

	

	
	
}
