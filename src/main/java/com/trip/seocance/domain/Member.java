package com.trip.seocance.domain;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

/*
 * 멤버 Entity
 *
 * @Author 문수빈
 * @Date 2022/12/31
 */
@Entity
@Table(name="MEMBER_TBL")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Member {
    @Id
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
}
