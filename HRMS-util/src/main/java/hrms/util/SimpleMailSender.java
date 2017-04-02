package hrms.util;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

public class SimpleMailSender {
	/**  
	  * 以文本格式发送邮件  
	  * @param mailInfo 待发送的邮件的信息  
	  */   
	    public static boolean sendTextMail(final MailSenderInfo mailInfo) {   
	      // 判断是否需要身份认证   
	      Properties pro = mailInfo.getProperties();  
	      Authenticator authenticator = null;
	      if (mailInfo.isValidate()) {   
	      // 如果需要身份认证，则创建一个密码验证器   
	        authenticator = new Authenticator(){
	        	 @Override
	             protected PasswordAuthentication getPasswordAuthentication() {
	                 return new PasswordAuthentication(mailInfo.getUserName(),mailInfo.getPassword());
	             }
	        };
	      }  
	      // 根据邮件会话属性和密码验证器构造一个发送邮件的session   
	      Session sendMailSession = Session.getDefaultInstance(pro, authenticator);   
	      try {   
	      // 根据session创建一个邮件消息   
	      Message mailMessage = new MimeMessage(sendMailSession);   
	      // 创建邮件发送者地址   
	      Address from = new InternetAddress(mailInfo.getFromAddress());   
	      // 设置邮件消息的发送者   
	      mailMessage.setFrom(from);   
	      // 创建邮件的接收者地址，并设置到邮件消息中   
	      Address to = new InternetAddress(mailInfo.getToAddress());   
	      mailMessage.setRecipient(Message.RecipientType.TO,to);   
	      // 设置邮件消息的主题   
	      mailMessage.setSubject(mailInfo.getSubject());   
	      // 设置邮件消息发送的时间   
	      mailMessage.setSentDate(new Date());   
	      // 设置邮件消息的主要内容   
	      String mailContent = mailInfo.getContent();   
	      mailMessage.setText(mailContent);   
	      // 发送邮件   
	      Transport.send(mailMessage);  
	      return true;   
	      } catch (MessagingException ex) {   
	          ex.printStackTrace();   
	      }   
	      return false;   
	    }   
	      
	    /**  
	      * 以HTML格式发送邮件  
	      * @param mailInfo 待发送的邮件信息  
	      */   
	    public static boolean sendHtmlMail(MailSenderInfo mailInfo,byte[] createPdf){
	      // 判断是否需要身份认证   
	      Properties pro = mailInfo.getProperties();  
	      Authenticator authenticator = null;
	      if (mailInfo.isValidate()) {   
	    	  final String userName = mailInfo.getUserName();
	    	  final String password = mailInfo.getPassword();
	      // 如果需要身份认证，则创建一个密码验证器   
	        authenticator = new Authenticator(){
	        	 @Override
	             protected PasswordAuthentication getPasswordAuthentication() {
	                 return new PasswordAuthentication(userName,password);
	             }
	        };
	      }   
	      // 根据邮件会话属性和密码验证器构造一个发送邮件的session   
	      Session sendMailSession = Session.getDefaultInstance(pro,authenticator);   
	      File fTemp = null;
	      String absolutePath = "";
	      try {   
	      // 根据session创建一个邮件消息   
	      Message mailMessage = new MimeMessage(sendMailSession);   
	      // 创建邮件发送者地址   
	      Address from = new InternetAddress(mailInfo.getFromAddress());   
	      // 设置邮件消息的发送者   
	      mailMessage.setFrom(from);   
	      // 创建邮件的接收者地址，并设置到邮件消息中   
	      Address to = new InternetAddress(mailInfo.getToAddress());   
	      // Message.RecipientType.TO属性表示接收者的类型为TO   
	      mailMessage.setRecipient(Message.RecipientType.TO,to);   
	      // 设置邮件消息的主题   
	      mailMessage.setSubject(mailInfo.getSubject());   
	      // 设置邮件消息发送的时间   
	      mailMessage.setSentDate(new Date());   
	      // MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象   
	      Multipart mainPart = new MimeMultipart();   
	      // 创建一个包含HTML内容的MimeBodyPart   
	      BodyPart html = new MimeBodyPart();   
	      // 设置HTML内容   
	      html.setContent(mailInfo.getContent(), "text/html; charset=utf-8");   
	      mainPart.addBodyPart(html);  
	      MimeBodyPart mbp=new MimeBodyPart();  
	      File file = new File("/");
	      fTemp = File.createTempFile("Contract", ".pdf", file);
	      FileOutputStream writeFile = new FileOutputStream(fTemp);
	      String name = fTemp.getName();
	      writeFile.write(createPdf);
	      writeFile.close();
	      File fileSend = new File("/"+name);
	      absolutePath = fileSend.getAbsolutePath();
	      FileDataSource fds=new FileDataSource(fileSend); //得到数据源  
          mbp.setDataHandler(new DataHandler(fds)); //得到附件本身并至入BodyPart  
          System.err.println(fds.getName());
          mbp.setFileName(MimeUtility.encodeWord(fds.getName())); 
          mainPart.addBodyPart(mbp);
	      // 将MiniMultipart对象设置为邮件内容   
	      mailMessage.setContent(mainPart);   
	      // 发送邮件   
	      Transport.send(mailMessage);   
	      return true;   
	      } catch (MessagingException ex) {   
	          ex.printStackTrace();   
	      } catch (IOException e) {
			e.printStackTrace();
		} finally{
			fTemp.deleteOnExit();
			DeleteFolder(absolutePath);
		}
	      return false;   
	    } 
	    
