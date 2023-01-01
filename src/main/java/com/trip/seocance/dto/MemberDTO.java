package com.trip.seocance.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/*
 * 멤버 DTO 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/01
 */

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class MemberDTO {

    private String id;
    private String password;
    private String name;
    private String nickname;
    private String member_img;
    private Date birth;
    private String gender;
    private String email;
    private String phone;
    private Character crleader;

    public void setBirth(String birth) throws ParseException {
        SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
        Date date_birth = fm.parse(birth);
        System.out.println("setbirth : " + date_birth);
        this.birth = date_birth;
    }

}
