package com.trip.seocance.configuration;

import com.trip.seocance.util.UploadCrewFileUtil;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/*
 * Configuration 클래스
 *
 * @Author 문수빈
 * @Date 2023/01/09
 */

@Configuration
public class SeoCanceConfiguration {

    @Bean
    public ModelMapper modelMapper() {
        return new ModelMapper();
    }

    @Bean
    public UploadCrewFileUtil uploadCrewFileUtil() {
        return new UploadCrewFileUtil(uploadPath());
    }

    //파일 저장될 절대 경로(로컬)
    @Bean(name = "uploadPath")
    public String uploadPath() {
        return System.getProperty("user.dir") + "/src/main/resources/static/_image";
    }


}
