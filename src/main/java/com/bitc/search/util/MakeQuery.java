package com.bitc.search.util;

import java.util.Arrays;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;

/**
 * 검색에서 활용 %n
 * 문자열 다듬기 
 * */
@Component("mq")
public class MakeQuery {
	
//	private String finalQuery = "";
	
	// 검색 기준 : 카테고리는 description과 category의 조합으로 이루어짐 
	/**
	 * @param 검색창의 박스를 조합해서 나온 하나의 문자열 
	 * @return WHERE 과 AND를 활용할 수 있는 SQL용 문자열
	 * */
	public static String addStirng(String input) {
		// delemeter로 받자 
		//	delemeter 3개로 작성해야 함에 유의 
		// String input은 "description|""|"date"|location"으로 도착한다.
		System.out.println("Makequery addString 입력 :" + input);
		String finalQuery = "SELECT * FROM party WHERE finish = 'N' ";
		
		
		if(input.equals("noValue|noValue|noValue|noValue|noValue")) {
			finalQuery = "SELECT * FROM party WHERE finish = 'N' ";
		}     // 젤 먼저 로드되었을 때 resultQ로 1회 호출 -> 전체 파티 검색
        String[] result = input.split("\\|");
        System.out.println(Arrays.toString(result));
        // "WHERE" -> "SELECT * FROM party WHERE"
        
        if(!result[0].equals("noValue")) {
        	finalQuery +=" AND description = '"+result[0]+"'";
        }
        if(!result[1].equals("noValue")) {
        	finalQuery +=" AND category = '"+result[1]+"'";
        }
        if(!result[2].equals("noValue")) {
        	finalQuery +=" AND  startDate >= NOW() + INTERVAL "+result[2]+" DAY ";// AND date <= NOW()";  
        	//result[2] ==숫자 자리  date >= NOW() - INTERVAL 1 DAY AND date <= NOW()
        }
        if(!result[3].equals("noValue")) {
        	finalQuery +=" AND sido = '"+result[3]+"'";
        }
        if(!result[4].equals("noValue")) {
        	finalQuery +=" AND sigungu = '"+result[4]+"'";
        }	// 전달페이지에서 resultQ = location 나누기 - > 5개 짜리로
        if(!result[5].equals("noValue")) {
        	finalQuery +=" AND pName Like '%"+result[5]+"%'";
        }
        finalQuery = finalQuery + ";";
        System.out.println("Makequery addString final :" + finalQuery);
        
		return finalQuery;
	}
	
	
	/**
	 * UPDATE 성공 실패 여부를 문자열로 반환
	 * */
	public static String stringResult (int no) {
		
		return no == 1 ? "처리되었습니다." : "처리하지 못했습니다.";
	}
	
}