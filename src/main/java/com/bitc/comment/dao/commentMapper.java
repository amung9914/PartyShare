package com.bitc.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.common.utils.Criteria;

public interface commentMapper {

	@Insert("INSERT INTO freeboard_comment(cno, bno, commentText, mnick, mid, regdate, showBoard) VALUES(null, #{bno}, #{commentText}, #{mnick}, #{mid}, now(), 'Y')")
	public int addComment(FreeBoardCommentVO vo) throws Exception;

	@Select("SELECT * FROM freeboard_comment WHERE bno = #{bno} ORDER BY cno ASC LIMIT #{cri.startRow}, #{cri.perPageNum}")
	public List<FreeBoardCommentVO> commentListPage(@Param("cri") Criteria cri, @Param("bno") int bno) throws Exception;

	@Select("SELECT COUNT(*) FROM freeboard_comment WHERE bno = #{bno}")
	public int commentTotalCount(int bno) throws Exception;

	@Update("UPDATE freeboard_comment SET commentText = #{commentText} WHERE cno = #{cno}")
	public int updateComment(FreeBoardCommentVO vo) throws Exception;

	@Delete("DELETE FROM freeboard_comment WHERE cno = #{cno}")
	public int deleteComment(int cno) throws Exception;
	
}