	    /**  
	      * 以HTML格式发送邮件  
	      * @param mailInfo 待发送的邮件信息  
	      */   
	    public static boolean sendMail(MailSenderInfo mailInfo){
	      // 判断是否需要身份认证   
	      Properties pro = mailInfo.getProperties();  
	      Authenticator authenticator = null;
	      if (mailInfo.isValidate()) {   
	    	  final String userName = mailInfo.getUserName();
	    	  final String password = mailInfo.getPassword();
	      // 如果需要身份认证，则创建一个密码验证器   
	        authenticator = new Authenticator(){
	        	 @Override
	             protected PasswordAuthentication getPasswordAuthentication() {
	                 return new PasswordAuthentication(userName,password);
	             }
	        };
	      }   
	      // 根据邮件会话属性和密码验证器构造一个发送邮件的session   
	      Session sendMailSession = Session.getDefaultInstance(pro,authenticator);   
	      String absolutePath = "";
	      try {   
	      // 根据session创建一个邮件消息   
	      Message mailMessage = new MimeMessage(sendMailSession);   
	      // 创建邮件发送者地址   
	      Address from = new InternetAddress(mailInfo.getFromAddress());   
	      // 设置邮件消息的发送者   
	      mailMessage.setFrom(from);   
	      // 创建邮件的接收者地址，并设置到邮件消息中   
	      Address to = new InternetAddress(mailInfo.getToAddress());   
	      // Message.RecipientType.TO属性表示接收者的类型为TO   
	      mailMessage.setRecipient(Message.RecipientType.TO,to);   
	      // 设置邮件消息的主题   
	      mailMessage.setSubject(mailInfo.getSubject());   
	      // 设置邮件消息发送的时间   
	      mailMessage.setSentDate(new Date());   
	      // MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象   
	      Multipart mainPart = new MimeMultipart();   
	      // 创建一个包含HTML内容的MimeBodyPart   
	      BodyPart html = new MimeBodyPart();   
	      // 设置HTML内容   
	      html.setContent(mailInfo.getContent(), "text/html; charset=utf-8");   
	      mainPart.addBodyPart(html);  
	      MimeBodyPart mbp=new MimeBodyPart();  
	      File fileSend = new File("/home/workspace/pdf/账单pdf打包文件.zip");
	      //File fileSend = new File("D:\\pdf\\账单pdf打包文件.zip");
	      absolutePath = fileSend.getAbsolutePath();
	      FileDataSource fds=new FileDataSource(fileSend); //得到数据源  
         mbp.setDataHandler(new DataHandler(fds)); //得到附件本身并至入BodyPart  
         System.err.println(fds.getName());
         mbp.setFileName(MimeUtility.encodeWord(fds.getName())); 
         mainPart.addBodyPart(mbp);
	      // 将MiniMultipart对象设置为邮件内容   
	      mailMessage.setContent(mainPart);   
	      // 发送邮件   
	      Transport.send(mailMessage);   
	      return true;   
	      } catch (MessagingException ex) {   
	          ex.printStackTrace();   
	      } catch (Exception e) {
			e.printStackTrace();
		} finally{
			//DeleteFolder(absolutePath);
		}
	      return false;   
	    } 
	    
