package com.ideagen.qhse.pojo.text;

/**
 * To be implemented by objects that can resolve messages.
 */
public interface MessageSource {

    /**
     * @param code
     * @param args
     * @param defaultMessage
     * @return
     */
    String getMessage(String code, Object[] args, String defaultMessage);

    /**
     * @param code
     * @param defaultMessage
     * @return
     */
    String getMessage(String code, String defaultMessage);

}
