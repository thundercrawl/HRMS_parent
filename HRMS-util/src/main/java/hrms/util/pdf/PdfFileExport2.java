package hrms.util.pdf;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import java.awt.*;
import java.io.*;
import java.net.MalformedURLException;

public class PdfFileExport2 {
	
	private static Document pdfDocument;
	private OutputStream pdfFileOutputStream;
	private PdfWriter pdfWriter;
	private Font f8_white;
	public static Font f8_black;
	private Font f8;
	private Font f8_BOLD;
	private Font f16_BOLD;
	private Font f14_BOLD;
	public static Font f10_BOLD;
	private Font f18_BOLD;
	private Font BIG_TITLE_BOLD;
	private Color grey = new Color(128,128,128);
	private Color white = new Color(219,221,221);
	private Color blue = new Color(36,64,97);
	private Color hoary = new Color(217, 217, 217);
	private Color black = new Color(0, 0, 0);
	@SuppressWarnings("unused")
	private Color whiteColor;
	private static Font keyfont;
	BaseFont bfChinese = null;
	String fontPath = "";
	
	public void initPdfDocument(String fullFilePath) throws DocumentException, FileNotFoundException{
		pdfDocument = new Document(PageSize.A4,40,40,40,40);
			pdfFileOutputStream = new FileOutputStream(new File(fullFilePath));
			//构建一个PDF文档输出流程
        	pdfWriter = PdfWriter.getInstance(pdfDocument,pdfFileOutputStream);
        	//设置作者信息
        	PdfFileExportUtil.setCreatorInfo(pdfDocument);
        	//设置文件只读权限
        	PdfFileExportUtil.setReadOnlyPDFFile(pdfWriter);
        	//通过PDF页面事件模式添加文字水印功能
        	PdfFileExportUtil pdfFileExportUtil = new PdfFileExportUtil();
        	/*pdfWriter.setPageEvent(pdfFileExportUtil.new TextWaterMarkPdfPageEvent("上海办伴科技发展有限公司"));*/
        	//通过PDF页面事件模式添加图片水印功能
        	/*String waterMarkFullFilePath = "D:/logo-new.png";//水印图片
        	pdfWriter.setPageEvent(pdfFileExportUtil.new PictureWaterMarkPdfPageEvent(waterMarkFullFilePath));*/
        	//通过PDF页面事件模式添加页头和页脚信息功能
        	//pdfWriter.setPageEvent(pdfFileExportUtil.new HeadFootInfoPdfPageEvent());
        	
            //打开PDF文件流
        	pdfDocument.open();
        	BaseFont bfChinese = null;
        	fontPath = PdfFileExport2.class.getClassLoader().getResource("")
    				.toString().replaceAll("file:/", "")
    				+ "simsun.ttc";
			try {
				bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				keyfont = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小    
				f8_BOLD = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小    
				f16_BOLD = new Font(bfChinese, 16, Font.BOLD);// 设置字体大小
				f14_BOLD = new Font(bfChinese, 14, Font.BOLD);// 设置字体大小
				f10_BOLD = new Font(bfChinese, 10, Font.BOLD);// 设置字体大小
				f18_BOLD = new Font(bfChinese, 18, Font.BOLD);// 设置字体大小
				BIG_TITLE_BOLD = new Font(bfChinese, 30, Font.BOLD);// 设置字体大小
				whiteColor = new Color(255, 255, 255);   
			} catch (IOException e) {
				e.printStackTrace();
			}  
			f8_white = new Font(bfChinese, 10, Font.NORMAL);
			f8 = new Font(bfChinese, 8, Font.NORMAL);
			f8_black = new Font(bfChinese, 10, Font.NORMAL);
			f8_white.setColor(new Color(250, 250, 250));
	}
	
	public void createChunk() throws DocumentException{
		Chunk underline = new Chunk("       ");
        underline.setUnderline(0f, 0f);
        //underline.setBackground(new Color(230,230,230), 0, 0, 0, 0);
        //underline.setAnchor("http://www.baidu.com");
        underline.setHorizontalScaling(20);
        //underline.setBackground(new Color(230,230,230));
        //underline.setTextRise(4);
        pdfDocument.add(underline);
	}
	
	
	
	
	