	    public static void main(String[] args){
	    	MailSenderInfo mailSenderInfo = new MailSenderInfo();
			mailSenderInfo.setContent("你好，以下附件是明天开会所需资料");
			mailSenderInfo.setToAddress("550426843@qq.com");
			mailSenderInfo.setFromAddress("chenlong@distrii.com");
			mailSenderInfo.setUserName("chenlong@distrii.com");
			mailSenderInfo.setPassword("qwer1234!@#$");
			mailSenderInfo.setSubject("2016年上海办伴科技有限公司合同订单明细");
			mailSenderInfo.setMailServerHost("smtp.distrii.com");
/*			mailSenderInfo.setFromAddress("kelaodelongteng@163.com");
			mailSenderInfo.setUserName("kelaodelongteng@163.com");
			mailSenderInfo.setPassword("147896junmo");
			mailSenderInfo.setSubject("2016年上海办伴科技有限公司合同订单明细");
			mailSenderInfo.setMailServerHost("smtp.163.com");
*/			mailSenderInfo.setValidate(true);
			boolean sendHtmlMail = SimpleMailSender.sendMail(mailSenderInfo);
			System.err.println(sendHtmlMail);
	    }
	    
	    /**  
	      * 以HTML格式发送邮件  
	      * @param mailInfo 待发送的邮件信息  附件为excel
	      */   
	    public static boolean sendHtmlMailExcel(MailSenderInfo mailInfo,HSSFWorkbook wb,String fileName){
	      // 判断是否需要身份认证   
	      Properties pro = mailInfo.getProperties();  
	      Authenticator authenticator = null;
	      if (mailInfo.isValidate()) {   
	    	  final String userName = mailInfo.getUserName();
	    	  final String password = mailInfo.getPassword();
	      // 如果需要身份认证，则创建一个密码验证器   
	        authenticator = new Authenticator(){
	        	 @Override
	             protected PasswordAuthentication getPasswordAuthentication() {
	                 return new PasswordAuthentication(userName,password);
	             }
	        };
	      }   
	      // 根据邮件会话属性和密码验证器构造一个发送邮件的session   
	      Session sendMailSession = Session.getDefaultInstance(pro,authenticator);   
	      File fTemp = null;
	      String absolutePath = "";
	      try {   
	      // 根据session创建一个邮件消息   
	      Message mailMessage = new MimeMessage(sendMailSession);   
	      // 创建邮件发送者地址   
	      Address from = new InternetAddress(mailInfo.getFromAddress());   
	      // 设置邮件消息的发送者   
	      mailMessage.setFrom(from);   
	      // 创建邮件的接收者地址，并设置到邮件消息中   
	      Address to = new InternetAddress(mailInfo.getToAddress());   
	      // Message.RecipientType.TO属性表示接收者的类型为TO   
	      mailMessage.setRecipient(Message.RecipientType.TO,to);   
	      // 设置邮件消息的主题   
	      mailMessage.setSubject(mailInfo.getSubject());   
	      // 设置邮件消息发送的时间   
	      mailMessage.setSentDate(new Date());   
	      // MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象   
	      Multipart mainPart = new MimeMultipart();   
	      // 创建一个包含HTML内容的MimeBodyPart   
	      BodyPart html = new MimeBodyPart();   
	      // 设置HTML内容   
	      html.setContent(mailInfo.getContent(), "text/html; charset=utf-8");   
	      mainPart.addBodyPart(html);  
	      MimeBodyPart mbp=new MimeBodyPart();  
	      
	      FileOutputStream outputStream;
	         File file = new File("/home/banban/email_file/");
	   	      fTemp = File.createTempFile(fileName, ".xls", file);
				outputStream = new FileOutputStream(fTemp);
				 wb.write(outputStream);
			     outputStream.flush();
			     outputStream.close();
			     String name = fTemp.getName();
			      File fileSend = new File("/home/banban/email_file/"+name);
			      absolutePath = fileSend.getAbsolutePath();
			      FileDataSource fds=new FileDataSource(fileSend); //得到数据源  
		         mbp.setDataHandler(new DataHandler(fds)); //得到附件本身并至入BodyPart  
		         System.err.println(fds.getName());
		         mbp.setFileName(MimeUtility.encodeWord(fds.getName())); 
		         mainPart.addBodyPart(mbp);
			      // 将MiniMultipart对象设置为邮件内容   
			      mailMessage.setContent(mainPart);  
	      // 发送邮件   
	      Transport.send(mailMessage);   
	      return true;   
	      } catch (MessagingException ex) {   
	          ex.printStackTrace();   
	      } catch (IOException e) {
			e.printStackTrace();
		} finally{
			fTemp.deleteOnExit();
			DeleteFolder(absolutePath);
		}
	      return false;   
	    } 
	    
