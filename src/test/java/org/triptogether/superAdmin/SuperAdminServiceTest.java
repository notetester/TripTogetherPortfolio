package org.triptogether.superAdmin;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.triptogether.superAdmin.mapper.SuperAdminMapper;
import org.triptogether.superAdmin.service.SuperAdminServiceImpl;
import org.triptogether.superAdmin.vo.SuperAdminMemberVO;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class SuperAdminServiceTest {

    @Mock SuperAdminMapper superAdminMapper;

    @InjectMocks SuperAdminServiceImpl superAdminService;

    @Test
    @DisplayName("마지막 SUPERADMIN을 revoke하면 예외 발생")
    void revokeAdmin_마지막SUPERADMIN_예외발생() {
        SuperAdminMemberVO superAdmin = new SuperAdminMemberVO();
        superAdmin.setUserRole("SUPERADMIN");

        given(superAdminMapper.findAdminDetail(1L)).willReturn(superAdmin);
        given(superAdminMapper.countSuperAdmins()).willReturn(1);

        assertThatThrownBy(() -> superAdminService.revokeAdmin(1L))
                .isInstanceOf(IllegalStateException.class)
                .hasMessage("최소 1명의 SUPERADMIN이 유지되어야 합니다.");

        verify(superAdminMapper, never()).revokeAdmin(1L);
    }

    @Test
    @DisplayName("SUPERADMIN이 2명 이상이면 revoke 정상 동작")
    void revokeAdmin_SUPERADMIN여러명_정상동작() {
        SuperAdminMemberVO superAdmin = new SuperAdminMemberVO();
        superAdmin.setUserRole("SUPERADMIN");

        given(superAdminMapper.findAdminDetail(1L)).willReturn(superAdmin);
        given(superAdminMapper.countSuperAdmins()).willReturn(2);

        superAdminService.revokeAdmin(1L);

        verify(superAdminMapper).revokeAllPermissions(1L);
        verify(superAdminMapper).revokeAdmin(1L);
    }

    @Test
    @DisplayName("bulk revoke로 모든 SUPERADMIN을 제거하면 예외 발생")
    void bulkRevokeAdmin_전체SUPERADMIN포함_예외발생() {
        List<Long> targets = List.of(1L, 2L);

        given(superAdminMapper.countSuperAdmins()).willReturn(2);
        given(superAdminMapper.countSuperAdminsInList(targets)).willReturn(2);

        assertThatThrownBy(() -> superAdminService.bulkRevokeAdmin(targets))
                .isInstanceOf(IllegalStateException.class)
                .hasMessage("최소 1명의 SUPERADMIN이 유지되어야 합니다.");

        verify(superAdminMapper, never()).bulkRevokeAdmin(targets);
    }
}
