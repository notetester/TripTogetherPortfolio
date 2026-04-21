package org.triptogether.courses.service;

import org.springframework .beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.triptogether.courses.mapper.TravelPlanMapper;
import org.triptogether.courses.vo.PlanSpotVO;
import org.triptogether.courses.vo.SpotTravelVO;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

@Service
public class TravelPlanServiceImpl implements TravelPlanService {

    @Autowired
    private TravelPlanMapper travelPlanMapper;

    @Override
    public List<TravelPlanVO> getTravelList(TravelPlanVO travelPlanVO) {
        return travelPlanMapper.getTravelList(travelPlanVO);
    }

    @Override
    public TravelPlanVO getTravelPlanDetail(TravelPlanVO travelPlanVO) {
        TravelPlanVO detail = travelPlanMapper.getTravelPlanDetail(travelPlanVO);

        if (detail != null) {
            detail.setSpotList(
                    travelPlanMapper.getPlanSpotListByPlanId(detail.getPlan_id())
            );
            System.out.println("spotList = " + detail.getSpotList());
            System.out.println("spotList size = " + detail.getSpotList().size());
        }

        return detail;
    }

    @Override
    public List<SpotTravelVO> getSpotTravelList() {
        return travelPlanMapper.getSpotTravelList();
    }

    @Override
    public void insertTravelPlan(TravelPlanVO travelPlanVO) {
        travelPlanMapper.insertTravelPlan(travelPlanVO);

        if (travelPlanVO.getSpotList() != null && !travelPlanVO.getSpotList().isEmpty()) {
            int order = 1;
            for (PlanSpotVO spot : travelPlanVO.getSpotList()) {

                if (spot.getSpot_id() != null && spot.getSpot_id().trim().isEmpty()) {
                    spot.setSpot_id(null);
                }

                if (spot.getPlace_name() == null || spot.getPlace_name().trim().isEmpty()) {
                    continue;
                }

                spot.setPlan_id(travelPlanVO.getPlan_id());

                if (spot.getVisit_order() == null) {
                    spot.setVisit_order(order);
                }
                order++;

                travelPlanMapper.insertPlanSpot(spot);
            }
        }

    }

    @Override
    public void editTravelPlan(TravelPlanVO travelPlanVO) {
        TravelPlanVO savedPlan = travelPlanMapper.getTravelPlanDetail(travelPlanVO);

        if (savedPlan == null) {
            return;
        }

        travelPlanMapper.editTravelPlan(travelPlanVO);
        travelPlanMapper.deletePlanSpotsByPlanId(travelPlanVO.getPlan_id());

        if (travelPlanVO.getSpotList() != null && !travelPlanVO.getSpotList().isEmpty()) {
            int order = 1;
            for (PlanSpotVO spot : travelPlanVO.getSpotList()) {

                if (spot.getSpot_id() != null && spot.getSpot_id().trim().isEmpty()) {
                    spot.setSpot_id(null);
                }

                if (spot.getPlace_name() == null || spot.getPlace_name().trim().isEmpty()) {
                    continue;
                }

                spot.setPlan_id(travelPlanVO.getPlan_id());

                if (spot.getVisit_order() == null) {
                    spot.setVisit_order(order);
                }
                order++;

                travelPlanMapper.insertPlanSpot(spot);
            }
        }
    }

    @Override
    public void deleteTravelPlan(TravelPlanVO travelPlanVO) {
        TravelPlanVO savedPlan = travelPlanMapper.getTravelPlanDetail(travelPlanVO);

        if(savedPlan == null) {
            return;
        }

        travelPlanMapper.deleteTravelPlan(travelPlanVO);
    }

    @Override
    public void insertPlanSpot(PlanSpotVO planSpotVO) {
        travelPlanMapper.insertPlanSpot(planSpotVO);
    }


}