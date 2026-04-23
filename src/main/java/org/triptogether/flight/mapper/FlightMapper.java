package org.triptogether.flight.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.flight.vo.FlightPurchaseCreateDto;
import org.triptogether.flight.vo.FlightPurchaseVO;

@Mapper
public interface FlightMapper {

    void insertFlightPurchase(FlightPurchaseCreateDto purchase);

    FlightPurchaseVO selectFlightPurchaseForUpdate(@Param("flightPurchaseIdx") Long flightPurchaseIdx,
                                                   @Param("userIdx") Long userIdx);

    int cancelFlightPurchase(@Param("flightPurchaseIdx") Long flightPurchaseIdx,
                             @Param("userIdx") Long userIdx,
                             @Param("cancelReason") String cancelReason);
}
