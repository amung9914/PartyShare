package com.bitc.notice.vo;


import java.time.LocalDateTime;

import lombok.Data;

@Data
public class NoticeVO {
	private int noticeNum;
	private java.util.Date Date;
//	private LocalDateTime Date;
	private String context;
	private String readed;
	private String mId;
}
