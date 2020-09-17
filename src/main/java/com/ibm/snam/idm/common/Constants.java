package com.ibm.snam.idm.common;

public class Constants {

    public static final String ERROR_CALLING_ANALYZER = "Errore nella chiamata al microservizio Analyzer";

    public static final String ERROR_CALLING_BACKEND = "Errore nella chiamata al backend";
    public static final String ERROR_CREATING_TENDER = "Errore nella creazione della gara";
    public static final String ERROR_CREATING_SUPPLIER = "Errore nella creazione del fornitore";
    public static final String TENDER_ALREADY_PRESENT = "Esiste una gara con lo stesso numero SAP";
    public static final int HTTP_STATUS_OK = 200;
    public static final int HTTP_STATUS_ERROR = 500;

    public static final String ERROR_DELETING_NOTIFICATION = "Errore durante l'eliminazione della notifica";
    public static final String TENDER_ALREADY_EXIST = "TENDER_ALREADY_EXIST";
    public static final String TENDER_CREATED_WITH_MISSING_DATA = "TENDER_CREATED_WITH_MISSING_DATA";
    public static final String TENDER_CREATED = "TENDER_CREATED";

    public static final Object MESSAGE_TENDER_CREATED_WITH_MISSING_DATA = "Gara creata con parametri mancanti";
}
