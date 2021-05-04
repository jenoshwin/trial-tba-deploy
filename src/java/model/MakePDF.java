package model;

/**
 *
 * @author karla
 */
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPTable;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author karla
 */
public class MakePDF {

    public static String FILENAME;
    Document docs = new Document(PageSize.LETTER, 50, 50, 100, 50);
    public static final String cGFont = "..\\..\\..\\web\\fonts\\GOTHIC.TTF";

    //BOOK ARCHIVE FUNCTION
    public void dlUser(ResultSet userCollection, String action) throws DocumentException, IOException {
        BaseFont cGothic = BaseFont.createFont(cGFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        Font listHead = new Font(cGothic, 20, Font.BOLD);
        Font listBold = new Font(cGothic, 12, Font.BOLD);
        Font list = new Font(cGothic, 12);
        FILENAME = "The Book Amiga - Book Archive List.pdf";
        try {
//            String userComputer = System.getProperty("user.name");
            String home = System.getProperty("user.home");
//            PdfWriter writer = PdfWriter.getInstance(docs, new FileOutputStream("D:\\Downloads\\" + FILENAME));

            PdfWriter writer = PdfWriter.getInstance(docs, new FileOutputStream(home + "\\Downloads\\" + FILENAME));
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);
            docs.open();

            Paragraph title = new Paragraph("");
            docs.add(title);

            docs.add(Chunk.NEWLINE);

            Paragraph reqList = new Paragraph("Archive Book", listHead);
            reqList.setAlignment(Paragraph.ALIGN_CENTER);
            docs.add(reqList);
            docs.add(Chunk.NEWLINE);

            while (userCollection.next()) {
                float[] widths = {0.05f, 0.1f, 0.18f, 0.18f, 0.20f, 0.18f, 0.18f, 0.1f, 0.12f};
                PdfPTable table = new PdfPTable(widths);
                table.setWidthPercentage(100);
                table.addCell(new Paragraph("ID"));
                table.addCell(new Paragraph("BookID"));
                table.addCell(new Paragraph("Book Name"));
                table.addCell(new Paragraph("Author"));
                table.addCell(new Paragraph("ISBN"));
                table.addCell(new Paragraph("Genre"));
                table.addCell(new Paragraph("Publish Date"));
                table.addCell(new Paragraph("Price (PHP)"));
                table.addCell(new Paragraph("Weight (kg)"));

                table.addCell(new Paragraph(userCollection.getString("archiveid"), list));
                table.addCell(new Paragraph(userCollection.getString("bookid"), list));
                table.addCell(new Paragraph(userCollection.getString("bookname"), list));
                table.addCell(new Paragraph(userCollection.getString("author"), list));
                table.addCell(new Paragraph(userCollection.getString("isbn"), list));
                table.addCell(new Paragraph(userCollection.getString("genre"), list));
                table.addCell(new Paragraph(userCollection.getString("publish_date"), list));
                table.addCell(new Paragraph(userCollection.getString("price"), list));
                table.addCell(new Paragraph(userCollection.getString("weight"), list));
              
                docs.add(table);
//                docs.add(new Paragraph("ID", listBold));
//                docs.add(new Paragraph(userCollection.getString("archiveid"), list));
//                docs.add(new Paragraph("BookID", listBold));
//                docs.add(new Paragraph(userCollection.getString("bookid"), list));
//                docs.add(new Paragraph("Book Name", listBold));
//                docs.add(new Paragraph(userCollection.getString("bookname"), list));
//                docs.add(new Paragraph("Author", listBold));
//                docs.add(new Paragraph(userCollection.getString("author"), list));
//                docs.add(new Paragraph("ISBN", listBold));
//                docs.add(new Paragraph(userCollection.getString("isbn"), list));
//                docs.add(new Paragraph("Genre", listBold));
//                docs.add(new Paragraph(userCollection.getString("genre"), list));
                docs.add(new Paragraph("Book Description", listBold));
                docs.add(new Paragraph(userCollection.getString("bookdesc"), list));
//                docs.add(new Paragraph("Publish Date", listBold));
//                docs.add(new Paragraph(userCollection.getString("publish_date"), list));
//                docs.add(new Paragraph("Price (PHP)", listBold));
//                docs.add(new Paragraph(userCollection.getString("price"), list));
//                docs.add(new Paragraph("Weight (kg)", listBold));
//                docs.add(new Paragraph(userCollection.getString("weight"), list));
                docs.add(new Paragraph(" ", list));
                Paragraph endList = new Paragraph("~End of Book Information~", list);
                endList.setAlignment(Paragraph.ALIGN_CENTER);
                docs.add(endList);
                docs.add(Chunk.NEWLINE);
            }

//            float[] widths = {0.05f, 0.05f, 0.10f, 0.10f, 0.10f, 0.10f, 0.25f, 0.1f, 0.1f, 0.1f};
//            PdfPTable table = new PdfPTable(widths);
//            table.setWidthPercentage(100);
//            table.addCell(new Paragraph("ID"));
//            table.addCell(new Paragraph("BookID"));
//            table.addCell(new Paragraph("Book Name"));
//            table.addCell(new Paragraph("Author"));
//            table.addCell(new Paragraph("ISBN"));
//            table.addCell(new Paragraph("Genre"));
//            table.addCell(new Paragraph("Book Description"));
//            table.addCell(new Paragraph("Publish Date"));
//            table.addCell(new Paragraph("Price (PHP)"));
//            table.addCell(new Paragraph("Weight (kg)"));
//            while (userCollection.next()) {
//                table.addCell(new Paragraph(userCollection.getString("archiveid"), list));
//                table.addCell(new Paragraph(userCollection.getString("bookid"), list));
//                table.addCell(new Paragraph(userCollection.getString("bookname"), list));
//                table.addCell(new Paragraph(userCollection.getString("author"), list));
//                table.addCell(new Paragraph(userCollection.getString("isbn"), list));
//                table.addCell(new Paragraph(userCollection.getString("genre"), list));
//                table.addCell(new Paragraph(userCollection.getString("bookdesc"), list));
//                table.addCell(new Paragraph(userCollection.getString("publish_date"), list));
//                table.addCell(new Paragraph(userCollection.getString("price"), list));
//                table.addCell(new Paragraph(userCollection.getString("stock"), list));
//                table.addCell(new Paragraph(userCollection.getString("weight"), list));
//            }
//            docs.add(table);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(MakePDF.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            docs.close();
        }
    }

