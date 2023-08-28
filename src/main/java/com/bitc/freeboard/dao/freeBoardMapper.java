package com.bitc.freeboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.report.vo.ReportVO;

public interface freeBoardMapper {

	@Select("SELECT COUNT(*) FROM freeboard WHERE category = '일반'")
	public int totalCount() throws Exception;
	
	@Select("SELECT COUNT(*) FROM freeboard WHERE title LIKE CONCAT('%', #{keyword}, '%')")
	public int totalCountTitle(FreeBoardVO vo) throws Exception;

	@Select("SELECT COUNT(*) FROM freeboard WHERE context LIKE CONCAT('%', #{keyword}, '%')")
	public int totalCountContext(FreeBoardVO vo) throws Exception ;
	
	@Select("SELECT COUNT(*) FROM freeboard WHERE mnick LIKE CONCAT('%', #{keyword}, '%')")
	public int totalCountWriter(FreeBoardVO vo) throws Exception;
	
	@Select("SELECT * FROM freeboard WHERE category = '공지' ORDER BY bno DESC")
	public List<FreeBoardVO> readFreeBoardNotice() throws Exception;

	@Select("SELECT * FROM freeboard WHERE category = '일반' ORDER BY origin DESC, seq ASC LIMIT #{startRow}, #{perPageNum}")
	public List<FreeBoardVO> readFreeBoard(Criteria cri) throws Exception;
	
	@Insert("INSERT INTO freeboard(bno, category, title, context, date, mNick, viewCnt, showBoard, mid, origin, depth, seq) VALUES (null, #{category}, #{title}, #{context}, NOW(), #{mnick}, 0, 'Y', #{mid}, 0, 0, 0)")
	public int freeBoardUpload(FreeBoardVO vo) throws Exception;

	@Update("UPDATE freeboard SET origin = LAST_INSERT_ID() WHERE bno = LAST_INSERT_ID()")
	public int updateOrigin() throws Exception;
	
	@Update("UPDATE freeboard SET viewCnt = viewCnt + 1 WHERE bno = #{bno}")
	public void updateFreeBoardCnt(int bno) throws Exception;

	@Select("SELECT * FROM freeboard WHERE bno = #{bno}")
	public FreeBoardVO readFreeBoardDetail(int bno) throws Exception;

	@Update("UPDATE freeboard SET title = #{title}, context = #{context} WHERE bno = #{bno}")
	public int freeBoardModify(FreeBoardVO vo) throws Exception;

	@Delete("DELETE FROM freeboard WHERE bno = #{bno}")
	public int freeBoardRemove(int bno) throws Exception;

	@Select("SELECT * FROM freeboard WHERE title LIKE CONCAT('%', #{vo.keyword}, '%') ORDER BY origin DESC, seq ASC LIMIT #{cri.startRow}, #{cri.perPageNum}")
	public List<FreeBoardVO> getSearchListTitle(@Param("cri") Criteria cri, @Param("vo") FreeBoardVO vo) throws Exception;

	@Select("SELECT * FROM freeboard WHERE context LIKE CONCAT('%', #{vo.keyword}, '%') ORDER BY origin DESC, seq ASC LIMIT #{cri.startRow}, #{cri.perPageNum}")
	public List<FreeBoardVO> getSearchListContext(@Param("cri") Criteria cri, @Param("vo") FreeBoardVO vo) throws Exception;

	@Select("SELECT * FROM freeboard WHERE mnick LIKE CONCAT('%', #{vo.keyword}, '%') ORDER BY origin DESC, seq ASC LIMIT #{cri.startRow}, #{cri.perPageNum}")
	public List<FreeBoardVO> getSearchListWriter(@Param("cri") Criteria cri, @Param("vo") FreeBoardVO vo) throws Exception;
	
	@Insert("INSERT INTO report VALUES (null, #{fromMid}, #{toMid}, NOW(), #{category}, #{context}, null, #{cno})")
	public int reportFreeBoardComment(ReportVO vo) throws Exception;
	
	@Insert("INSERT INTO report VALUES (null, #{fromMid}, #{toMid}, NOW(), #{category}, #{context}, #{bno}, null)")
	public int reportFreeBoard(ReportVO vo) throws Exception;
	
	@Update("UPDATE freeboard SET seq = seq + 1 WHERE origin = #{origin} AND seq > #{seq}")
	public void updateReply(FreeBoardVO vo) throws Exception;
	
	@Insert("INSERT INTO freeboard(category, title, context, date, mnick, viewCnt, mid, origin, depth, seq) VALUES(#{category}, #{title}, #{context}, NOW(), #{mnick}, 0, #{mid}, #{origin}, #{depth}, #{seq})")
	public void replyRegister(FreeBoardVO vo) throws Exception;
	
}
