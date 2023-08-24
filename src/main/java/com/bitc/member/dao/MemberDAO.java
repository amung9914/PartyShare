package com.bitc.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

public interface MemberDAO {

	/**
	 * test용 로그인 
	 */
	@Select("SELECT * FROM member WHERE mid = #{mid} AND mpw = #{mpw}")
	MemberVO login(MemberVO vo) throws Exception;
	
	// 회원 번호로 회원 정보 검색 
		@Select("select * from member where mnum=#{mnum}")
		public MemberVO selectMember(int mnum) throws Exception;
		
		// 회원 정보 수정
		@Update("UPDATE member SET mpw=#{mpw}, mname=#{mname}, mage=#{mage}, mgender=#{mgender}, maddr=#{maddr}, profileImageName=#{profileImageName} WHERE mnum=#{mnum}")
		public int modifyMember(MemberVO member) throws Exception;
		
		@Select("SELECT * FROM party WHERE pnum IN (SELECT pnum FROM joinMember WHERE mnum=#{mnum}) ORDER BY pnum DESC limit #{cri.startRow}, #{cri.perPageNum}")
		public List<PartyVO> joinPartyList(@Param("mnum") int mnum, @Param("cri") Criteria cri) throws Exception;
		
		@Select("SELECT count(*) FROM joinMember WHERE mnum=#{mnum}")
		public int joinCnt(int mnum) throws Exception; 
	
}
