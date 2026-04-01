package org.triptogether.courses.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.triptogether.courses.service.TravelPlanService;

@Controller
@RequestMapping("/plan")
public class TravelPlanController {

    private TravelPlanService travelPlanService;

}
