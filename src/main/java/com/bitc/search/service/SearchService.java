package com.bitc.search.service;

import java.util.List;

import com.bitc.common.utils.Criteria;
import com.bitc.party.vo.PartyVO;
import com.bitc.search.vo.CategoryVO;
import com.bitc.search.vo.descriptionVO;



public interface SearchService  {
	
	
	
//	public List<CategoryVO> getCategory() throws Exception; 
	
	/**
	 * @param
	 * @return
	 * */
	public Object printContents (String targetContents) throws Exception;	//ss
	
	
	
	public List<PartyVO> partySearch(String input) throws Exception;	//ss
	
	/**
	 * @retrun List<descriptionVO>, 
	 * 처음에 출력하기 위해 printContents와 따로 배치
	 * */
	public List<descriptionVO> description(Criteria cri) throws Exception;	//ss
	
	public int countPartyDescription() throws Exception;	//ss
	
	/**
	 * @param categoryList에 카테고리 추가 / description/category
	 * */
	String addCategory(CategoryVO vo)throws Exception;	//searchService
	
	/**
	 * @return 관리자 검색창 관리 페이지에 categoryList 출력
	 * */
	List<CategoryVO> partyCategoryList() throws Exception;	//searchService
	
	
	
	/**
	 * @return 파티 설명 리스트 for 관리자
	 * */
	List<descriptionVO> partyDescriptionList() throws Exception;	//searchService



	public String addDescription(descriptionVO vo) throws Exception;	// ss
}
