package org.triptogether.courses.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.triptogether.courses.service.TravelPlanService;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

@Controller
@RequestMapping("/courses")
public class TravelPlanController {
    @Autowired
    private TravelPlanService travelPlanService;

    @GetMapping("/list")
    public String list(Model model){
        TravelPlanVO travelPlanVO = new TravelPlanVO();
        travelPlanVO.setUser_idx(1L);

        List<TravelPlanVO> list = travelPlanService.getTravelList(travelPlanVO);
        model.addAttribute("list", list);

        return "travelplan/list";
    }

}
