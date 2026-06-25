package com.klifeguide.backend.global.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

public final class GeoUtils {

    private static final double EARTH_RADIUS_METERS = 6_371_000;

    private GeoUtils() {
    }

    public static BigDecimal distanceMeters(BigDecimal lat1, BigDecimal lon1, BigDecimal lat2, BigDecimal lon2) {
        double lat1Rad = Math.toRadians(lat1.doubleValue());
        double lat2Rad = Math.toRadians(lat2.doubleValue());
        double deltaLat = Math.toRadians(lat2.doubleValue() - lat1.doubleValue());
        double deltaLon = Math.toRadians(lon2.doubleValue() - lon1.doubleValue());

        double a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2)
                + Math.cos(lat1Rad) * Math.cos(lat2Rad)
                * Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        double distance = EARTH_RADIUS_METERS * c;
        return BigDecimal.valueOf(distance).setScale(2, RoundingMode.HALF_UP);
    }
}
