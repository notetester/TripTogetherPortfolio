package org.triptogether.flight.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.flight.vo.FlightPurchaseCreateDto;

@Mapper
public interface FlightMapper {

    void insertFlightPurchase(FlightPurchaseCreateDto purchase);
}