	public void createTitle(String titleStr) throws DocumentException{
		Paragraph title = new Paragraph(titleStr, f16_BOLD);
		pdfDocument.add(title);
	}
	

private void createHeader() throws DocumentException, MalformedURLException, IOException {
	 PdfPTable pdfTableInternal = new PdfPTable(4);
	    pdfTableInternal.setHorizontalAlignment(PdfPTable.ALIGN_CENTER);
	    pdfTableInternal.setSpacingBefore(15);
	    pdfTableInternal.setSpacingAfter(20);
	    //设置表格占PDF文档100%宽度
	    pdfTableInternal.setWidthPercentage(100);
	   float height = 30;
	    //***********************************************************************************************
	    	PdfPCell createCell1 = createCell("",Element.ALIGN_CENTER,1,height,white,f8_black);
	    	//String replaceAll = PdfFileExport2.class.getClassLoader().getResource("").toString().replaceAll("file:/", "")+"logozd.jpg";
	    	/*String property = System.getProperty("user.dir");
	    	System.err.println(property+"\\img\\"+"logozd.jpg");
	    	String imgPath = property+"\\img\\"+"logozd.jpg";*/
	    	//String imgPath = "/~\\pdf\\logozd.jpg";
	    	String imgPath = "d:/pdf/logozd.jpg";
	    	Image image = Image.getInstance(imgPath);
	    	createCell1.setBorder(0);
	    	createCell1.setRowspan(2);
	    	createCell1.addElement(image);
	        pdfTableInternal.addCell(createCell1);
	        PdfPCell createCellx = createCell("",Element.ALIGN_RIGHT,1,height,white,f8_black);
	        createCellx.setBorder(0);
	        pdfTableInternal.addCell(createCellx);
	        pdfTableInternal.addCell(createCellx);
	        PdfPCell createCell2 = createCell("",Element.ALIGN_RIGHT,1,height,white,f8_black);
	        Paragraph title = new Paragraph("www.distrii.com", f14_BOLD);
	        createCell2.setPhrase(title);
	    	createCell2.setBorder(0);
	    	createCell2.setVerticalAlignment(PdfPTable.ALIGN_BOTTOM);
	        pdfTableInternal.addCell(createCell2);
	        pdfTableInternal.addCell(createCellx);
	        pdfTableInternal.addCell(createCellx);
	        PdfPCell createCell3 = createCell("",Element.ALIGN_RIGHT,1,height,white,f8_black);
	        Paragraph title2 = new Paragraph("400-920-9888", f14_BOLD);
	        createCell3.setPhrase(title2);
	    	createCell3.setBorder(0);
	        pdfTableInternal.addCell(createCell3);
	    //设置表格占PDF文档100%宽度
	    pdfDocument.add(pdfTableInternal);
}


	public void createAccount() throws DocumentException, IOException{
		
		PdfPTable pdfTable = new PdfPTable(1);
		pdfTable.setSpacingBefore(15);
	    //设置表格占PDF文档100%宽度
	    pdfTable.setWidthPercentage(100);
	    //水平方向表格控件左对齐
	    pdfTable.setHorizontalAlignment(PdfPTable.ALIGN_CENTER);
	    
	    PdfPCell repayCell = new PdfPCell();
	    repayCell.setBorderWidth(0);
	    repayCell.setPaddingTop(0);
	    PdfPTable pdfTableInternal = new PdfPTable(14);
	    pdfTableInternal.setWidthPercentage(90);
	    //***********************************************************************************************
	    
	    PdfPCell cell1 = createCell("供应方银行账户信息",Element.ALIGN_CENTER,7,0,0,20,blue,white,f8_black);
	    pdfTableInternal.addCell(cell1);
	    
	    PdfPCell cell2 = createCell("客户方银行账户信息",Element.ALIGN_CENTER,7,0,2,20,blue,white,f8_black);
	    pdfTableInternal.addCell(cell2);
	    //***********************************************************************************************
	    PdfPCell cell3 =createCell("收款账户",Element.ALIGN_CENTER,2,0,0,20,grey,white,f8_black);
	    pdfTableInternal.addCell(cell3);
	    PdfPCell cell4 =createCell("98400154740016485",Element.ALIGN_CENTER,5,0,2,20,hoary,white,f8_black);
	    pdfTableInternal.addCell(cell4);
	    PdfPCell cell5 =createCell("收款账户",Element.ALIGN_CENTER,2,0,2,20,grey,white,f8_black);
	    pdfTableInternal.addCell(cell5);
	    PdfPCell cell6 =createCell("",Element.ALIGN_CENTER,5,0,2,20,hoary,white,f8_black);
	    pdfTableInternal.addCell(cell6);
	    
	    repayCell.addElement(pdfTableInternal);
	    pdfTable.addCell(repayCell);
	    pdfDocument.add(pdfTable);
	}
	