	    private static boolean DeleteFolder(String sPath) {  
	       boolean flag = false;  
	       File file = new File(sPath);  
	        // 判断目录或文件是否存在  
	        if (!file.exists()) {  // 不存在返回 false  
	            return flag;  
	        } else {  
	            // 判断是否为文件  
	            if (file.isFile()) {  // 为文件时调用删除文件方法  
	                return deleteFile(sPath);  
	            } else {  // 为目录时调用删除目录方法  
	                return deleteDirectory(sPath);  
	            }  
	        }  
	    }
	    public static boolean deleteFile(String sPath) {  
	       boolean flag = false;  
	       File file = new File(sPath);  
	        // 路径为文件且不为空则进行删除  
	        if (file.isFile() && file.exists()) {  
	            file.delete();  
	            flag = true;  
	        }  
	        return flag;  
	    }
	    public static boolean deleteDirectory(String sPath) {  
	        //如果sPath不以文件分隔符结尾，自动添加文件分隔符  
	        if (!sPath.endsWith(File.separator)) {  
	            sPath = sPath + File.separator;  
	        }  
	        File dirFile = new File(sPath);  
	        //如果dir对应的文件不存在，或者不是一个目录，则退出  
	        if (!dirFile.exists() || !dirFile.isDirectory()) {  
	            return false;  
	        }  
	        boolean flag = true;  
	        //删除文件夹下的所有文件(包括子目录)  
	        File[] files = dirFile.listFiles();  
	        for (int i = 0; i < files.length; i++) {  
	            //删除子文件  
	            if (files[i].isFile()) {  
	                flag = deleteFile(files[i].getAbsolutePath());  
	                if (!flag) break;  
	            } //删除子目录  
	            else {  
	                flag = deleteDirectory(files[i].getAbsolutePath());  
	                if (!flag) break;  
	            }  
	        }  
	        if (!flag) return false;  
	        //删除当前目录  
	        if (dirFile.delete()) {  
	            return true;  
	        } else {  
	            return false;  
	        }  
	    }  
}
