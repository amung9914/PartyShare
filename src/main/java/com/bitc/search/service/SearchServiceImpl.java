package com.bitc.search.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.party.vo.PartyVO;
import com.bitc.search.dao.SearchDAO;
import com.bitc.search.vo.CategoryVO;
import com.bitc.search.vo.descriptionVO;

import lombok.RequiredArgsConstructor;

@Service("ss")
@RequiredArgsConstructor
public class SearchServiceImpl implements SearchService {
	
	private final SearchDAO dao;

	
//	@Override
//	public List<CategoryVO> getCategory() throws Exception  {
//		return dao.getCategory(); // searchCategory
//	}
//	
//	public List<CategoryVO> mainCategory() throws Exception{
//		return dao.mainCategory(); 
//	}
	
	/**
	 * @param 검색 목록에서 선택하는 target
	 * @return 반환시 검색 쿼리에 저장되는 Object타입 
	 * */
	public Object printContents(String targetContents) throws Exception {
		// 문자열 매개로 Object반환
		Object contents =null;
		if(targetContents.equals("category")) {
			contents = dao.categoryList();
		}else if(targetContents.equals("date")) {
			contents = dao.dateIndex();  // 대기중
		}else if(targetContents.equals("location")) {
			String query = " SELECT distinct sido  FROM location ";
			contents = dao.sido(query); // 대기중
		}else {
			System.out.println(targetContents + "가 sido로 전달됨");
			String query = "SELECT * FROM location WHERE sido = '" +targetContents +"' ";
			contents = dao.sigungu(query);
		} // dao.location 메소드로 location ( sido, sigungu는 모두 출력됨) 
			// 나머지 것들이 아닐 때 -> targetContents == 서울특별시, 울산광역시 
			// 이걸 query에 등록해서  dao호출!
		// 같은 이름으로 실행해서 list.sigungu로 받아올 수 있음
		
		return contents;
	}	//ssi


	@Override
	public List<PartyVO> partySearch(String input) throws Exception {
		System.out.println("serviceImpl : " + input);
		return dao.partySearch(input);
	}	//ssi


	public List<descriptionVO> description(int page) throws Exception {
		int start = ((page-1)*10)+1;
		System.out.println("start:" + start);
		return dao.description(start);
	}	//ssi


	@Override
	public int countPartyDescription() throws Exception {
		
		return dao.countPartyDescription();
	}	//ssi
	
	@Override
	public String addCategory(CategoryVO vo) throws Exception {
		String message="";
		int result = dao.addCategory(vo);
		message = (result == 1)? "addCategory O":"addCategory X ";
		return message;
	}	//ssi

	@Override
	public List<descriptionVO> partyDescriptionList() throws Exception {
		return dao.partyDescriptionList();
	}	//ssi
	

	public String addDescription(descriptionVO vo) throws Exception {
		String message="";
		int result = dao.addDescription(vo);
		message = (result == 1)? "addDescription O":"addDescription X ";
		return message;
	}	//ssi


	@Override
	public List<CategoryVO> partyCategoryList() throws Exception {
		return dao.partyCategoryList();
	}	//ssi
	
	

}
