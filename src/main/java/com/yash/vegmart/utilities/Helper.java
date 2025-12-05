package com.yash.vegmart.utilities;

public class Helper
{
    public static String get35Words(String desc) {
        String[] str = desc.split(" ");
        if (str.length > 35) {
            StringBuilder res = new StringBuilder();
            for (int i = 0; i < 35; i++) {
                res.append(str[i]).append(" ");
            }
            return res.toString().trim() + "....";
        } else {
            return desc;
        }
    }

}
