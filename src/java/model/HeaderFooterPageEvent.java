/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author karla
 */
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.IOException;
import java.net.MalformedURLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class HeaderFooterPageEvent extends PdfPageEventHelper {

    private PdfTemplate t;
    private Image total;

    public static final String cGFont = "..\\..\\..\\web\\fonts\\GOTHIC.TTF";
    public static final String iFont = "..\\..\\..\\web\\fonts\\impact.ttf";

    public void onOpenDocument(PdfWriter writer, Document document) {
        t = writer.getDirectContent().createTemplate(30, 16);
        try {
            total = Image.getInstance(t);
            total.setRole(PdfName.ARTIFACT);
        } catch (DocumentException de) {
            throw new ExceptionConverter(de);
        }
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        try {
            addHeader(writer);
            addFooter(writer);
        } catch (IOException | DocumentException ex) {
            Logger.getLogger(HeaderFooterPageEvent.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void addHeader(PdfWriter writer) throws IOException, DocumentException {
        PdfPTable header = new PdfPTable(1);
        BaseFont cGothic = BaseFont.createFont(cGFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        Font subTitle = new Font(cGothic, 10);
        BaseFont impact = BaseFont.createFont(iFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        Font title = new Font(impact, 20);

        try {
            // set defaults
            header.setWidths(new int[]{24});
            header.setTotalWidth(527);
            header.setLockedWidth(true);
            header.getDefaultCell().setFixedHeight(40);
            header.getDefaultCell().setBorder(Rectangle.BOTTOM);
            header.getDefaultCell().setBorderColor(BaseColor.LIGHT_GRAY);

            // add text
            PdfPCell text = new PdfPCell();
            Date systemDate = new Date();
            DateFormat stf = new SimpleDateFormat("MM-dd-yyyy hh:mm:ss a");
            String date = stf.format(systemDate);
            
            text.setPaddingTop(30);
            text.setPaddingBottom(15);
            text.setPaddingLeft(10);
            text.setBorder(Rectangle.BOTTOM);
            text.setBorderColor(BaseColor.LIGHT_GRAY);
            text.addElement(new Phrase("The Book Amiga", title));
            text.addElement(new Phrase("Online Bookstore System", subTitle));
            text.addElement(new Phrase(("Time: "+date), subTitle));
            header.addCell(text);

            // write content
            header.writeSelectedRows(0, -1, 34, 803, writer.getDirectContent());
        } catch (DocumentException de) {
            throw new ExceptionConverter(de);
        }
    }

    private void addFooter(PdfWriter writer) throws DocumentException, IOException {
        PdfPTable footer = new PdfPTable(3);
        BaseFont cGothic = BaseFont.createFont(cGFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        Font subTitle = new Font(cGothic, 8);
        BaseFont impact = BaseFont.createFont(iFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
        Font title = new Font(impact, 15);
        try {
            // set defaults
            footer.setWidths(new int[]{24, 4, 1});
            footer.setTotalWidth(527);
            footer.setLockedWidth(true);
            footer.getDefaultCell().setFixedHeight(40);
            footer.getDefaultCell().setBorder(Rectangle.TOP);
            footer.getDefaultCell().setBorderColor(BaseColor.LIGHT_GRAY);

            // add copyright
            PdfPCell text = new PdfPCell();
            text.setBorder(Rectangle.TOP);
            text.setBorderColor(BaseColor.LIGHT_GRAY);
            text.addElement(new Phrase("The Book Amiga", title));
            text.addElement(new Phrase("Online Bookstore System", subTitle));
            footer.addCell(text);

           
            // add current page count
            footer.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
            footer.addCell(new Phrase(String.format("Page %d of", writer.getPageNumber()), subTitle));

            // add placeholder for total page count
            PdfPCell totalPageCount = new PdfPCell(total);
            totalPageCount.setBorder(Rectangle.TOP);
            totalPageCount.setBorderColor(BaseColor.LIGHT_GRAY);
            footer.addCell(totalPageCount);

            // write page
            PdfContentByte canvas = writer.getDirectContent();
            canvas.beginMarkedContentSequence(PdfName.ARTIFACT);
            footer.writeSelectedRows(0, -1, 34, 50, canvas);
            canvas.endMarkedContentSequence();
        } catch (DocumentException de) {
            throw new ExceptionConverter(de);
        }
    }

    public void onCloseDocument(PdfWriter writer, Document document) {
        try {
            BaseFont cGothic = BaseFont.createFont(cGFont, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
            Font subTitle = new Font(cGothic, 8);
            int totalLength = String.valueOf(writer.getPageNumber()).length();
            int totalWidth = totalLength * 5;
            ColumnText.showTextAligned(t, Element.ALIGN_RIGHT,
                    new Phrase(String.valueOf(writer.getPageNumber()), subTitle),
                    totalWidth, 6, 0);
        } catch (DocumentException | IOException ex) {
            Logger.getLogger(HeaderFooterPageEvent.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
