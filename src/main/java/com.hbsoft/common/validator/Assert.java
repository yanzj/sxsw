package com.hbsoft.common.validator;
import com.hbsoft.common.exception.RRException;
import org.apache.commons.lang.StringUtils;

/**
 * ClassName:OrderDaoImpe.java
 * Function: TODO ADD FUNCTION
 * Reason:	 TODO ADD REASON
 * 数据校验
 * @author 张亚强
 * @version Ver 1.1
 * @Date 2018/9/7 16:17
 * @see
 * @since
 */
public  abstract class Assert {
    public static void isBlank(String str, String message) {
        if (StringUtils.isBlank(str)) {
            throw new RRException(message);
        }
    }

    public static void isNull(Object object, String message) {
        if (object == null) {
            throw new RRException(message);
        }
    }
}