	public PdfPCell createCell(String value,int align,int colspan,int padding,int borderWidthLeft,int fixedHeight,Color backColor,Color borderColor,Font f8){    
	    PdfPCell cell = new PdfPCell();    
	    cell.setVerticalAlignment(Element.ALIGN_MIDDLE); 
	    cell.setHorizontalAlignment(align);        
	    cell.setColspan(colspan); 
	    cell.setPadding(padding);
	    cell.setPhrase(new Phrase(value,f8));
	    cell.setBorderWidthLeft(borderWidthLeft);
	    cell.setBorderWidthTop(2);
	    cell.setBackgroundColor(backColor);
	    cell.setBorderColor(borderColor);
	    cell.setFixedHeight(fixedHeight);
	   return cell;    
	}
	
	public PdfPCell createCell(String value,int align,int colspan,float height,Color borderColor,Font f8){    
	    PdfPCell cell = new PdfPCell();    
	    cell.setVerticalAlignment(Element.ALIGN_MIDDLE); 
	    cell.setHorizontalAlignment(align);        
	    cell.setColspan(colspan); 
	    cell.setPadding(0);
	    cell.setPhrase(new Phrase(value,f8));
	    cell.setBorderWidth(1);
	    cell.setBorderColor(borderColor);
	    cell.setFixedHeight(height);
	   return cell;    
	}
	
	
	
