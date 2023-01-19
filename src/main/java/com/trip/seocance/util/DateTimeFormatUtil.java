package com.trip.seocance.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/*
 * 날짜 시간 포맷 변경 유틸
 *
 * @Author 문수빈
 * @Date 2023/01/19
 */
public class DateTimeFormatUtil {
    public static String changeToYMD(LocalDateTime dateTime) {
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    public static String changeToYMDHM(LocalDateTime dateTime) {
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm"));
    }
}
