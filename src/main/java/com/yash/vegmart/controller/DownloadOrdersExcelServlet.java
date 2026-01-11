package com.yash.vegmart.controller;

import com.yash.vegmart.entity.Order;
import com.yash.vegmart.entity.OrderItem;
import com.yash.vegmart.service.OrderService;
import com.yash.vegmart.serviceimpl.OrderServiceImpl;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/DownloadOrdersExcel")
public class DownloadOrdersExcelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        OrderService orderService = new OrderServiceImpl();
        List<Order> orders = orderService.getAllOrders();


        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("VegMart Orders");

        Row headerRow = sheet.createRow(0);
        String[] headers = {
                "Order ID",
                "Customer Name",
                "Customer Email",
                "Order Date",
                "Payment Mode",
                "Total Amount",
                "Order Status",
                "Product Details"
        };

        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        int rowIndex = 1;
        for (Order o : orders) {

            Row row = sheet.createRow(rowIndex++);

            row.createCell(0).setCellValue(o.getOrderId());
            row.createCell(1).setCellValue(o.getUser().getName());
            row.createCell(2).setCellValue(o.getUser().getEmail());
            row.createCell(3).setCellValue(o.getOrderDate().toString());
            row.createCell(4).setCellValue(o.getPaymentMode());
            row.createCell(5).setCellValue(o.getTotalAmount());
            row.createCell(6).setCellValue(o.getStatus());


            StringBuilder productDetails = new StringBuilder();
            for (OrderItem oi : o.getItems()) {
                productDetails.append(
                        oi.getVegetable().getName()
                                + " (Qty: " + oi.getQuantity()
                                + ", ₹" + (oi.getVegetable().getPrice() * oi.getQuantity())
                                + "), "
                );
            }
            if (productDetails.length() > 0) {
                productDetails.setLength(productDetails.length() - 2);
            }

            row.createCell(7).setCellValue(productDetails.toString());
        }
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }
        resp.setContentType(
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        );
        resp.setHeader(
                "Content-Disposition",
                "attachment; filename=VegMart_Orders.xlsx"
        );
        ServletOutputStream out = resp.getOutputStream();
        workbook.write(out);
        workbook.close();
        out.close();
    }
}