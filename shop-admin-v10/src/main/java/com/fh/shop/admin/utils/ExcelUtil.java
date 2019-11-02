package com.fh.shop.admin.utils;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelUtil {
    public static XSSFWorkbook downExcel(String sheetName,String[] headName,List dataList,String[] propes,Class clazz){
        //创建操作对象
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        //日期样式
        XSSFCellStyle dateStyle = xssfWorkbook.createCellStyle();
        dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        //价格类型的样式
        XSSFCellStyle priceStyle = xssfWorkbook.createCellStyle();
        priceStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        //通过map进行传递
        Map<String,XSSFCellStyle> map=new HashMap<>();
        map.put("dateStyle",dateStyle);
        map.put("priceStyle",priceStyle);
        //创建sheet页的名字
        XSSFSheet sheet = xssfWorkbook.createSheet(sheetName);
        //创建标头信息
        XSSFRow row = sheet.createRow(0);
        for (int i = 0; i <headName.length ; i++) {
            //创建标题
            row.createCell(i).setCellValue(headName[i]);
        }
        //循环全部数据
        for (int i = 0; i < dataList.size(); i++) {
            //创建新的一行，存放查询到的数据
            XSSFRow rows = sheet.createRow(i + 1);
            //获取到数组中每个对象
            Object o = dataList.get(i);
            //具体展示的字段
            for (int j = 0; j < propes.length ; j++) {
                //给列赋值
                XSSFCell cell = rows.createCell(j);
                try {
                    Field declaredField = clazz.getDeclaredField(propes[j]);
                    declaredField.setAccessible(true);
                    Class<?> type = declaredField.getType();
                    Object o1 = declaredField.get(o);
                    if(type == java.lang.Long.class){
                        cell.setCellValue(Long.valueOf(o1.toString()));
                    }
                    if(type == java.lang.String.class){
                        cell.setCellValue(String.valueOf(o1));
                    }
                    if(type == java.lang.Integer.class){
                        cell.setCellValue(Integer.valueOf(o1.toString()));
                    }
                    if(type == java.math.BigDecimal.class){
                        cell.setCellValue(((BigDecimal)o1).doubleValue());
                        cell.setCellStyle(map.get("priceStyle"));
                    }
                    if(type == java.util.Date.class){
                        cell.setCellValue((Date)o1);
                        cell.setCellStyle(map.get("dateStyle"));
                    }
                } catch (NoSuchFieldException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        }
        return xssfWorkbook;
    }











    public static XSSFWorkbook downExcels(String sheetName,String[] heads,List dataList,String[] propers,Class clazz){
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook();
        XSSFSheet sheet = xssfWorkbook.createSheet(sheetName);
        XSSFRow row = sheet.createRow(0);

        XSSFCellStyle dataStyle = xssfWorkbook.createCellStyle();
        dataStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));

        XSSFCellStyle priceStyle = xssfWorkbook.createCellStyle();
        priceStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        Map<String,XSSFCellStyle> map=new HashMap<>();
        map.put("dataStyle",dataStyle);
        map.put("priceStyle",priceStyle);
        for (int i = 0; i < heads.length; i++) {
            row.createCell(i).setCellValue(heads[i]);
        }
        for (int i = 0; i < dataList.size(); i++) {
            XSSFRow row1 = sheet.createRow(i + 1);
            Object o = dataList.get(i);
            for (int j = 0; j < propers.length; j++) {
                XSSFCell cell = row1.createCell(j);
                try {
                    Field declaredField = clazz.getDeclaredField(propers[j]);
                    declaredField.setAccessible(true);
                    Class<?> type = declaredField.getType();
                    Object o1 = declaredField.get(o);
                    if(type == java.lang.Long.class){
                        cell.setCellValue(Long.valueOf(o1.toString()));
                    }
                    if(type == java.lang.Integer.class){
                        cell.setCellValue(Integer.valueOf(o1.toString()));
                    }
                    if(type == java.lang.String.class){
                        cell.setCellValue(String.valueOf(o1));
                    }
                    if(type == java.util.Date.class){
                        cell.setCellValue((Date)o1);
                        cell.setCellStyle(map.get("dataStyle"));
                    }
                    if(type == java.math.BigDecimal.class){
                        cell.setCellValue(((BigDecimal)o1).doubleValue());
                    }
                } catch (NoSuchFieldException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        }
        return xssfWorkbook;
    }











    public static XSSFWorkbook excelDownLoad(List dataList, String sheetName, String[] headNames, String[] props, Class clazz){
        //创建excel对象
        XSSFWorkbook workbook = new XSSFWorkbook();
        //创建单元格样式
        Map<String, XSSFCellStyle> styleMap = buildCellStyle(workbook);
        //创建sheet
        XSSFSheet sheet = workbook.createSheet(sheetName);
        //创建标题行
        buildHeadRow(headNames, sheet);
        //创建主体
        buildBody(dataList, props, clazz, styleMap, sheet);
        return workbook;
    }
    //创建样式
    private static Map<String, XSSFCellStyle> buildCellStyle(XSSFWorkbook workbook) {
        //创建单元格样式 double类型
        XSSFCellStyle doubleCellStyle = workbook.createCellStyle();
        doubleCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        //创建单元格样式  date类型
        XSSFCellStyle dateCellStyle = workbook.createCellStyle();
        dateCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        //将样式放进Map里  方便传值
        Map<String,XSSFCellStyle> styleMap = new HashMap<>();
        styleMap.put("doubleCellStyle",doubleCellStyle);
        styleMap.put("dateCellStyle",dateCellStyle);
        return styleMap;
    }
    //创建导出主体
    private static void buildBody(List dataList, String[] props, Class clazz, Map<String, XSSFCellStyle> styleMap, XSSFSheet sheet) {
        //创建主体
        for (int i = 0; i <dataList.size() ; i++) {
            //获取当前要导出对象  获取属性值时使用
            Object obj = dataList.get(i);
            //创建要循环赋值的行 数据展示用
            XSSFRow row = sheet.createRow(i + 1);
            //循环创建单元格 并为单元格赋值  props是要导出的字段名/属性名 集合
            for (int j = 0; j <props.length ; j++) {
                //创建单元格
                XSSFCell cell = row.createCell(j);
                //使用获取要赋给单元格的值
                try {
                    //获取要导出属性
                    Field declaredField = clazz.getDeclaredField(props[j]);
                    //设置访问权限/暴力访问  因为属性是私有的 所以需要设置访问权限才能访问
                    declaredField.setAccessible(true);
                    //根据获取属性调用/获取 当前属性值
                    Object param = declaredField.get(obj);
                    //获取当前属性类型
                    Class<?> type = declaredField.getType();
                    //判断当前属性值 是什么类型  根据属性类型 不同处理方法
                    if(type == Integer.class){
                        cell.setCellValue(Integer.valueOf(String.valueOf(param)));
                    }
                    if(type == String.class){
                        cell.setCellValue(String.valueOf(param));
                    }
                    if(type == Double.class){
                        cell.setCellValue(Double.valueOf(String.valueOf(param)));
                    }
                    if(type == Date.class){
                        cell.setCellValue((Date)param);
                        cell.setCellStyle(styleMap.get("dateCellStyle"));
                    }
                    if(type == Long.class){
                        cell.setCellValue(Long.valueOf(String.valueOf(param)));
                    }
                    if(type == BigDecimal.class){
                        cell.setCellValue(((BigDecimal)param).doubleValue());
                        cell.setCellStyle(styleMap.get("doubleCellStyle"));
                    }
                } catch (NoSuchFieldException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }

        }
    }
    //创建标题行
    private static void buildHeadRow(String[] headNames, XSSFSheet sheet) {
        //创建标题行
        XSSFRow headRow = sheet.createRow(0);
        //为标题行赋值
        for (int i = 0; i < headNames.length; i++) {
            headRow.createCell(i).setCellValue(headNames[i]);
        }
    }



}