	public void createTail() throws Exception{
		BaseFont bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        @SuppressWarnings("unused")
		Font f8 = new Font(bfChinese, 16, Font.BOLD);
		PdfPTable pdfTable = new PdfPTable(2);
        //设置表格占PDF文档100%宽度
        pdfTable.setWidthPercentage(100);
        //水平方向表格控件左对齐
        pdfTable.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
        PdfPCell repayCell = new PdfPCell();
  		repayCell.setBorderWidth(0);
        PdfPTable pdfTableLeft = new PdfPTable(1);
        PdfPCell createCell1 = createCell("授权方(供应方)授权代表",Element.ALIGN_LEFT,1,false);
        createCell1.setPaddingBottom(0);
        pdfTableLeft.addCell(createCell1);
        PdfPCell createCell2 = createCell("Authorizing Party's Authorized Representative",Element.ALIGN_LEFT,1,false);
        createCell2.setPaddingTop(0);
        pdfTableLeft.addCell(createCell2);
        repayCell.addElement(pdfTableLeft);
        pdfTable.addCell(repayCell);
        
        
       
        PdfPCell rightCell = new PdfPCell();
        rightCell.setBorderWidth(0);
        PdfPTable pdfTableRight = new PdfPTable(1);
        PdfPCell createCellRight1 = createCell("被授权方(供应方)授权代表",Element.ALIGN_LEFT,1,false);
        createCellRight1.setPaddingBottom(0);
        pdfTableRight.addCell(createCellRight1);
        PdfPCell createCellRight2 = createCell("Authorized Party's Authorized Representative",Element.ALIGN_LEFT,1,false);
        createCellRight2.setPaddingTop(0);
        pdfTableRight.addCell(createCellRight2);
        rightCell.addElement(pdfTableRight);
        pdfTable.addCell(rightCell);
        
        
        PdfPCell repayCellLeft2 = new PdfPCell();
        repayCellLeft2.setBorderWidth(0);
        PdfPTable pdfTableLeft2 = new PdfPTable(1);
        PdfPCell createCellLeft3 = createCell("职位",Element.ALIGN_LEFT,1,false);
        createCellLeft3.setPaddingBottom(0);
        pdfTableLeft2.addCell(createCellLeft3);
        PdfPCell createCellLeft4 = createCell("Position",Element.ALIGN_LEFT,1,false);
        createCellLeft4.setPaddingTop(0);
        pdfTableLeft2.addCell(createCellLeft4);
        repayCellLeft2.addElement(pdfTableLeft2);
        pdfTable.addCell(repayCellLeft2);
        
        
        PdfPCell rightCell2 = new PdfPCell();
        rightCell2.setBorderWidth(0);
        PdfPTable pdfTableRight2 = new PdfPTable(1);
        PdfPCell createCellRight3 = createCell("职位",Element.ALIGN_LEFT,1,false);
        createCellRight3.setPaddingBottom(0);
        pdfTableRight2.addCell(createCellRight3);
        PdfPCell createCellRight4 = createCell("Position",Element.ALIGN_LEFT,1,false);
        createCellRight4.setPaddingTop(0);
        pdfTableRight2.addCell(createCellRight4);
        rightCell2.addElement(pdfTableRight2);
        pdfTable.addCell(rightCell2);
        
        
        PdfPCell repayCellLeft3 = new PdfPCell();
        repayCellLeft3.setBorderWidth(0);
        PdfPTable pdfTableLeft3 = new PdfPTable(1);
        PdfPCell createCellLeft5 = createCell("签署及盖章",Element.ALIGN_LEFT,1,false);
        createCellLeft5.setPaddingBottom(0);
        pdfTableLeft3.addCell(createCellLeft5);
        PdfPCell createCellLeft6 = createCell("signature and Seal",Element.ALIGN_LEFT,1,false);
        createCellLeft6.setPaddingTop(0);
        pdfTableLeft3.addCell(createCellLeft6);
        repayCellLeft3.addElement(pdfTableLeft3);
        pdfTable.addCell(repayCellLeft3);
        
        PdfPCell rightCell3 = new PdfPCell();
        rightCell3.setBorderWidth(0);
        PdfPTable pdfTableRight3 = new PdfPTable(1);
        PdfPCell createCellRight5 = createCell("签署及盖章",Element.ALIGN_LEFT,1,false);
        createCellRight5.setPaddingBottom(0);
        pdfTableRight3.addCell(createCellRight5);
        PdfPCell createCellRight6 = createCell("signature and Seal",Element.ALIGN_LEFT,1,false);
        createCellRight6.setPaddingTop(0);
        pdfTableRight3.addCell(createCellRight6);
        rightCell3.addElement(pdfTableRight3);
        pdfTable.addCell(rightCell3);
        
        
        pdfDocument.add(pdfTable);
	}
	
	
	public void createTag(String text) throws DocumentException{
		Paragraph pt=new Paragraph(text,f8_BOLD);
		pt.setAlignment(0);
		pdfDocument.add(pt);
	}
	public void createTag(String text,Font font) throws DocumentException{
		Paragraph pt=new Paragraph(text,font);
		pt.setAlignment(1);
		pdfDocument.add(pt);
	}
	
	
	

	private void createClauseTitle(String titleStr) throws DocumentException {
		createNullLines(1,10);
		Paragraph pt=new Paragraph(titleStr,f10_BOLD);
		pt.setAlignment(0);
		pdfDocument.add(pt);
		createNullLines(1,10);
	}

	/**
	 * 创建空的行
	 * @param lines 需要创建的行数
	 * @throws DocumentException
	 * @author chenlong
	 * 2016年10月27日 上午11:24:48
	 */
	private void createNullLines(int lines,float ff) throws DocumentException {
		Paragraph blankRow1 = new Paragraph(ff, " ", f18_BOLD); 
		for(int i=0;i<lines;i++){
			pdfDocument.add(blankRow1);
		}
	}
		
	public PdfPTable createTable(int colNumber){    
        PdfPTable table = new PdfPTable(colNumber);    
        try{    
            //table.setTotalWidth(maxWidth);    
            table.setLockedWidth(true);    
            table.setHorizontalAlignment(Element.ALIGN_CENTER);         
            table.getDefaultCell().setBorder(1);    
        }catch(Exception e){    
            e.printStackTrace();    
        }    
        return table;    
    }  
	
