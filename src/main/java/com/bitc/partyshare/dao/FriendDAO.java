package com.bitc.partyshare.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.partyshare.vo.FriendVO;
import com.bitc.partyshare.vo.MemberVO;

public interface FriendDAO {

	/**
	 * 아이디로 친구를 검색한다.
	 */
	@Select("SELECT * FROM member WHERE mid LIKE CONCAT('%',#{target},'%') ORDER BY mid")
	List<MemberVO> searchId(String target) throws Exception;
	
	/**
	 * 닉네임으로 친구를 검색한다.
	 */
	@Select("SELECT * FROM member WHERE mnick LIKE CONCAT('%',#{target},'%') ORDER BY mid")
	List<MemberVO> searchNick(String target) throws Exception;
	
	
	/**
	 * 상대방이 친구요청을 보낸다.
	 */
	@Insert("INSERT INTO friend(fFrom,fTo) "
			+ "VALUES (#{ffrom},#{fto})")
	int create(FriendVO vo) throws Exception;
	
	/**
	 * 상대방의 아이디로 상대방의 파티 정보를 가져온다. 
	 * mnum으로 -> joinparty & party -> partyVO
	 */
	
	/**
	 * 친구 요청에 이미 요청이 있는지 없는지 확인
	 */
	@Select("SELECT * FROM friend WHERE ffrom = #{ffrom} AND fto = #{fto} AND YN = 'N'")
	FriendVO confirmRequest(FriendVO vo) throws Exception;
	
	/**
	 * 이미 친구인지 아닌지 확인
	 */
	@Select("SELECT * FROM friend WHERE ffrom = #{ffrom} AND fto = #{fto} AND YN = 'Y'")
	FriendVO confirmFriend(FriendVO vo) throws Exception;
	
	
	//상대방이 수락을 눌렀을 때 
	// from 유저 to 유저 두명을 각각 db에 저장시킨다. 
	// 서로서로 친구 맺기
	
	/**
	 * 내가 to 유저, to유저로 찾아서 update Y,
	 */
	@Update("UPDATE friend SET YN = 'Y' "
			+ "WHERE ffrom = #{ffrom} AND fto = #{fto}")
	int accept(
			@Param("ffrom")int ffrom, 
			@Param("fto")int fto) throws Exception;
	// 내가 from유저로 to유저 Y로 추가
	@Insert("INSERT INTO friend(fFrom,fTo,YN) "
			+ "VALUES (#{ffrom},#{fto},'Y')")
	int acceptNew(
			@Param("fto")int ffrom, 
			@Param("ffrom")int fto) throws Exception;

	/**
	 * 기존 친구를 삭제 시킨다.
	 */
	
	/**
	 * 내가 친구 요청을 보낸 목록을 확인
	 */
	@Select("SELECT F.*, M.mid, M.mnick FROM friend F, member M "
			+ "	WHERE F.fto = M.mnum AND YN = 'N' AND ffrom = #{ffrom}")
	List<FriendVO> requestList(int ffrom) throws Exception;

	/**
	 * 내가 친구 요청 받은 목록을 확인
	 */
	@Select("SELECT F.*, M.mid, M.mnick FROM friend F, member M "
			+ "	WHERE F.ffrom = M.mnum AND YN = 'N' AND fto = #{fto}")
	List<FriendVO> responseList(int fto) throws Exception;
	
	/**
	 * 친구목록을 불러온다
	 */
	@Select("SELECT F.*, M.mid, M.mnick FROM friend F, member M "
			+ "	WHERE F.fto = M.mnum AND YN = 'Y' AND ffrom = #{ffrom}")
	List<FriendVO> friendList(int ffrom) throws Exception;
	

	/**
	 * 내가 보낸 친구 요청을 취소한다.  
	 */
	@Delete("DELETE FROM friend WHERE ffrom = #{ffrom} AND fto = #{fto} AND YN = 'N'")
	int deleteRequest(FriendVO vo) throws Exception;
	
	/**
	 * 거절을 눌렀을 때 친구 요청을 삭제 시킨다.
	 */
	@Delete("DELETE FROM friend WHERE ffrom = #{ffrom} AND fto = #{fto} AND YN = 'Y'")
	int reject(
			@Param("ffrom")int ffrom, 
			@Param("fto")int fto) throws Exception;
}
