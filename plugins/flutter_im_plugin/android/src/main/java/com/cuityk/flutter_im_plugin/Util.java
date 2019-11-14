package com.cuityk.flutter_im_plugin;

import com.google.gson.Gson;

import java.lang.reflect.Type;

public class Util {

    private static final Gson GSON = new Gson();

    public static String toJson(Object obj) {
        return GSON.toJson(obj);
    }

    public static <T> T toObject(String json, Type type) {
        return GSON.fromJson(json, type);
    }
}