	public PdfPCell createCell(String value,int align,int colspan,boolean boderFlag,Font f8){    
        PdfPCell cell = new PdfPCell();    
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);    
        cell.setHorizontalAlignment(align);        
        cell.setColspan(colspan);    
        cell.setPhrase(new Phrase(value,f8));
        cell.setPaddingLeft(0);
        if(!boderFlag){    
            cell.setBorder(0);    
            cell.setPaddingTop(15.0f);    
            cell.setPaddingBottom(8.0f);
            cell.setPaddingLeft(0);
            cell.setPaddingRight(0);
        }    
       return cell;    
   }
	
	 public PdfPCell createCell(String value,int align,int colspan,boolean boderFlag){    
         PdfPCell cell = new PdfPCell();    
         cell.setVerticalAlignment(Element.ALIGN_MIDDLE);    
         cell.setHorizontalAlignment(align);        
         cell.setColspan(colspan);    
         cell.setPhrase(new Phrase(value,f8));
         cell.setPaddingLeft(0);
         if(!boderFlag){    
             cell.setBorder(0);    
             cell.setPaddingTop(15.0f);    
             cell.setPaddingBottom(8.0f);
             cell.setPaddingLeft(0);
             cell.setPaddingRight(0);
         }    
        return cell;    
    }   
	 public PdfPCell createCellHaveColor(String value,int align,int colspan,boolean boderFlag){    
         PdfPCell cell = new PdfPCell();    
         cell.setVerticalAlignment(Element.ALIGN_MIDDLE);    
         cell.setHorizontalAlignment(align);        
         cell.setColspan(colspan);    
         cell.setPhrase(new Phrase(value,keyfont));    
         cell.setPadding(3.0f);  
        /* cell.setHorizontalAlignment(Element.ALIGN_LEFT);
   		cell.setVerticalAlignment(Element.ALIGN_TOP);
   		cell.setBorderWidth(1f);
   		cell.setFixedHeight(20);
   		cell.setBorderColor(whiteColor);
		cell.setBackgroundColor(new Color(230, 230, 230));*/
         //cell.setBackgroundColor(new Color(230, 230, 230));
         if(!boderFlag){    
             cell.setBorder(0);    
             cell.setPaddingTop(15.0f);    
             cell.setPaddingBottom(8.0f);    
         }    
        return cell;    
    }  
	
	public boolean exportTextContent(String text) throws DocumentException, IOException{
        	//设置中文字体和字体样式
            /*BaseFont bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);  
            Font f8 = new Font(bfChinese, 8, Font.NORMAL);*/
            //pdfDocument.add(new Paragraph("First page of the document.",f8));
		Paragraph paragraph = new Paragraph(text,f8);
		paragraph.setSpacingAfter(10);
		//paragraph.setExtraParagraphSpace(20);
		//paragraph.setLeading(30);//行间距
		paragraph.setIndentationLeft(10);
        pdfDocument.add(paragraph);
        return true;
    }
	
	public boolean addSubject(String text) throws DocumentException, IOException{
    	//设置中文字体和字体样式
        System.err.println("这个方法进去了");
        pdfDocument.addTitle("测试成功");
        pdfDocument.addTitle(text);
        pdfDocument.addSubject(text);
        pdfDocument.addCreator(text);
        return true;
}
	
	public void closePDFDocument() {
		// 关闭PDF文档流，OutputStream文件输出流也将在PDF文档流关闭方法内部关闭
		if (pdfDocument != null) {
			pdfDocument.close();
		}
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		PdfFileExport2 pdfFileExport = new PdfFileExport2();
			try {
				pdfFileExport.initPdfDocument("D:/41导出PDF文档.pdf");
			/*	pdfFileExport.createJIA("办伴科技", "", "13830043277","550426843@qq.com", "");
				pdfFileExport.createYI("办伴科技", "", "13830043277","550426843@qq.com", "");
				pdfFileExport.createRentDeadline("办伴科技", "", "13830043277","550426843@qq.com", "");*/
				//pdfFileExport.createDetailed("办伴科技", "", "13830043277","550426843@qq.com", "");
				/*pdfFileExport.createRemark();
				pdfFileExport.createAccount();
				pdfFileExport.createTerm(pdfFileExport);*/
			} catch (Exception e) {
				e.printStackTrace();
			}  finally{
				pdfFileExport.closePDFDocument();
			}
	}
	
}

