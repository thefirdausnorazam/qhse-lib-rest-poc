package com.ideagen.qhse.pojo.text;

/**
 * ThreadLocal stored MessageSource
 * 
 */
public class Messages {

    static ThreadLocal threadLocal = new ThreadLocal();

    /**
     * @see Messages#getMessageSource()
     */
    public static MessageSource getMessageSource() {
        MessageSource messageSource = (MessageSource) threadLocal.get();
        if (messageSource == null) {
            throw new RuntimeException("No message source bound to thread: "
                    + Thread.currentThread().getName());
        }
        return messageSource;
    }

    /**
     * @see MessageSource#getMessage(String, Object[], String)
     */
    public static String resolve(String code, Object[] args, String defaultMessage) {
        return getMessageSource().getMessage(code, args, defaultMessage);
    }

    /**
     * @see MessageSource#getMessage(String, Object[], String)
     */
    public static String resolve(String code, Object[] args) {
        return getMessageSource().getMessage(code, args, code);
    }

    /**
     * @see MessageSource#getMessage(String, String)
     */
    public static String resolve(String code, String defaultMessage) {
        return getMessageSource().getMessage(code, defaultMessage);
    }

    /**
     * @see MessageSource#getMessage(String, String)
     */
    public static String resolve(String code) {
        return getMessageSource().getMessage(code, code);
    }

}
