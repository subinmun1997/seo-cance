package com.trip.seocance.dto;

import com.trip.seocance.domain.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/*
 * 플래너 DTO 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class PlannerDTO {

    private Long plannerNo;
    private Member member;
    private String title;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date lDate;

    private String intro;
    private Date wDate;

//    public void setFDate(String fDate) throws ParseException {
//        SimpleDateFormat fm  = new SimpleDateFormat("yyyy-MM-dd");
//        Date first_date = fm.parse(fDate);
//        this.fDate = first_date;
//    }
//
//    public void setLDate(String lDate) throws ParseException {
//        SimpleDateFormat fm  = new SimpleDateFormat("yyyy-MM-dd");
//        Date last_date = fm.parse(lDate);
//        this.lDate = last_date;
//    }
//
//    public void setWDate(String WDate) throws ParseException {
//        SimpleDateFormat fm  = new SimpleDateFormat("yyyy-MM-dd");
//        Date write_date = fm.parse(WDate);
//        this.wDate = write_date;
//    }
}
