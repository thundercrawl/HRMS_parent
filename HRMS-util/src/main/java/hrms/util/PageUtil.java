package hrms.util;

public class PageUtil {
public long getTotalPage(int count,int pagesize){
	int s=1;
	if(count%pagesize==0){
		s= count/pagesize;
	}else{
		s= (count/pagesize)+1;
	}
	return (long)s;
}
}
