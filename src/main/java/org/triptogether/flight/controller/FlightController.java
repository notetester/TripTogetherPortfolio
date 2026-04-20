package org.triptogether.flight.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.flight.service.FlightService;
import org.triptogether.flight.vo.FlightPurchaseRequestDto;
import org.triptogether.flight.vo.FlightPurchaseResultDto;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/flight")
@RequiredArgsConstructor
public class FlightController {

    private final FlightService flightService;

    @GetMapping("/offers")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> offers(@RequestParam Long spotIdx) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("available", flightService.isFlightAvailable(spotIdx));
        result.put("offers", flightService.getOffers(spotIdx));
        return ResponseEntity.ok(result);
    }

    @PostMapping("/purchase")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> purchase(@RequestBody FlightPurchaseRequestDto request,
                                                        HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO loginUser = getLoginUser(session);

        try {
            FlightPurchaseResultDto purchaseResult = flightService.purchase(
                    loginUser != null ? loginUser.getUserIdx() : null,
                    request
            );

            session.setAttribute("loginUser", purchaseResult.getUpdatedUser());

            result.put("success", true);
            result.put("message", "항공권 구매가 완료되었습니다.");
            result.put("purchaseNo", purchaseResult.getPurchaseNo());
            result.put("cashBalance", purchaseResult.getUpdatedUser().getCashBalance());
            result.put("mileageBalance", purchaseResult.getUpdatedUser().getMileageBalance());
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }

        return ResponseEntity.ok(result);
    }

    private UsersVO getLoginUser(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO usersVO) {
            return usersVO;
        }
        return null;
    }
}
