package com.redhat.developergames;

import javax.servlet.http.HttpSession;

import com.redhat.developergames.config.InfinispanConfiguration;
import com.redhat.developergames.model.Weather;
import com.redhat.developergames.repository.WeatherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.cache.annotation.EnableCaching;
import org.infinispan.spring.remote.session.configuration.EnableInfinispanRemoteHttpSession;

@SpringBootApplication
@EnableCaching
@EnableInfinispanRemoteHttpSession(cacheName = InfinispanConfiguration.SESSION_CACHE)
@RestController
public class WeatherApp {

   private static final String SESSION_LAST_LOCATION = "LAST_LOCATION";

   @Autowired
   WeatherRepository weatherRepository;

   @GetMapping("/")
   public String index() {
      return "Greetings from Spring Boot with Data Grid!";
   }

   @GetMapping("/weather/{location}")
   public Object getByLocation(@PathVariable String location, HttpSession session) {
      session.setAttribute(SESSION_LAST_LOCATION, location);
      Weather weather = weatherRepository.getByLocation(location);
      if (weather == null) {
         return String.format("Weather for location %s not found", location);
      }
      return weather;
   }

   @GetMapping("/latest")
   public String latestLocation(HttpSession session) {
       return (String) session.getAttribute(SESSION_LAST_LOCATION);
   }

   public static void main(String... args) {
      new SpringApplicationBuilder().sources(WeatherApp.class).run(args);
   }
}
