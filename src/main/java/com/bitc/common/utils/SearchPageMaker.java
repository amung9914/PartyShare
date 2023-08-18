package com.bitc.common.utils;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class SearchPageMaker extends PageMaker{

	@Override
	public String mkQueryStr(int page) {
		SearchCriteria sCri = (SearchCriteria)cri;
		//쿼리스트링 만들어줌
		UriComponents uriComponentsents = 
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", sCri.getSearchType())
				.queryParam("keyword",sCri.getKeyword())
				.build();
		String query = uriComponentsents.toUriString();
		return query;
	}

	
	
}
