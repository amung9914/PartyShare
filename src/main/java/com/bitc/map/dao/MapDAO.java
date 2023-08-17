package com.bitc.map.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.map.vo.MapVO;

public interface MapDAO {
	
	/**
	 * 전체 파티목록
	 */
	@Select("SELECT * FROM map ORDER BY pnum DESC")
	List<MapVO> mapList()throws Exception;
	
	/**
	 * 신규 파티 위치 등록 
	 */
	@Insert("INSERT INTO map(pnum,lat,lng) "
			+ "VALUES(#{pnum},#{lat},#{lng})")
	int insert(MapVO vo) throws Exception;
	
	/**
	 * 파티 위치 가져오기
	 */
	@Select("SELECT * FROM map WHERE pnum = #{pnum}")
	MapVO read(int pnum) throws Exception;
	
	/**
	 * 파티위치 수정 
	 */
	@Update("UPDATE map SET lat = #{lat}, lng = #{lng} WHERE pnum = #{pnum}")
	int update(MapVO vo) throws Exception;
	
	/**
	 * 파티위치 삭제 
	 */
	@Delete("DELETE FROM map WHERE pnum = #{pnum}")
	int delete(int pnum) throws Exception;
	
	/**
	 * @param pnum
	 * @return 파티 이름, host 이름(pname,host)
	 */
	@Select("SELECT pname, mnick AS host FROM party P, member M WHERE P.host = M.mnum AND pnum = #{pnum} ")
	Map<String,String> nameTagList(int pnum);
}
