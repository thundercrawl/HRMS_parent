package hrms.util;

public class StringUtil {

	private static final String[] chars = new String[]{"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};

	public static boolean isEmpty(Object obj){
		
		if(obj == null || "".equals(obj.toString().trim())){
			return true;
		}
		
		return false;
	}

	//四位随机大写字母+时间戳(19990101)+四位随机数字
	public static String generateLeaveCode(){
		int index = 0;
		String leaveCode = "";
		for(int i =0;i< 4;i++){
			index = (int) (Math.random()*chars.length);
			leaveCode += chars[index];
		}
        String formatDate = DateUtil.formatDate(DateUtil.SHORT_EN_FORMAT, DateUtil.now());
        leaveCode += formatDate;
        int number = (int) (Math.random() * 10000);
        leaveCode += number;

        return leaveCode;
    }
}