    //REQUEST BOOK FUNCTION
    public void dlUser(String user, ResultSet userCollection, String action) throws DocumentException, IOException {
        BaseFont cGothic = BaseFont.createFont(cGFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        Font listHead = new Font(cGothic, 20, Font.BOLD);
        Font userTime = new Font(cGothic, 12, Font.BOLD);
        Font list = new Font(cGothic, 12);

        try {
            if (action.equals("order")) {
                FILENAME = "The Book Amiga - Order List.pdf";
            } else {
                FILENAME = "The Book Amiga - Book Request List.pdf";
            }
//            String userComputer = System.getProperty("user.name");
            String home = System.getProperty("user.home");
//            PdfWriter writer = PdfWriter.getInstance(docs, new FileOutputStream("D:\\Downloads\\" + FILENAME));

            PdfWriter writer = PdfWriter.getInstance(docs, new FileOutputStream(home + "\\Downloads\\" + FILENAME));
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);
            docs.open();

            Paragraph title = new Paragraph("");
            docs.add(title);

            docs.add(new Paragraph(("Admin: " + user), userTime));

            docs.add(Chunk.NEWLINE);

            Paragraph reqList = new Paragraph("Book Requests", listHead);
            reqList.setAlignment(Paragraph.ALIGN_CENTER);
            docs.add(reqList);
            docs.add(Chunk.NEWLINE);
            float[] widths = {0.1f, 0.33f, 0.33f, 0.33f};
            PdfPTable table = new PdfPTable(widths);
            table.setWidthPercentage(100);
            table.addCell(new Paragraph("ID"));
            table.addCell(new Paragraph("Customer Name"));
            table.addCell(new Paragraph("Customer E-Mail"));
            table.addCell(new Paragraph("Request Book"));
            while (userCollection.next()) {
                String customerName = userCollection.getString("firstname") + " " + userCollection.getString("lastname");
                String order = userCollection.getString("bookname") + " by " + userCollection.getString("author");

                table.addCell(new Paragraph(userCollection.getString("requestID"), list));
                table.addCell(new Paragraph(customerName, list));
                table.addCell(new Paragraph(userCollection.getString("email"), list));
                table.addCell(new Paragraph(order, list));
            }
            docs.add(table);

        } catch (FileNotFoundException ex) {
            Logger.getLogger(MakePDF.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            docs.close();
        }

    }

    //ORDER BOOK FUNCTION
    public void dlUser(String user, ResultSet userCollection, ArrayList<ResultSet> bookOrders, String action) throws DocumentException, IOException {
        BaseFont cGothic = BaseFont.createFont(cGFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        Font listHead = new Font(cGothic, 20, Font.BOLD);
        Font userTime = new Font(cGothic, 12, Font.BOLD);
        Font list = new Font(cGothic, 10);
        int index = 0;

        try {
            if (action.equals("order")) {
                FILENAME = "The Book Amiga - Order List.pdf";
            } else {
                FILENAME = "The Book Amiga - Book Request List.pdf";
            }
//            String userComputer = System.getProperty("user.name");
            String home = System.getProperty("user.home");
//            PdfWriter writer = PdfWriter.getInstance(docs, new FileOutputStream("D:\\Downloads\\" + FILENAME));
            PdfWriter writer = PdfWriter.getInstance(docs, new FileOutputStream(home + "\\Downloads\\" + FILENAME));
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);
            docs.open();

            Paragraph title = new Paragraph("");
            docs.add(title);

            docs.add(new Paragraph(("Admin: " + user), userTime));

            docs.add(Chunk.NEWLINE);

            Paragraph orderList = new Paragraph("Orders", listHead);
            orderList.setAlignment(Paragraph.ALIGN_CENTER);
            docs.add(orderList);
            docs.add(Chunk.NEWLINE);
            float[] widths = {0.05f, 0.11f, 0.10f, 0.18f, 0.25f, 0.11f, 0.1f, 0.1f, 0.1f};
            PdfPTable table = new PdfPTable(widths);
            table.setWidthPercentage(100);
            table.addCell(new Paragraph("ID"));
            table.addCell(new Paragraph("Name"));
            table.addCell(new Paragraph("Facebook"));
            table.addCell(new Paragraph("Address"));
            table.addCell(new Paragraph("Order"));
            table.addCell(new Paragraph("Pay Method"));
            table.addCell(new Paragraph("Delivery"));
            table.addCell(new Paragraph("Order Time"));
            table.addCell(new Paragraph("Price (PHP)"));

            while (userCollection.next()) {
                String comAddress = userCollection.getString("address");
                try {
                    String address = comAddress.substring(comAddress.indexOf("Address;;") + 9, comAddress.indexOf("City;;"));
                    String city = comAddress.substring(comAddress.indexOf("City;;") + 6, comAddress.indexOf("Postal;;"));
                    String postal = comAddress.substring(comAddress.indexOf("Postal;;") + 8, comAddress.indexOf("Region;;"));
                    String region = comAddress.substring(comAddress.indexOf("Region;;") + 8, comAddress.indexOf("Additional;;"));
                    String additional = comAddress.substring(comAddress.indexOf("Additional;;") + 12, comAddress.length());
                    comAddress = address + ", " + city + ", " + postal + ", " + region + " - " + additional;
                } catch (StringIndexOutOfBoundsException e) {
                    comAddress = userCollection.getString("address");
                }
                String customerName = userCollection.getString("firstname") + " " + userCollection.getString("lastname");
                table.addCell(new Paragraph(userCollection.getString("checkoutID"), list));
                table.addCell(new Paragraph(customerName, list));
                table.addCell(new Paragraph(userCollection.getString("fb_uname"), list));
                table.addCell(new Paragraph(comAddress, list));
                ResultSet bks = bookOrders.get(index);
                Paragraph orders = new Paragraph(null, list);
                while (bks.next()) {
                    orders.add(bks.getString("quantity") + " pc/s. " + bks.getString("bookname") + " by " + bks.getString("author") + "\n\n");
                }
                table.addCell(orders);
                table.addCell(new Paragraph(userCollection.getString("payment_method"), list));
                table.addCell(new Paragraph(userCollection.getString("delivery_method"), list));
                table.addCell(new Paragraph(userCollection.getString("order_time"), list));
                table.addCell(new Paragraph(userCollection.getString("total_price"), list));
                //table.addCell(new Paragraph(userCollection.getString("paid"), list));
                index++;
            }
            docs.add(table);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(MakePDF.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            docs.close();
        }

    }

}
