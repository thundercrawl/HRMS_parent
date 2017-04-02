package hrms.util.pdf;


import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import java.awt.*;
import java.io.*;

public class PdfFileExport {
	
	private static Document pdfDocument;
	private OutputStream pdfFileOutputStream;
	private PdfWriter pdfWriter;
	private Font f8;
	private Font f8_BOLD;
	private Font f16_BOLD;
	private Font BIG_TITLE_BOLD;
	@SuppressWarnings("unused")
	private Color whiteColor;
	private static Font keyfont;
	BaseFont bfChinese = null;
	String fontPath = "";
	public void initPdfDocument(String fullFilePath) throws DocumentException, IOException{
		pdfDocument = new Document(PageSize.A4,50,50,50,50);
			pdfFileOutputStream = new FileOutputStream(new File(fullFilePath));
			//构建一个PDF文档输出流程
        	pdfWriter = PdfWriter.getInstance(pdfDocument,pdfFileOutputStream);
        	//设置作者信息
        	PdfFileExportUtil.setCreatorInfo(pdfDocument);
        	//设置文件只读权限
        	PdfFileExportUtil.setReadOnlyPDFFile(pdfWriter);
        	//通过PDF页面事件模式添加文字水印功能
        	//PdfFileExportUtil pdfFileExportUtil = new PdfFileExportUtil();
        	//pdfWriter.setPageEvent(pdfFileExportUtil.new TextWaterMarkPdfPageEvent("上海办伴科技发展有限公司"));
        	//通过PDF页面事件模式添加图片水印功能
        	String waterMarkFullFilePath = "D:/logo-new.png";//水印图片
        	//pdfWriter.setPageEvent(pdfFileExportUtil.new PictureWaterMarkPdfPageEvent(waterMarkFullFilePath));
        	//通过PDF页面事件模式添加页头和页脚信息功能
        	//pdfWriter.setPageEvent(pdfFileExportUtil.new HeadFootInfoPdfPageEvent());
        	fontPath = PdfFileExport.class.getClassLoader().getResource("")
    				.toString().replaceAll("file:/", "")
    				+ "simsun.ttc";
        	PdfFileExport pdf = new PdfFileExport();
        	
            //打开PDF文件流
        	pdfDocument.open();
        	
			try {
				bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				keyfont = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小    
				f8_BOLD = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小    
				f16_BOLD = new Font(bfChinese, 16, Font.BOLD);// 设置字体大小
				BIG_TITLE_BOLD = new Font(bfChinese, 30, Font.BOLD);// 设置字体大小
				whiteColor = new Color(255, 255, 255);   
			} catch (IOException e) {
				e.printStackTrace();
			}  
            f8 = new Font(bfChinese, 8, Font.NORMAL);
	}
	
	public void initPdfDocument(OutputStream pdfFileOutputStream) throws DocumentException, FileNotFoundException{
		pdfDocument = new Document(PageSize.A4,50,50,50,50);
			//pdfFileOutputStream = new FileOutputStream(new File(fullFilePath));
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
        	fontPath = PdfFileExport.class.getClassLoader().getResource("")
    				.toString().replaceAll("file:/", "")
    				+ "simsun.ttc";
			try {
				bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				keyfont = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小    
				f8_BOLD = new Font(bfChinese, 8, Font.BOLD);// 设置字体大小    
				f16_BOLD = new Font(bfChinese, 16, Font.BOLD);// 设置字体大小
				BIG_TITLE_BOLD = new Font(bfChinese, 30, Font.BOLD);// 设置字体大小
				whiteColor = new Color(255, 255, 255);   
			} catch (IOException e) {
				e.printStackTrace();
			}  
            f8 = new Font(bfChinese, 8, Font.NORMAL);
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
	
	/**
	 * 从数据库中导出数据并以PDF文件形式存储
	 * 列信息较多，行信息可能超过100万
	 * 文档仅有只读权限，设置文档作者信息
	 * 在文档页头设置公司信息版权信息
	 * 添加公司的文字和图片水印信息
	 * @param tableContent
	 * @param rowsNumber
	 * @param submitAmount
	 * @param isProductDiscount 
	 * @param isProjectDiscount 
	 * @return
	 * @throws IOException 
	 * @throws DocumentException 
	 */
	public boolean exportTableContent(String[][] tableContent,int rowsNumber,int submitAmount, boolean isProjectDiscount, boolean isProductDiscount) throws DocumentException, IOException{
        	//设置中文字体和字体样式
            BaseFont bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);  
            Font f16 = new Font(bfChinese, 16, Font.BOLD);
            Font f8 = new Font(bfChinese, 8, Font.NORMAL);
            Paragraph title1 = new Paragraph("租赁产品", f16);
            // 新建章节
            pdfDocument.add(title1);
            createChunk();
            //创建一个N列的表格控件
            PdfPTable pdfTable = new PdfPTable(tableContent[0].length);
            //设置表格占PDF文档100%宽度
            pdfTable.setWidthPercentage(100);
            //水平方向表格控件左对齐
            pdfTable.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
            //创建一个表格的表头单元格
            PdfPCell pdfTableHeaderCell = new PdfPCell();
            //设置表格的表头单元格颜色
            pdfTableHeaderCell.setBackgroundColor(new Color(230, 230, 230));
            pdfTableHeaderCell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
            pdfTableHeaderCell.setMinimumHeight(25);
            pdfTableHeaderCell.setBorder(0);
            for(String tableHeaderInfo : tableContent[0]){
            	pdfTableHeaderCell.setPhrase(new Paragraph(tableHeaderInfo, f8));
            	pdfTable.addCell(pdfTableHeaderCell);
            }
            //创建一个表格的正文内容单元格
            PdfPCell pdfTableContentCell = new PdfPCell();
            pdfTableContentCell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
            pdfTableContentCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
            pdfTableContentCell.setBorder(0);
            //表格内容行数的填充
            for(int i = 1;i <= rowsNumber;i++){
	            for(String tableContentInfo : tableContent[i]){
	            	pdfTableContentCell.setPhrase(new Paragraph(tableContentInfo, f8));
	            	
	            	pdfTable.addCell(pdfTableContentCell);
	            }
	            //表格内容每写满某个数字的行数时，其内容一方面写入物理文件，另一方面释放内存中存留的内容。
	            if((i%submitAmount)==0){
	            	pdfDocument.add(pdfTable);
	            	pdfTable.deleteBodyRows();
                }else if(i==rowsNumber){
                	//如果全部类容完毕且又没达到某个行数限制，则也要写入物理文件中。
                	pdfDocument.add(pdfTable);
                	pdfTable.deleteBodyRows();
                }
            }
            if(isProjectDiscount){
            	 PdfPCell createCellLeft = createCell("跨点折扣", Element.ALIGN_LEFT,3,false);
                 createCellLeft.setPaddingLeft(20);
                 createCellLeft.setHorizontalAlignment(PdfPCell.ALIGN_LEFT);
                 createCellLeft.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                 pdfTable.addCell(createCellLeft);
                 PdfPCell createCellRighr = createCell("2%off", Element.ALIGN_LEFT,3,false);
                 createCellRighr.setPaddingRight(30);
                 createCellRighr.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
                 createCellRighr.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                 pdfTable.addCell(createCellRighr);
            }
            if(isProductDiscount){
           	 PdfPCell createCellLeft = createCell("跨产品折扣", Element.ALIGN_LEFT,3,false);
                createCellLeft.setPaddingLeft(20);
                createCellLeft.setHorizontalAlignment(PdfPCell.ALIGN_LEFT);
                createCellLeft.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                pdfTable.addCell(createCellLeft);
                PdfPCell createCellRighr = createCell("2%off", Element.ALIGN_LEFT,3,false);
                createCellRighr.setPaddingRight(30);
                createCellRighr.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
                createCellRighr.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
                pdfTable.addCell(createCellRighr);
           }
            pdfDocument.add(pdfTable);
           
            return true;
    }
	
