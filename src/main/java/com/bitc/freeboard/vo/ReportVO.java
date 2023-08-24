package com.bitc.freeboard.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ReportVO {

	int no;
	String fromMid;
	String toMid;
	Date date;
	String category;
	String context;
	int bno;
	int cno;
	
}
