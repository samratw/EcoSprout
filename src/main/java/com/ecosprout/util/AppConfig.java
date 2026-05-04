package com.ecosprout.util;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * AppConfig - Central store for all application-wide constants.
 * Servlets read from here and push data as request attributes.
 * JSPs never hardcode lists — they only iterate over what the servlet provides.
 */
public class AppConfig {

    /** Product categories available in the system. */
    public static final List<String> CATEGORIES = Arrays.asList(
        "Vegetables",
        "Fruits",
        "Grains & Cereals",
        "Dairy",
        "Herbs & Spices",
        "Pulses & Legumes",
        "Oils & Fats",
        "Other"
    );

    /** Units of measurement for products. key = stored value, value = display label. */
    public static final Map<String, String> UNITS = new LinkedHashMap<>();
    static {
        UNITS.put("kg",     "Kilograms (kg)");
        UNITS.put("g",      "Grams (g)");
        UNITS.put("piece",  "Per Piece");
        UNITS.put("dozen",  "Per Dozen");
        UNITS.put("litre",  "Litres");
        UNITS.put("pack",   "Pack");
    }

    /** Product statuses. key = stored value, value = display label. */
    public static final Map<String, String> PRODUCT_STATUSES = new LinkedHashMap<>();
    static {
        PRODUCT_STATUSES.put("available",    "Available");
        PRODUCT_STATUSES.put("out_of_stock", "Out of Stock");
    }

    /** User roles that can self-register. key = stored value, value = display label. */
    public static final Map<String, String> REGISTER_ROLES = new LinkedHashMap<>();
    static {
        REGISTER_ROLES.put("buyer",  "Buyer — I want to purchase products");
        REGISTER_ROLES.put("vendor", "Vendor — I want to sell products");
    }

    /** Contact inquiry subject options. */
    public static final List<String> CONTACT_SUBJECTS = Arrays.asList(
        "General Inquiry",
        "Vendor Registration Issue",
        "Product Complaint",
        "Order Support",
        "Technical Issue",
        "Other"
    );
}
