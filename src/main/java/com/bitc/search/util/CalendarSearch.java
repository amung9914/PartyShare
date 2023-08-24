package com.bitc.search.util;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Data;
@Data
@Component("CalendarSearch")
public class CalendarSearch {
	private LocalDateTime today;
	private List<LocalDateTime> days;
	
	
	//홈에서 <n일 이내 일정> 이라는 태그의 Integer value로 n을 받아온다.
	
	// n일 후 날짜를 반환하는 계산기
	public LocalDateTime plusDays(int n) {
	//	LocalDateTime currentDate = LocalDateTime.now();
	//	LocalDateTime newDate = currentDate.plus(n); // plusDays를 정의해야 함
		return LocalDateTime.now();
	}


	//plucDays
	
	public LocalDateTime plus(int n) {
		
		return LocalDateTime.now();
	}


	public CalendarSearch() {
		this.today = LocalDateTime.now();
		this.days = new ArrayList<>(); 
//		days.add(1);
//		days.add(7);
//		days.add(14);
//		days.add(30);
//		days.add(90);
	}
	
}
