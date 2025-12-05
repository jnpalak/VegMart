package com.yash.vegmart.utilities;
import com.yash.vegmart.entity.CartItem;

import java.util.Map;

public class CartUtils {

    public static int getTotalItems(Map<Integer, CartItem> cart)
    {
        if (cart == null) return 0;
        return cart.values().stream().mapToInt(CartItem::getQuantity).sum();
    }

    public static double getCartTotal(Map<Integer, CartItem> cart)
    {
        if (cart == null) return 0.0;
        return cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();
    }
}