	public void createTitle(String titleStr) throws DocumentException{
		Paragraph title = new Paragraph(titleStr, f16_BOLD);
		pdfDocument.add(title);
	}
	
	public void createFirstPayment(String createPDFSendMail) throws DocumentException{
		createTitle("首付款");
		createChunk();
		PdfPTable pdfTable = new PdfPTable(2);
        //设置表格占PDF文档100%宽度
        pdfTable.setWidthPercentage(100);
        //水平方向表格控件左对齐
        pdfTable.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
        PdfPCell repayCell = new PdfPCell();
  		repayCell.setBorderWidth(0);
        PdfPTable pdfTableLeft = new PdfPTable(1);
        pdfTableLeft.addCell(createCellHaveColor("月租金",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCellHaveColor("智慧包租金",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCellHaveColor("安装费",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCellHaveColor("押金",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCellHaveColor("合计",Element.ALIGN_LEFT,1,false));
        repayCell.addElement(pdfTableLeft);
        pdfTable.addCell(repayCell);
        String[] firsetMoneyStr = createPDFSendMail.split(",");
        PdfPCell rightCell = new PdfPCell();
        rightCell.setBorderWidth(0);
        PdfPTable pdfTableRight = new PdfPTable(1);
        pdfTableRight.addCell(createCellHaveColor(firsetMoneyStr[0],Element.ALIGN_RIGHT,1,false));
        pdfTableRight.addCell(createCellHaveColor(firsetMoneyStr[1],Element.ALIGN_RIGHT,1,false));
        pdfTableRight.addCell(createCellHaveColor(firsetMoneyStr[2],Element.ALIGN_RIGHT,1,false));
        pdfTableRight.addCell(createCellHaveColor(firsetMoneyStr[3],Element.ALIGN_RIGHT,1,false));
        pdfTableRight.addCell(createCellHaveColor(firsetMoneyStr[5],Element.ALIGN_RIGHT,1,false));
        rightCell.addElement(pdfTableRight);
        pdfTable.addCell(rightCell);
        pdfDocument.add(pdfTable);
	}
	
	public void createJIA(String name,String post,String phone,String mail,String address) throws DocumentException, IOException{
		BaseFont bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        Font f8 = new Font(bfChinese, 16, Font.BOLD);
        // 标题
        Paragraph title1 = new Paragraph("甲方", f8);
        pdfDocument.add(title1);
        createChunk();
		PdfPTable pdfTable = new PdfPTable(2);
        //设置表格占PDF文档100%宽度
        pdfTable.setWidthPercentage(100);
        //水平方向表格控件左对齐
        pdfTable.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
        PdfPCell repayCell = new PdfPCell();
  		repayCell.setBorderWidth(0);
        PdfPTable pdfTableLeft = new PdfPTable(2);
        pdfTableLeft.addCell(createCell("联系人：",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCell(name,Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCell("职位：",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCell(post,Element.ALIGN_LEFT,1,false));
        
        repayCell.addElement(pdfTableLeft);
        pdfTable.addCell(repayCell);
        PdfPCell rightCell = new PdfPCell();
        rightCell.setBorderWidth(0);
        PdfPTable pdfTableRight = new PdfPTable(2);
        pdfTableRight.addCell(createCell("电话：",Element.ALIGN_LEFT,1,false));
        pdfTableRight.addCell(createCell(phone,Element.ALIGN_LEFT,1,false));
        pdfTableRight.addCell(createCell("邮箱：",Element.ALIGN_LEFT,1,false));
        pdfTableRight.addCell(createCell(mail,Element.ALIGN_LEFT,1,false));
        rightCell.addElement(pdfTableRight);
        pdfTable.addCell(rightCell);
        if(address==null)address="";
        PdfPCell createCell = createCell("账单地址：      "+address,Element.ALIGN_LEFT,2,false);
        createCell.setPaddingLeft(26);
        pdfTable.addCell(createCell);
        pdfDocument.add(pdfTable);
        
        
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
	
	public void createYI(String name,String post,String phone,String mail,String address) throws DocumentException, IOException{
		BaseFont bfChinese = BaseFont.createFont(fontPath+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        Font f8 = new Font(bfChinese, 16, Font.BOLD);
        // 标题
        Paragraph title1 = new Paragraph("乙方", f8);
        // 新建章节
        pdfDocument.add(title1);
        createChunk();
		PdfPTable pdfTable = new PdfPTable(2);
        //设置表格占PDF文档100%宽度
        pdfTable.setWidthPercentage(100);
        //水平方向表格控件左对齐
        pdfTable.setHorizontalAlignment(PdfPTable.ALIGN_LEFT);
        PdfPCell repayCell = new PdfPCell();
  		repayCell.setBorderWidth(0);
        PdfPTable pdfTableLeft = new PdfPTable(2);
        pdfTableLeft.addCell(createCell("联系人：",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCell(name,Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCell("职位：",Element.ALIGN_LEFT,1,false));
        pdfTableLeft.addCell(createCell(post,Element.ALIGN_LEFT,1,false));
        
        repayCell.addElement(pdfTableLeft);
        pdfTable.addCell(repayCell);
        PdfPCell rightCell = new PdfPCell();
        rightCell.setBorderWidth(0);
        PdfPTable pdfTableRight = new PdfPTable(2);
        pdfTableRight.addCell(createCell("电话：",Element.ALIGN_LEFT,1,false));
        pdfTableRight.addCell(createCell(phone,Element.ALIGN_LEFT,1,false));
        pdfTableRight.addCell(createCell("邮箱：",Element.ALIGN_LEFT,1,false));
        pdfTableRight.addCell(createCell(mail,Element.ALIGN_LEFT,1,false));
        rightCell.addElement(pdfTableRight);
        pdfTable.addCell(rightCell);
        if(address==null)address="";
        PdfPCell createCell = createCell("账单地址：      "+address,Element.ALIGN_LEFT,2,false);
        createCell.setPaddingLeft(26);
        pdfTable.addCell(createCell);
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
	
	public void createTerms(PdfFileExport pdfFileExport, String addContent) throws DocumentException, IOException{
		 Paragraph title1 = new Paragraph("合同条款", f16_BOLD);
	        // 新建章节
	        pdfDocument.add(title1);
		createChunk();
		Paragraph pt=new Paragraph("1、本合同",f8_BOLD);
		pt.setAlignment(0);
		pdfDocument.add(pt);
		//1、本合同
		String text = "1.1  	 本合同本着公开、公平、公正的原则由双方协商签订，供应方为商业办公场地提供者和控制者， 客户同意其不因此合同享有任何与办公场所相关的租赁利益、租赁持有地产权或其他房地产权利。供应方出于为客户提供服务的目的，根据本合同以及补充的入驻守则同意客户与供应方共同使用中心。此合同只对客户发生效力，客户在未经过供应方的事先同意，不得转让给任何第三方。供应方将不会无理拒绝客户将协议转让给母公司，附属公司或客户的关联公司来执行许可协议并将会要求受让人承担所有的客户义务，但并不会解除客户的协议（客户须提供文件证明其关联关系）。该合同是由第一页的入住描述、本条款及条件、入驻守则及服务价格指南（如适用）组成的。";
		String text2 = "1.2 	 遵守入驻守则：客户应当遵守供应方为中心使用者制定的入驻守则。";
		String text3 = "1.3 	 自动续约： 此份合同在约定的期限内有效，之后将被自动按原合同等长的期限延长但不少于三个月，（除非法律续约限定应用）直到被客户或者服务提供商终止。请参照1.4条款。所有期限都于到期月份的最后一日到期。延长期的租金应当视当时市场通常价格确定。";
		String text4 = "1.4		 取消：供应方或客户可于合同到期日、延长期限到期日或续租期到期日终止本合同，但需提前3个月以书面方式通知对方。但是，如果合同期限、延长期或续租期等于或少于3个月，且供应方或者客户希望提前终止合同，则该项终止通知应提前2个月做出，或者如果合同期限、延长期或续租期不足2个月（或少于2个月），比该相应期限少一周的时间之前做出。";
		String text5 = "1.5		 即时终止：在法律允许的最大范围内，在下列任何一种情况下，供应方有权书面通知客户立即解除本合同，没收保证金，且无需遵守任何其它程序： (a) 如果客户失去偿债能力、破产、进入清算或者无力清偿到期债务；或者 (b) 客户违反合同义务并无法改正，或者客户自收到供应方要求改正的通知14日内没有改正；或者(c) 客户或经客户允许或邀请进入中心的人员的行为不符合对办公室的通常使用。如果供应方根据以上任何原因终止本协议，客户应履行的义务并不同时终止，包括支付已接受的附加服务费用以及合同剩余期间的每月租金。";
		String text6 = "1.6 	 合同终止，客户应迅速将工作场所清空，并将场所恢复至入驻时的情形。当客户搬离或选择更换至中心内的另一间办公室时，供应方将收取办公室清理费用以支付恢复办公室原貌所需的日常检查和清洁费用。退租费用在各国有所不同并在入驻守则中列示。供应方保留向客户收取额外且合理的修理费用的权利，该费用用于修缮任何非正常的磨损。如果客户将任何物品或私人财产遗留在供应方中心，供应方可以任意处置这些物品，处置物品所需费用由客户负担，供应方不因此对客户负有任何责任，且客户无权主张处置该物品的收益。此条款同样适用于“即时终止”。在客户搬离工作场所后，如供应方被客户要求继续为客户提供接收信件、传真，接听电话和接待访客并妥善转移的服务。为此，供应方将一次性收取业务保留服务费。此服务由本合同截止日起保留3个月。若于客户使用办公室期间并无使用电话，无邮件，传真或访客，则此项服务不适用。此项费用已于入驻守册内说明。如果客户在合同终止后继续使用该工作场所，则客户应为因其未能按时清空办公场所而导致供应方负担的任何损失、主张或责任负责。供应方可选择同意客户延长租期，但客户应支付相应租金、赔偿损失。";
		String text7 = "1.7		 如果中心不再可供使用：如果供应方无法继续为客户提供本协议约定的服务及工作场所，则本协议终止，客户只需支付终止日之前的每月租金以及客户已使用的附加服务费用。供应方应尽力在另一供应方中心为客户找到合适的替换工作场所，供应方将会为妥善安排客户之办公场地进行相关的协商，由双方协商解决是否延续此合同，此条不适用于不可抗力情况。";
		String text8 = "1.8 	 通知：所有客户方给供应方提供的正式通知均应以书面形式送达上述联系地址。";
		String text9 = "1.9 	 员工：在本合同有效期内及期满后6个月内，供应方及客户均不得故意邀请或雇佣任何对方雇佣的在中心工作的员工。此义务适用于任何被雇佣在中心工作的员工直至劳动关系终止后3个月。双方约定，违约方应支付非违约方相当于相关员工1年工资的违约金。此条款并不限制任何一方雇佣通过公开发布广告而应聘的善意且独立的个人。";
		String text10 = "1.10 	 禁止客户代表供应方员工：在本合同有效期内，客户同意，客户和其合伙人、成员、管理人员及员工不得代表供应方的现任或前任员工参与任何针对供应方或供应方的关联企业、成员、管理人员及员工的争端或法律程序或以其他方式提供法律顾问。";
		String text11 = "1.11 	 适用的法律：此份合同在相关中心所在地法律的约束。对于所有争议的诉讼将在中心所在地的省、市或者国家内解决。供应方及其客户均接受具有专属管辖权的法院的专属管辖。如果这些条款和条件的任何规定依适用法律被认定为无效或不可执行，其他规定仍然有效。";
		String text12 = "1.12 	 保密：此合同的条款均需保密。除非法律或政府机关要求供应方或客户披露这些条款，否则供应方或客户均不能在未得到对方许可的情况下披露本合同。合同终止后双方仍需负担保密义务。合同的执行：客户必须支付任何合理和适当的费用包括服务提供商为强制执行合同所付出的的法律费用，不包括服务提供商和客户在需要仲裁调解时所需要各自承担的仲裁调解费。";
		//2. 服务与义务
		String text2_1 = "2.1 	 办公场所：供应方应当提供客户根据本合同同意付费的附带服务的办公场所数量。本合同列明了供应方最初为客户分配的办公场所。客户对分配的办公场所将不享有专一权利。在特定条件下，供应方可能需要重新分配办公场所，但重新分配的场所应与原场所面积基本相同，且供应方会事先将这种变动通知客户。";
		String text2_2 = "2.2 	 办公室服务：供应方将根据客户的要求在正常运营时间，提供服务描述中所列的服务 (可根据要求提供服务价目表) 。如果供应方认为客户的一项特殊要求产生过多的工作量，将有权利收取额外的费用。";
		String text2_3 = "2.3 	 供应方网：供应方不对客户之网络（或互联网）的安全以及客户发布其上的任何信息作出陈述或承诺。客户应当采取任何其认为符合其需求的安全措施（例如加密）。供应方不对客户之可获得的供应方网络（或互联网）的程度与优劣作任何承诺。客户只能在供应方造成过失并在其收到书面通知后的一段合理时间内，要求唯一的赔偿。";
		//3. 提供服务
		String text3_1 = "3.1 	 进入办公场所：供应方可能需要进入客户的办公场所且可以在任意时间进入。但是，除非情况紧急或客户已向供应方发出终止合同的通知，供应方在因检测、修缮或其它非日常巡查、清洁和维护工作需要进入客户办公场所时，应尝试通过口头或电讯手段提前通知客户。供应方也将致力于遵守合理的安全程序以保护客户的商业秘密。";
		String text3_2 = "3.2 	 本合同起始时场所的可用性：如果在本合同起始日时，供应方因合同约定外的原因无法提供本合同约定的办公场所，供应方对客户的任何损失或损害不承担责任，但客户可以解除本合同并无需支付违约金。供应方不会在办公场所可供使用之前向客户收取每月办公室租金。供应方可能延迟合同的起始日期，它将提供给客户另一个和在此份服务合同中注明办公场所至少面积相当的办公室。";
		//4. 使用
		String text4_1 = "4.1 	 客户只得将办公场所用于办公用途，保证任何成员不会违反办伴科技任门店之入驻守则，不会对供应方或者关联第三方人身/财产造成干扰、损坏和危险的行为，不会向供应方提供虚假信息、不会将办公区也用于接纳大量访客的用途（包括但不限于理财、教育、零售、保险、医疗等用途）， 不会复制办公区域的钥匙，门禁和任何可用于进入办公区域的物品，任何因客户成员或关联访客违反法律规定或者本合同条款而对供应方及任何第三方产生的损害进行赔偿。";
		String text4_2 = "4.2 	 客户不得从事与供应方提供的出租服务式办公场地或其附属服务相竞争的业务活动";
		String text4_3 = "4.3 	 客户的名称及地址：客户应仅以自己的名称或其它供应方事先同意的名称经营。";
		String text4_4 = "4.4 	 中心地址的使用：客户可以将中心的地址用作其营业地址。任何其它使用均应获得供应方的事前同意。";
		String text4_5 = "4.5 	 客户未经供应方书面许可，不得将本合同项下的任何权利或者义务转让，供应方有权在提前6个月通知客户的情况下，将本合同下的权利和义务终止或者转让给我司的任何关联方或者任何第三方。";
		//5. 办公场所
		String text5_1 = "5.1 	 客户不能改变其办公场所内任何部分财产，并且必须很好保护中心所有财产，包括您使用的设备，装置和家具。客户应为由客户或者其他经客户明示或暗示的邀请或允许而进入中心的人（包括但不限于全体员工、承包商、代理商或其他出现在该场所的人）所造成的任何损害负责。";
		String text5_2 = "5.2 	 办公设备：未经供应方同意，客户不得安装电缆电线，信息技术设备或电信设备，供应方有权拒绝该等安装。在供应方同意安装的情况下，客户应当允许供应方监督安装(例如，信息技术设备或电力系统)以确定此种安装不会影响其他客户或供应方或建筑物所有权人对场所的使用。";
		String text5_3 = "5.3 	 保险：客户为其带入中心的财产以及其对其员工或其他第三方的责任购买保险是客户的职责。 供应方强烈建议客户购买相关保险。";
		//6. 供应方的责任
		String text6_1 = "6.1 	 供应方的责任范围：在适用法律允许的最大范围内，供应方不对客户与本合同、所接受服务或工作场所相关的任何损失或损害负责，除非此种损失或损害是由于供应方的故意或严重过失所导致的。供应方不因由于机械故障、罢工、供应方丧失对包含中心在内的建筑物权益等原因导致供应方无法提供服务而给客户造成的损害负责，除非供应方出于故意或过失。在任何情况下，客户应当以书面方式通知供应方并给供应方合理时间改正，否则供应方不为客户的任何损失或损害承担责任。如果因供应方的责任无法提供合同约定的服务，在遵守以下限制的前提下，供应方将支付客户用于寻找替代服务的实际且合理的支出。如果客户认为供应方未能提供与本合同约定一致的服务，则客户应以书面形式通知供应方并给予供应方合理期限改正。";
		String text6_2 = "6.2 	 排除间接损失：除非供应方书面同意，否则供应方在任何情况下均不对经营损失、利润损失、预期节约的损失、数据损毁或损失、第三方主张或其它间接损失负责。供应方强烈建议客户为所有此种潜在损失、损害或责任购买保险。";
		String text6_3 = "6.3 	 供应方所承担责任的金额数额限制：任何情况下供应方对客户承担的责任应受到下列限制： • 对人身伤害或死亡的赔偿按实际过错责任承担，但最高上限不超过人民币100万元。[风险提示：若根据法律强制性规定赔偿数额的计算超过该约定限额的，则导致该约定无效。] • 因某一事件或系列相关事件造成的客户个人财产损失赔偿上限为客户方支付的所有费用的总和，我司不对任何间接损失或者预期的损失承担责任 • 其它损失或损害的赔偿原则上为客户的实际损失，但上限不超过自客户搬进办公场所之日起至其有争议的索赔要求发生之日期间客户支付的全部费用的125%。";
		String text6_4 = "6.4 	 客户方应就任何由客户方及访客违反本合同而对我司及任何第三方产生的损害进行赔偿。";
		//7. 费用
		String text7_1 = "7.1 	 税费：客户同意及时支付：（1）应当向政府机关缴纳的全部销售、使用、执行, 消费或其它税款以及许可费用（并且，根据供应方的要求，向供应方提供相关款项的缴纳收据），以及（2）供应方向政府缴纳的关于办公场所的税款，包括但不限于，总收入税、租赁税费、个人有形资产税、印花税或其它文件印花税费。此规定适用于中华人民共和国税法。";
		String text7_2 = "7.2 	 服务保证金／订金：除非已在本协议正面规定了其他金额，否则客户需要在签订本协议时支付相当于两个月办公室月费的服务订金／保证金,并于5个工作日内补齐合同之首付款和保证金（外加增值税／税费（若适用）。[该条的服务定金与7.5预留办公室如何更好衔接？请确认。]该服务保证金由供应方负责保管，但不支付任何利息。该服务保证金用于保证客户履行其在本合同项下的义务。该服务订金／押金或扣除应付费用、业务延续服务费和办公室恢复服务费以及其他供应方应收款项之后的余额将会在客户书面要求返还服务订金／押金且结算完毕后返还给客户。";
		String text7_3 = "7.3 	 如果应支付费用超过供应方所持有的服务保证金，或客户经常不按时向供应方支付到期费用，则 供应方有权要求客户支付额外的保证金。";
		String text7_4 = "7.4 	 客户应当在入驻时按入驻人数支付网络电话设置费。费用总额由入驻守则约定（该由入驻守则可在任何时候索要）。";
		String text7_5 = "7.5 	 支付：供应方始终致力于减少环境负担并鼓励客户参与环保。因此，供应方将会开具并发送电子账单（当地法律允许的情况下）。除大客户可协商确定其他支付方式外，其他客户都将通过直接借记或信用支付等方式自动完成支付（当地银行系统许可的情况下）。客户在签订此合约时，供应方已经确认预留所需办公室。若未能提前30天书面通知供应方取消预订，则需支付三个月租金作为预订保留取消金[建议预定时即支付（相当于3个月租金）定金，否则该条款约定义务无法实际履行。]。本协议下所有客户应付的金额可分配至供应商集团的其它成员。";
		String text7_6 = "7.6 	 滞纳金：如果客户未能按时支付到期费用，则将被收取一定数额的滞纳金。滞纳金的具体金额为每逾期一日所收取的滞纳金为所欠款项的的仟分之三，如果客户认为应付金额有争议，则客户应当按时支付没有争议的部分，否则应支付相应滞纳金。如果客户未能按时交纳应支付的费用和/或利息，或客户违约，则供应方有权决定暂停服务（为了避免疑问，包括拒绝客户进入办公场所）。";
		String text7_7 = "7.7 	 余额不足：如果因余额不足导致支票被拒付或者其它支付请求被拒绝，客户应当为此支付费用。这笔费用的具体金额请参见入驻守则。";
		String text7_8 = "7.8 	 自本合同签订之日起每满一年，除非合同已约定，供应方将以一定比例提高月租金，增长率根据全部项目零售价值指数，或其它供应方提供的可替换的类似价值指数的增长率确定；假设上述增长为相关法律所禁止，则月租金涨幅由入驻守则确定。本条规定只适用于合同生效期和失效期间隔至少12个月的情况。续签合同将根据上述1.3条“期限”的规定进行续约，租金提升将适用于那些合同的生效期和失效期间隔至少12个月的情况。";
		String text7_9 = "7.9 	 标准服务：每月办公室租金、以及客户要求提供的其它经常性服务，应当提前一个月全额付清。除非另行书面约定，否则供应方提供的该等固定的经常性服务按本合同（包括任何更新）期限内的特定费率收费。具体到期付款日在各中心有所不同并在入驻守则中列示。如果按日收费，则该月的收费应以日租金乘以30计算。时间不足1个月的租金应当按日计算。";
		String text7_10 = "7.10 	 即付即用以及其它可选服务：对于即付即用的费用和相关税费（按照供应方公布费率，该费率可能不时变动），供应方将于费用发生后发出账单，客户应于相应附加服务提供所在日历月之后的一个月内支付。具体的 付款日期请参见入驻守则。";
		String text7_11 = "7.11 	 折扣，促销和优惠：对于享受折扣、促销和优惠的客户， 若违反了合约条款或发生两次以上逾期付款的行为，供应方有权终止已给予的各项优惠而不作另行通知。结算时，乙方应将已享受的相应优惠，按正常价格支付。";
		String text7_12 = "7.12 	 访客费用，“访客“系指经客户的许可进入供应方指定区域的人，访客经供应方登记后可在指定区域停留不超过2小时，如在指定区域逗留时间超过2小时，客户应为此支付费用（下称访客费用），收费标准参见办伴网站和入驻守则，而该等收费标准可有供应方不时调整。";
		//8. 合规
		String text8_1 = "8.1 	 遵守法律：客户应当在商业运行当中遵守相关法律和法规。客户不得从事任何与使用商务中心相关的违法行为。客户不得从事任何可能影响供应方或其他人使用中心的行为，不得引起任何侵扰或妨碍，增加供应方所需负担的保险费用，或给客户使用的中心所在的建筑物的任何权利人或给供应方造成损失或损害 (包括对名誉的损害)。客户承认（1）前述条款是供应方签署本合同的基础；以及（2）客户任何违反前述条款的行为都将造成实质违约，供应方有权据此终止本合同，无需进一步通知或遵守其他程序。";
		String text8_2 = "8.2 	 客户已了解并接受其个人资料将被登记于供应方集团网络，以供供应方使用于以服务为目的的商业用途。";
		//9.客户帐号使用安全
		String text9_1 = "9.1 	 “客户“系指供应方同意的可以使用办公区域的人（为避免疑问，任何客户的任何行为都应被视为客户的行为）。客户应通过www.distrii.com.com（下称“办伴网站”）提交成员的名单和身份证件信息，而每一成员均应于在办伴门店办理入驻手续时向我司提供身份证原件及复印件。客户如果希望变更成员名单，应事先通过办伴网站提交变更申请，只有当客户成功提交上述变更申请并完成手续变更后，新成员方可办理办伴门店入驻手续。我司有权拒绝向未列入成员名单的人士或未向我司提供身份证原件的成员开放App使用权限。";
		String text9_2 = "9.2 	 客户之成员就帐号的使用应遵守中华人民共和国法律法规，客户就帐号的使用不在供应方和客户之间产生任何信托、代理、合伙、合资、担保和连带关系。";
		String text9_3 = "9.3 	 客户同意其不就对客户帐号有任何的所有权，客户承诺其成员和访客任何的线上行为遵守中华人民共和国法律法规，供应方有权对客户帐号之违规行为处理和限制关闭。";
		//10.客户退驻约定
		String text10_1 = "10.1 	 合同终止和到期后工商注册地址的注销：合同无论是约定到期还是因违约而提前终止，客户均应在到期后的1个月内去工商管理部门办理“注册地址”变更登记手续。每逾期一日，则客户对供应方按此办公室的日租金的100%按天进行赔偿，造成其他损失的，供应方保留追诉的权利。";
		
		pdfFileExport.exportTextContent(text);
		pdfFileExport.exportTextContent(text2);
		pdfFileExport.exportTextContent(text3);
		pdfFileExport.exportTextContent(text4);
		pdfFileExport.exportTextContent(text5);
		pdfFileExport.exportTextContent(text6);
		pdfFileExport.exportTextContent(text7);
		pdfFileExport.exportTextContent(text8);
		pdfFileExport.exportTextContent(text9);
		pdfFileExport.exportTextContent(text10);
		pdfFileExport.exportTextContent(text11);
		pdfFileExport.exportTextContent(text12);
		createTag("2. 服务与义务");
		pdfFileExport.exportTextContent(text2_1);
		pdfFileExport.exportTextContent(text2_2);
		pdfFileExport.exportTextContent(text2_3);
		pdfFileExport.exportTextContent(text2_3);
		createTag("3. 提供服务");
		pdfFileExport.exportTextContent(text3_1);
		pdfFileExport.exportTextContent(text3_2);
		createTag("4. 使用");
		pdfFileExport.exportTextContent(text4_1);
		pdfFileExport.exportTextContent(text4_2);
		pdfFileExport.exportTextContent(text4_3);
		pdfFileExport.exportTextContent(text4_4);
		pdfFileExport.exportTextContent(text4_5);
		createTag("5. 办公场所");
		pdfFileExport.exportTextContent(text5_1);
		pdfFileExport.exportTextContent(text5_2);
		pdfFileExport.exportTextContent(text5_3);
		createTag("6. 供应方的责任");
		pdfFileExport.exportTextContent(text6_1);
		pdfFileExport.exportTextContent(text6_2);
		pdfFileExport.exportTextContent(text6_3);
		pdfFileExport.exportTextContent(text6_4);
		createTag("7. 费用");
		pdfFileExport.exportTextContent(text7_1);
		pdfFileExport.exportTextContent(text7_2);
		pdfFileExport.exportTextContent(text7_3);
		pdfFileExport.exportTextContent(text7_4);
		pdfFileExport.exportTextContent(text7_5);
		pdfFileExport.exportTextContent(text7_6);
		pdfFileExport.exportTextContent(text7_7);
		pdfFileExport.exportTextContent(text7_8);
		pdfFileExport.exportTextContent(text7_9);
		pdfFileExport.exportTextContent(text7_10);
		pdfFileExport.exportTextContent(text7_11);
		pdfFileExport.exportTextContent(text7_12);
		createTag("8. 合规");
		pdfFileExport.exportTextContent(text8_1);
		pdfFileExport.exportTextContent(text8_2);
		createTag("9. 客户帐号使用安全");
		pdfFileExport.exportTextContent(text9_1);
		pdfFileExport.exportTextContent(text9_2);
		pdfFileExport.exportTextContent(text9_3);
		createTag("9. 客户退驻约定 ");
		pdfFileExport.exportTextContent(text10_1);
		if(addContent!=null&&addContent!=""){
			createTag("追加的内容：");
			pdfFileExport.exportTextContent(addContent);
	}
	}
	
	public void createTerm(PdfFileExport pdfFileExport) throws DocumentException, IOException{
		 Paragraph title1 = new Paragraph("合同条款", f16_BOLD);
	        // 新建章节
	        pdfDocument.add(title1);
		createChunk();
		Paragraph pt=new Paragraph("1、本合同",f8_BOLD);
		pt.setAlignment(1);
		pdfDocument.add(pt);
		//1、本合同
		String text = "1.1  	 本合同本着公开、公平、公正的原则由双方协商签订，供应方为商业办公场地提供者和控制者， 客户同意其不因此合同享有任何与办公场所相关的租赁利益、租赁持有地产权或其他房地产权利。供应方出于为客户提供服务的目的，根据本合同以及补充的入驻守则同意客户与供应方共同使用中心。此合同只对客户发生效力，客户在未经过供应方的事先同意，不得转让给任何第三方。供应方将不会无理拒绝客户将协议转让给母公司，附属公司或客户的关联公司来执行许可协议并将会要求受让人承担所有的客户义务，但并不会解除客户的协议（客户须提供文件证明其关联关系）。该合同是由第一页的入住描述、本条款及条件、入驻守则及服务价格指南（如适用）组成的。";
		String text2 = "1.2 	 遵守入驻守则：客户应当遵守供应方为中心使用者制定的入驻守则。";
		String text3 = "1.3 	 自动续约： 此份合同在约定的期限内有效，之后将被自动按原合同等长的期限延长但不少于三个月，（除非法律续约限定应用）直到被客户或者服务提供商终止。请参照1.4条款。所有期限都于到期月份的最后一日到期。延长期的租金应当视当时市场通常价格确定。";
		String text4 = "1.4		 取消：供应方或客户可于合同到期日、延长期限到期日或续租期到期日终止本合同，但需提前3个月以书面方式通知对方。但是，如果合同期限、延长期或续租期等于或少于3个月，且供应方或者客户希望提前终止合同，则该项终止通知应提前2个月做出，或者如果合同期限、延长期或续租期不足2个月（或少于2个月），比该相应期限少一周的时间之前做出。";
		String text5 = "1.5		 即时终止：在法律允许的最大范围内，在下列任何一种情况下，供应方有权书面通知客户立即解除本合同，没收保证金，且无需遵守任何其它程序： (a) 如果客户失去偿债能力、破产、进入清算或者无力清偿到期债务；或者 (b) 客户违反合同义务并无法改正，或者客户自收到供应方要求改正的通知14日内没有改正；或者(c) 客户或经客户允许或邀请进入中心的人员的行为不符合对办公室的通常使用。如果供应方根据以上任何原因终止本协议，客户应履行的义务并不同时终止，包括支付已接受的附加服务费用以及合同剩余期间的每月租金。";
		String text6 = "1.6 	 合同终止，客户应迅速将工作场所清空，并将场所恢复至入驻时的情形。当客户搬离或选择更换至中心内的另一间办公室时，供应方将收取办公室清理费用以支付恢复办公室原貌所需的日常检查和清洁费用。退租费用在各国有所不同并在入驻守则中列示。供应方保留向客户收取额外且合理的修理费用的权利，该费用用于修缮任何非正常的磨损。如果客户将任何物品或私人财产遗留在供应方中心，供应方可以任意处置这些物品，处置物品所需费用由客户负担，供应方不因此对客户负有任何责任，且客户无权主张处置该物品的收益。此条款同样适用于“即时终止”。在客户搬离工作场所后，如供应方被客户要求继续为客户提供接收信件、传真，接听电话和接待访客并妥善转移的服务。为此，供应方将一次性收取业务保留服务费。此服务由本合同截止日起保留3个月。若于客户使用办公室期间并无使用电话，无邮件，传真或访客，则此项服务不适用。此项费用已于入驻守册内说明。如果客户在合同终止后继续使用该工作场所，则客户应为因其未能按时清空办公场所而导致供应方负担的任何损失、主张或责任负责。供应方可选择同意客户延长租期，但客户应支付相应租金、赔偿损失。";
		String text7 = "1.7		 如果中心不再可供使用：如果供应方无法继续为客户提供本协议约定的服务及工作场所，则本协议终止，客户只需支付终止日之前的每月租金以及客户已使用的附加服务费用。供应方应尽力在另一供应方中心为客户找到合适的替换工作场所，供应方将会为妥善安排客户之办公场地进行相关的协商，由双方协商解决是否延续此合同，此条不适用于不可抗力情况。";
		String text8 = "1.8 	 通知：所有客户方给供应方提供的正式通知均应以书面形式送达上述联系地址。";
		String text9 = "1.9 	 员工：在本合同有效期内及期满后6个月内，供应方及客户均不得故意邀请或雇佣任何对方雇佣的在中心工作的员工。此义务适用于任何被雇佣在中心工作的员工直至劳动关系终止后3个月。双方约定，违约方应支付非违约方相当于相关员工1年工资的违约金。此条款并不限制任何一方雇佣通过公开发布广告而应聘的善意且独立的个人。";
		String text10 = "1.10 	 禁止客户代表供应方员工：在本合同有效期内，客户同意，客户和其合伙人、成员、管理人员及员工不得代表供应方的现任或前任员工参与任何针对供应方或供应方的关联企业、成员、管理人员及员工的争端或法律程序或以其他方式提供法律顾问。";
		String text11 = "1.11 	 适用的法律：此份合同在相关中心所在地法律的约束。对于所有争议的诉讼将在中心所在地的省、市或者国家内解决。供应方及其客户均接受具有专属管辖权的法院的专属管辖。如果这些条款和条件的任何规定依适用法律被认定为无效或不可执行，其他规定仍然有效。";
		String text12 = "1.12 	 保密：此合同的条款均需保密。除非法律或政府机关要求供应方或客户披露这些条款，否则供应方或客户均不能在未得到对方许可的情况下披露本合同。合同终止后双方仍需负担保密义务。合同的执行：客户必须支付任何合理和适当的费用包括服务提供商为强制执行合同所付出的的法律费用，不包括服务提供商和客户在需要仲裁调解时所需要各自承担的仲裁调解费。";
		//2. 服务与义务
		String text2_1 = "2.1 	 办公场所：供应方应当提供客户根据本合同同意付费的附带服务的办公场所数量。本合同列明了供应方最初为客户分配的办公场所。客户对分配的办公场所将不享有专一权利。在特定条件下，供应方可能需要重新分配办公场所，但重新分配的场所应与原场所面积基本相同，且供应方会事先将这种变动通知客户。";
		String text2_2 = "2.2 	 办公室服务：供应方将根据客户的要求在正常运营时间，提供服务描述中所列的服务 (可根据要求提供服务价目表) 。如果供应方认为客户的一项特殊要求产生过多的工作量，将有权利收取额外的费用。";
		String text2_3 = "2.3 	 供应方网：供应方不对客户之网络（或互联网）的安全以及客户发布其上的任何信息作出陈述或承诺。客户应当采取任何其认为符合其需求的安全措施（例如加密）。供应方不对客户之可获得的供应方网络（或互联网）的程度与优劣作任何承诺。客户只能在供应方造成过失并在其收到书面通知后的一段合理时间内，要求唯一的赔偿。";
		//3. 提供服务
		String text3_1 = "3.1 	 进入办公场所：供应方可能需要进入客户的办公场所且可以在任意时间进入。但是，除非情况紧急或客户已向供应方发出终止合同的通知，供应方在因检测、修缮或其它非日常巡查、清洁和维护工作需要进入客户办公场所时，应尝试通过口头或电讯手段提前通知客户。供应方也将致力于遵守合理的安全程序以保护客户的商业秘密。";
		String text3_2 = "3.2 	 本合同起始时场所的可用性：如果在本合同起始日时，供应方因合同约定外的原因无法提供本合同约定的办公场所，供应方对客户的任何损失或损害不承担责任，但客户可以解除本合同并无需支付违约金。供应方不会在办公场所可供使用之前向客户收取每月办公室租金。供应方可能延迟合同的起始日期，它将提供给客户另一个和在此份服务合同中注明办公场所至少面积相当的办公室。";
		//4. 使用
		String text4_1 = "4.1 	 客户只得将办公场所用于办公用途，保证任何成员不会违反办伴科技任门店之入驻守则，不会对供应方或者关联第三方人身/财产造成干扰、损坏和危险的行为，不会向供应方提供虚假信息、不会将办公区也用于接纳大量访客的用途（包括但不限于理财、教育、零售、保险、医疗等用途）， 不会复制办公区域的钥匙，门禁和任何可用于进入办公区域的物品，任何因客户成员或关联访客违反法律规定或者本合同条款而对供应方及任何第三方产生的损害进行赔偿。";
		String text4_2 = "4.2 	 客户不得从事与供应方提供的出租服务式办公场地或其附属服务相竞争的业务活动";
		String text4_3 = "4.3 	 客户的名称及地址：客户应仅以自己的名称或其它供应方事先同意的名称经营。";
		String text4_4 = "4.4 	 中心地址的使用：客户可以将中心的地址用作其营业地址。任何其它使用均应获得供应方的事前同意。";
		String text4_5 = "4.5 	 客户未经供应方书面许可，不得将本合同项下的任何权利或者义务转让，供应方有权在提前6个月通知客户的情况下，将本合同下的权利和义务终止或者转让给我司的任何关联方或者任何第三方。";
		//5. 办公场所
		String text5_1 = "5.1 	 客户不能改变其办公场所内任何部分财产，并且必须很好保护中心所有财产，包括您使用的设备，装置和家具。客户应为由客户或者其他经客户明示或暗示的邀请或允许而进入中心的人（包括但不限于全体员工、承包商、代理商或其他出现在该场所的人）所造成的任何损害负责。";
		String text5_2 = "5.2 	 办公设备：未经供应方同意，客户不得安装电缆电线，信息技术设备或电信设备，供应方有权拒绝该等安装。在供应方同意安装的情况下，客户应当允许供应方监督安装(例如，信息技术设备或电力系统)以确定此种安装不会影响其他客户或供应方或建筑物所有权人对场所的使用。";
		String text5_3 = "5.3 	 保险：客户为其带入中心的财产以及其对其员工或其他第三方的责任购买保险是客户的职责。 供应方强烈建议客户购买相关保险。";
		//6. 供应方的责任
		String text6_1 = "6.1 	 供应方的责任范围：在适用法律允许的最大范围内，供应方不对客户与本合同、所接受服务或工作场所相关的任何损失或损害负责，除非此种损失或损害是由于供应方的故意或严重过失所导致的。供应方不因由于机械故障、罢工、供应方丧失对包含中心在内的建筑物权益等原因导致供应方无法提供服务而给客户造成的损害负责，除非供应方出于故意或过失。在任何情况下，客户应当以书面方式通知供应方并给供应方合理时间改正，否则供应方不为客户的任何损失或损害承担责任。如果因供应方的责任无法提供合同约定的服务，在遵守以下限制的前提下，供应方将支付客户用于寻找替代服务的实际且合理的支出。如果客户认为供应方未能提供与本合同约定一致的服务，则客户应以书面形式通知供应方并给予供应方合理期限改正。";
		String text6_2 = "6.2 	 排除间接损失：除非供应方书面同意，否则供应方在任何情况下均不对经营损失、利润损失、预期节约的损失、数据损毁或损失、第三方主张或其它间接损失负责。供应方强烈建议客户为所有此种潜在损失、损害或责任购买保险。";
		String text6_3 = "6.3 	 供应方所承担责任的金额数额限制：任何情况下供应方对客户承担的责任应受到下列限制： • 对人身伤害或死亡的赔偿按实际过错责任承担，但最高上限不超过人民币100万元。[风险提示：若根据法律强制性规定赔偿数额的计算超过该约定限额的，则导致该约定无效。] • 因某一事件或系列相关事件造成的客户个人财产损失赔偿上限为客户方支付的所有费用的总和，我司不对任何间接损失或者预期的损失承担责任 • 其它损失或损害的赔偿原则上为客户的实际损失，但上限不超过自客户搬进办公场所之日起至其有争议的索赔要求发生之日期间客户支付的全部费用的125%。";
		String text6_4 = "6.4 	 客户方应就任何由客户方及访客违反本合同而对我司及任何第三方产生的损害进行赔偿。";
		//7. 费用
		String text7_1 = "7.1 	 税费：客户同意及时支付：（1）应当向政府机关缴纳的全部销售、使用、执行, 消费或其它税款以及许可费用（并且，根据供应方的要求，向供应方提供相关款项的缴纳收据），以及（2）供应方向政府缴纳的关于办公场所的税款，包括但不限于，总收入税、租赁税费、个人有形资产税、印花税或其它文件印花税费。此规定适用于中华人民共和国税法。";
		String text7_2 = "7.2 	 服务保证金／订金：除非已在本协议正面规定了其他金额，否则客户需要在签订本协议时支付相当于两个月办公室月费的服务订金／保证金,并于5个工作日内补齐合同之首付款和保证金（外加增值税／税费（若适用）。[该条的服务定金与7.5预留办公室如何更好衔接？请确认。]该服务保证金由供应方负责保管，但不支付任何利息。该服务保证金用于保证客户履行其在本合同项下的义务。该服务订金／押金或扣除应付费用、业务延续服务费和办公室恢复服务费以及其他供应方应收款项之后的余额将会在客户书面要求返还服务订金／押金且结算完毕后返还给客户。";
		String text7_3 = "7.3 	 如果应支付费用超过供应方所持有的服务保证金，或客户经常不按时向供应方支付到期费用，则 供应方有权要求客户支付额外的保证金。";
		String text7_4 = "7.4 	 客户应当在入驻时按入驻人数支付网络电话设置费。费用总额由入驻守则约定（该由入驻守则可在任何时候索要）。";
		String text7_5 = "7.5 	 支付：供应方始终致力于减少环境负担并鼓励客户参与环保。因此，供应方将会开具并发送电子账单（当地法律允许的情况下）。除大客户可协商确定其他支付方式外，其他客户都将通过直接借记或信用支付等方式自动完成支付（当地银行系统许可的情况下）。客户在签订此合约时，供应方已经确认预留所需办公室。若未能提前30天书面通知供应方取消预订，则需支付三个月租金作为预订保留取消金[建议预定时即支付（相当于3个月租金）定金，否则该条款约定义务无法实际履行。]。本协议下所有客户应付的金额可分配至供应商集团的其它成员。";
		String text7_6 = "7.6 	 滞纳金：如果客户未能按时支付到期费用，则将被收取一定数额的滞纳金。滞纳金的具体金额为每逾期一日所收取的滞纳金为所欠款项的的仟分之三，如果客户认为应付金额有争议，则客户应当按时支付没有争议的部分，否则应支付相应滞纳金。如果客户未能按时交纳应支付的费用和/或利息，或客户违约，则供应方有权决定暂停服务（为了避免疑问，包括拒绝客户进入办公场所）。";
		String text7_7 = "7.7 	 余额不足：如果因余额不足导致支票被拒付或者其它支付请求被拒绝，客户应当为此支付费用。这笔费用的具体金额请参见入驻守则。";
		String text7_8 = "7.8 	 自本合同签订之日起每满一年，除非合同已约定，供应方将以一定比例提高月租金，增长率根据全部项目零售价值指数，或其它供应方提供的可替换的类似价值指数的增长率确定；假设上述增长为相关法律所禁止，则月租金涨幅由入驻守则确定。本条规定只适用于合同生效期和失效期间隔至少12个月的情况。续签合同将根据上述1.3条“期限”的规定进行续约，租金提升将适用于那些合同的生效期和失效期间隔至少12个月的情况。";
		String text7_9 = "7.9 	 标准服务：每月办公室租金、以及客户要求提供的其它经常性服务，应当提前一个月全额付清。除非另行书面约定，否则供应方提供的该等固定的经常性服务按本合同（包括任何更新）期限内的特定费率收费。具体到期付款日在各中心有所不同并在入驻守则中列示。如果按日收费，则该月的收费应以日租金乘以30计算。时间不足1个月的租金应当按日计算。";
		String text7_10 = "7.10 	 即付即用以及其它可选服务：对于即付即用的费用和相关税费（按照供应方公布费率，该费率可能不时变动），供应方将于费用发生后发出账单，客户应于相应附加服务提供所在日历月之后的一个月内支付。具体的 付款日期请参见入驻守则。";
		String text7_11 = "7.11 	 折扣，促销和优惠：对于享受折扣、促销和优惠的客户， 若违反了合约条款或发生两次以上逾期付款的行为，供应方有权终止已给予的各项优惠而不作另行通知。结算时，乙方应将已享受的相应优惠，按正常价格支付。";
		String text7_12 = "7.12 	 访客费用，“访客“系指经客户的许可进入供应方指定区域的人，访客经供应方登记后可在指定区域停留不超过2小时，如在指定区域逗留时间超过2小时，客户应为此支付费用（下称访客费用），收费标准参见办伴网站和入驻守则，而该等收费标准可有供应方不时调整。";
		//8. 合规
		String text8_1 = "8.1 	 遵守法律：客户应当在商业运行当中遵守相关法律和法规。客户不得从事任何与使用商务中心相关的违法行为。客户不得从事任何可能影响供应方或其他人使用中心的行为，不得引起任何侵扰或妨碍，增加供应方所需负担的保险费用，或给客户使用的中心所在的建筑物的任何权利人或给供应方造成损失或损害 (包括对名誉的损害)。客户承认（1）前述条款是供应方签署本合同的基础；以及（2）客户任何违反前述条款的行为都将造成实质违约，供应方有权据此终止本合同，无需进一步通知或遵守其他程序。";
		String text8_2 = "8.2 	 客户已了解并接受其个人资料将被登记于供应方集团网络，以供供应方使用于以服务为目的的商业用途。";
		//9.客户帐号使用安全
		String text9_1 = "9.1 	 “客户“系指供应方同意的可以使用办公区域的人（为避免疑问，任何客户的任何行为都应被视为客户的行为）。客户应通过www.distrii.com.com（下称“办伴网站”）提交成员的名单和身份证件信息，而每一成员均应于在办伴门店办理入驻手续时向我司提供身份证原件及复印件。客户如果希望变更成员名单，应事先通过办伴网站提交变更申请，只有当客户成功提交上述变更申请并完成手续变更后，新成员方可办理办伴门店入驻手续。我司有权拒绝向未列入成员名单的人士或未向我司提供身份证原件的成员开放App使用权限。";
		String text9_2 = "9.2 	 客户之成员就帐号的使用应遵守中华人民共和国法律法规，客户就帐号的使用不在供应方和客户之间产生任何信托、代理、合伙、合资、担保和连带关系。";
		String text9_3 = "9.3 	 客户同意其不就对客户帐号有任何的所有权，客户承诺其成员和访客任何的线上行为遵守中华人民共和国法律法规，供应方有权对客户帐号之违规行为处理和限制关闭。";
		//10.客户退驻约定
		String text10_1 = "10.1 	 合同终止和到期后工商注册地址的注销：合同无论是约定到期还是因违约而提前终止，客户均应在到期后的1个月内去工商管理部门办理“注册地址”变更登记手续。每逾期一日，则客户对供应方按此办公室的日租金的100%按天进行赔偿，造成其他损失的，供应方保留追诉的权利。";
		
		pdfFileExport.exportTextContent(text);
		pdfFileExport.exportTextContent(text2);
		pdfFileExport.exportTextContent(text3);
		pdfFileExport.exportTextContent(text4);
		pdfFileExport.exportTextContent(text5);
		pdfFileExport.exportTextContent(text6);
		pdfFileExport.exportTextContent(text7);
		pdfFileExport.exportTextContent(text8);
		pdfFileExport.exportTextContent(text9);
		pdfFileExport.exportTextContent(text10);
		pdfFileExport.exportTextContent(text11);
		pdfFileExport.exportTextContent(text12);
		/*createTag("2. 服务与义务");*/
		pdfFileExport.exportTextContent("2. 服务与义务");
		pdfFileExport.exportTextContent(text2_1);
		pdfFileExport.exportTextContent(text2_2);
		pdfFileExport.exportTextContent(text2_3);
		pdfFileExport.exportTextContent(text2_3);
		/*createTag("3. 提供服务");*/
		pdfFileExport.exportTextContent("3. 提供服务");
		pdfFileExport.exportTextContent(text3_1);
		pdfFileExport.exportTextContent(text3_2);
		/*createTag("4. 使用");*/
		pdfFileExport.exportTextContent("4. 使用");
		pdfFileExport.exportTextContent(text4_1);
		pdfFileExport.exportTextContent(text4_2);
		pdfFileExport.exportTextContent(text4_3);
		pdfFileExport.exportTextContent(text4_4);
		pdfFileExport.exportTextContent(text4_5);
		/*createTag("5. 办公场所");*/
		pdfFileExport.exportTextContent("5. 办公场所");
		pdfFileExport.exportTextContent(text5_1);
		pdfFileExport.exportTextContent(text5_2);
		pdfFileExport.exportTextContent(text5_3);
		/*createTag("6. 供应方的责任");*/
		pdfFileExport.exportTextContent("6. 供应方的责任");
		pdfFileExport.exportTextContent(text6_1);
		pdfFileExport.exportTextContent(text6_2);
		pdfFileExport.exportTextContent(text6_3);
		pdfFileExport.exportTextContent(text6_4);
		/*createTag("7. 费用");*/
		pdfFileExport.exportTextContent("7. 费用");
		pdfFileExport.exportTextContent(text7_1);
		pdfFileExport.exportTextContent(text7_2);
		pdfFileExport.exportTextContent(text7_3);
		pdfFileExport.exportTextContent(text7_4);
		pdfFileExport.exportTextContent(text7_5);
		pdfFileExport.exportTextContent(text7_6);
		pdfFileExport.exportTextContent(text7_7);
		pdfFileExport.exportTextContent(text7_8);
		pdfFileExport.exportTextContent(text7_9);
		pdfFileExport.exportTextContent(text7_10);
		pdfFileExport.exportTextContent(text7_11);
		pdfFileExport.exportTextContent(text7_12);
		/*createTag("8. 合规");*/
		pdfFileExport.exportTextContent("8. 合规");
		pdfFileExport.exportTextContent(text8_1);
		pdfFileExport.exportTextContent(text8_2);
		/*createTag("9. 客户帐号使用安全");*/
		pdfFileExport.exportTextContent("9. 客户帐号使用安全");
		pdfFileExport.exportTextContent(text9_1);
		pdfFileExport.exportTextContent(text9_2);
		pdfFileExport.exportTextContent(text9_3);
		/*createTag("9. 客户退驻约定 ");*/
		pdfFileExport.exportTextContent("9. 客户退驻约定");
		pdfFileExport.exportTextContent(text10_1);
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
	
	 public PdfPCell createCell(String value,int align,int colspan,boolean boderFlag){    
         PdfPCell cell = new PdfPCell();    
         cell.setVerticalAlignment(Element.ALIGN_MIDDLE);    
         cell.setHorizontalAlignment(align);        
         cell.setColspan(colspan);    
         cell.setPhrase(new Phrase(value,f8));    
         cell.setPadding(3.0f);    
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
            pdfDocument.add(new Paragraph(text,f8));
            //pdfDocument.add(new Paragraph(text, FontFactory.getFont(FontFactory.COURIER, 14, Font.BOLD, new Color(255, 150, 200))));
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
		/*String[][] tableContent = new String[][]{
				{"序号","姓名","年龄","职业","籍贯","学历","单位名称","联系电话","联系地址",
					"语文","数学","英语","物理","化学","生物","政治","历史","地理","音乐","美术","体育","课外实践","学校名称","备注"},
				{"1","许果","31","软件工程师","浙江杭州","大学本科","浙江水果大王信息技术有限公司","18905710571","浙江省杭州市西湖区三墩镇三墩街188号",
						"85","95","75","90","90","85","80","90","90","75","65","75","80","石城中学","他是一名优秀的IT工程师，日常爱好旅游，运动"}
		};*/
		PdfFileExport pdfFileExport = new PdfFileExport();
		
		try {
			BaseFont bfChinese = null;
			try {
				bfChinese = BaseFont.createFont(""+",1", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
			} catch (IOException e) {
				e.printStackTrace();
			}  
           Font f8 = new Font(bfChinese, 14, Font.BOLD);
			pdfFileExport.initPdfDocument("D:/41导出PDF文档.pdf");
			pdfFileExport.addSubject("This example explains how to add metadata.");
			//pdfFileExport.exportTableContent(tableContent, 100, 20);
			Paragraph pt=new Paragraph("1、本合同",f8);
			pt.setAlignment(1);
			pdfDocument.add(pt);
		} catch (DocumentException e) {
			e.printStackTrace();
			System.err.println("pdf file: " + e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("pdf file: " + e.getMessage());
		}finally{
			pdfFileExport.closePDFDocument();
		}
	}
	
}

