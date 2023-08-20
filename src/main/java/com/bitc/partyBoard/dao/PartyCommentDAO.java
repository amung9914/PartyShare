package com.bitc.partyBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.partyBoard.vo.PartyCommentDTO;
import com.bitc.partyBoard.vo.PartyCommentVO;

public interface PartyCommentDAO {

	
	/**
	 * 페이징 처리
	 * @return - 페이징 처리된 게시글 목록 
	 */
	@Select("SELECT * FROM partyboard_comment "
			+ " WHERE pnum = #{pnum} AND bno = #{bno} ORDER BY cno DESC "
			+ " limit #{cri.startRow}, #{cri.perPageNum}")
	List<PartyCommentVO> listPage(PartyCommentDTO dto) throws Exception;
	
	/**
	 * @param 삽입될 댓글 정보
	 * @return - 삽입된 행의 개수
	 */
	@Insert("INSERT INTO partyboard_comment(pnum,bno,commentText,mnick,mid) "
			+ "VALUES(#{pnum},#{bno},#{commentText},#{mnick},#{mid})")
	int insert(PartyCommentVO vo) throws Exception;
	
	/**
	 * 등록한 댓글 가져오기
	 */
	@Select("SELECT * FROM partyboard_comment WHERE cno = LAST_INSERT_ID()")
	PartyCommentVO read() throws Exception;
	
	/**
	 * @param 수정할 댓글 정보
	 * @return 수정된 행의 개수
	 */
	@Update("UPDATE partyboard_comment SET "
			+ " commentText = #{commentText} , "
			+ " updatedate = now() "
			+ " WHERE cno = #{cno} AND pnum = #{pnum} AND bno = #{bno}")
	int update(PartyCommentVO vo) throws Exception;
	
	/**
	 * @param 삭제할 댓글 번호
	 * @return 삭제된 행의 개수
	 */
	@Delete("DELETE FROM partyboard_comment WHERE cno = #{cno} "
			+ "AND pnum = #{pnum} AND bno = #{bno}")
	int delete(PartyCommentVO vo) throws Exception;
	
	
	
	
}
