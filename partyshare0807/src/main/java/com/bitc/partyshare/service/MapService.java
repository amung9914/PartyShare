package com.bitc.partyshare.service;

import java.util.List;
import java.util.Map;

import com.bitc.partyshare.vo.MapVO;

public interface MapService {

	/**
	 * 전체 위치 리스트
	 */
	List<MapVO> mapList()throws Exception;
		
		/**
		 * 위치 삽입
		 */
		String addLocation(MapVO vo) throws Exception;
		
		/**
		 * 위치 수정
		 */
		String updateLocation(MapVO vo) throws Exception;
		
		/**
		 * 위치 삭제
		 */
		String deleteLocation(int pnum) throws Exception;

		Map<String,String> getNameTag(int pnum);
	}

