package com.bitc.search.dao;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bitc.party.vo.PartyVO;
import com.bitc.search.vo.CategoryVO;
import com.bitc.search.vo.LocationVO;
import com.bitc.search.vo.descriptionVO;

public interface SearchDAO {
	
	
	/**
	 * 전체 카테고리VO 검색, 초기화함수 , 매개변수 없음 
	 * */
	@Select("SELECT * FROM partycategory")
	public List<CategoryVO> categoryList() throws Exception;	// searchDAO
	/**
	 * 
	 * 전체 파티설명VO 검색, 초기화함수 , 매개변수 없음 
	 * */
	@Select("SELECT * FROM partydescription limit #{start} , 18")   //mainCategory DISTINCT
	public  List<descriptionVO>  description(int start) throws Exception;	// searchDAO
	
	/**
	 * @param 날짜수
	 * */
	@Select("SELECT * FROM party_table WHERE ")
	public PartyVO dateSearch(LocalDate localDate) throws Exception;  // 날짜 값을 입력받아서 ( 캘린더 필요함 ) 
	
	
	@Select("SELECT * FROM dateIndex ORDER BY DATE ")
	public List<Integer> dateIndex() throws Exception;	// searchDAO
	//public 
	@Select("SELECT distinct sido  FROM location")
	public List<LocationVO> location() throws Exception;	// searchDAO
	
	/**
	 * WHERE절부터는 util이 담당
	 * */ // 칼럼 명을 봐야 파라미터 자리라고 본다? 문자열이 
	@Select("${finalQuery}")   // Parameter index out of range (1 > number of parameters, which is 0).
	public List<PartyVO> partySearch(@Param("finalQuery") String finalQuery) throws Exception;	// searchDAO
	
	@Select("${sidoQuery}")
	public List<LocationVO> sido(@Param("sidoQuery") String sidoQuery ) throws Exception;	// searchDAO
	
	@Select("${sigunguQuery}")
	public List<LocationVO> sigungu(@Param("sigunguQuery") String sigunguQuery ) throws Exception;	// searchDAO
	//@select("SELECT * FROM pa")
	
	@Select("SELECT count(*) FROM partydescription")
	public int countPartyDescription() throws Exception;	// searchDAO
	
	@Select("SELECT * FROM partydescription")
	public List<descriptionVO> partyDescriptionList() throws Exception;	// searchDAO
	/**
	 * @param n일 후 입력
	 * @return n일 후를 반환
	 * */
	@Select("SELECT * FROM partycategory")
	public List<CategoryVO> partyCategoryList() throws Exception;	//searchDAO
	
	
	/**
	 * @return 파티 카테고리 추가
	 * */
	@Insert("INSERT INTO partycategory (category) VALUES (#{category})")
	public int addCategory(CategoryVO vo) throws Exception;	 //searchDAO
	
	/**
	 * @return 파티 설명 목록 추가
	 * */
	@Insert("INSERT INTO partydescription (description) VALUES (#{description})")	
	public int addDescription(descriptionVO vo) throws Exception;	//searchDAO
	
	
	
	
	
}
