package com.ibm.snam.idm.web_socket;

import com.ibm.snam.idm.common.Constants;
import com.ibm.snam.idm.microservices.AnalyzerMicroservice;
import com.ibm.snam.idm.microservices.BackendMicroservice;
import com.ibm.snam.idm.util.Base64DecodedMultipartFile;
import com.ibm.snam.idm.util.RarHandler;
import com.ibm.snam.idm.util.SevenZipHandler;
import com.ibm.snam.idm.util.ZipHandler;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedList;
import java.util.List;

@Controller
public class UpdateFilesController {

    Logger logger = LoggerFactory.getLogger(UpdateFilesController.class);

    @Autowired
    AnalyzerMicroservice analyzerMicroservice;

    @Autowired
    BackendMicroservice backendMicroservice;

    @MessageMapping("/updateFiles")
    @SendToUser("/queue/reply/updateFiles")
    public String updateFiles(@Payload  JSONObject updateFiles){
        JSONObject response = new JSONObject();
        try{
            JSONArray files = updateFiles.getJSONArray("files");
            List<JSONObject> attachmentsId = new LinkedList<>();
            JSONObject responseFromAnalyzer = new JSONObject();
            for(int i = 0 ; i < files.size() ; i++){
                JSONObject file = files.getJSONObject(i);
                String base64File = file.getString("file");
                String fileName = file.getString("fileName"); 
                ArrayList<MultipartFile> zipFilesArrayList = new ArrayList<MultipartFile>(); 
            	ArrayList<JSONObject> responsesFromAnalyzerZip = new ArrayList<JSONObject>(); 

                
                
                /* 
                 * Codice per la gestione di file compressi 
                 */
                // Tratta il caso in cui l'elemento i-esimo sia uno .zip 
                if(FilenameUtils.getExtension(fileName).equals("zip")) {
                   
                	// Estrae i documenti dallo .zip e li invia a Watson per l'analisi 
                	zipFilesArrayList = ZipHandler.unzipToMultipartArray(base64File); 
                	 for(MultipartFile fileInZip : zipFilesArrayList) {
                		 
                 		logger.info("Uploading document: " + fileInZip.getOriginalFilename()); 
                 		JSONObject result = extractWatsonEnrichedDataFromUnzippedFile(fileInZip); 
                 		responseFromAnalyzer = (JSONObject) result.get("responseFromAnalyzer"); 
                        responsesFromAnalyzerZip.add(responseFromAnalyzer); 
                        attachmentsId.add((JSONObject) result.get("attachmentId")); 

                	 }
                } 
                // Tratta il caso SevenZip
                else if(FilenameUtils.getExtension(fileName).equals("7z")) {
                	
                	zipFilesArrayList = SevenZipHandler.unzipToMultipartArray(base64File); 
               	    for(MultipartFile fileInZip : zipFilesArrayList) {           		 
              		  logger.info("Uploading document: " + fileInZip.getOriginalFilename()); 
              		  JSONObject result = extractWatsonEnrichedDataFromUnzippedFile(fileInZip); 
              		  responseFromAnalyzer = (JSONObject) result.get("responseFromAnalyzer"); 
                       responsesFromAnalyzerZip.add(responseFromAnalyzer); 
                       attachmentsId.add((JSONObject) result.get("attachmentId")); 
             	 }

                } 
                // Caso .rar: supportate tutte le versioni sino alla RAR4
                else if(FilenameUtils.getExtension(fileName).equals("rar")) {
                	
                	zipFilesArrayList = RarHandler.unzipToMultipartArray(base64File); 
               	    for(MultipartFile fileInZip : zipFilesArrayList) {           		 
              		  logger.info("Uploading document: " + fileInZip.getOriginalFilename()); 
              		  JSONObject result = extractWatsonEnrichedDataFromUnzippedFile(fileInZip); 
              		  responseFromAnalyzer = (JSONObject) result.get("responseFromAnalyzer"); 
                       responsesFromAnalyzerZip.add(responseFromAnalyzer); 
                       attachmentsId.add((JSONObject) result.get("attachmentId")); 
             	 }

                }
                
                
                
                
                // Gestisce il caso tradizionale in cui i file non sono zippati 
                else {
                    file = files.getJSONObject(i);
                    base64File = file.getString("file");
                    fileName = file.getString("fileName");
                    byte [] data = Base64.getDecoder().decode(base64File);
                    MultipartFile document = new Base64DecodedMultipartFile(data, fileName);
                    JSONObject attachmentId = new JSONObject();
                    responseFromAnalyzer = analyzerMicroservice.analyzeFile(document);
                    attachmentId.put("idAttachment", responseFromAnalyzer.getString("idAttachment"));
                    attachmentId.put("fileName", fileName);
                    attachmentsId.add(attachmentId);
                }
                
            }
            
            updateFiles.remove("files");
            updateFiles.put("attachmentsId", attachmentsId);
            updateFiles.put("responseFromAnalyzer", responseFromAnalyzer);
            JSONObject responseFromBackend = null;
            if(updateFiles.has("idSupplier")){
                responseFromBackend = backendMicroservice.saveObjectOnDb(updateFiles, "/attachment/uploadAttachmentsForSupplier");
                responseFromBackend.put("updated", "supplier");
                responseFromBackend.put("idSupplier", updateFiles.getString("idSupplier"));
            }
            else{
                responseFromBackend = backendMicroservice.saveObjectOnDb(updateFiles, "/attachment/uploadAttachmentsForTender");
                responseFromBackend.put("updated", "tender");
            }
            responseFromBackend.put("cig", updateFiles.getString("cig"));
            responseFromBackend.put("idTender", updateFiles.getString("idTender"));
            logger.info("Response from backend : " + responseFromBackend);
            return responseFromBackend.toString();
        }catch (Exception e){
            e.printStackTrace();
            response.put("status", Constants.HTTP_STATUS_ERROR);
            response.put("message", Constants.ERROR_CALLING_BACKEND);
            return response.toString();
        }
    }
    
    
    
    
    private JSONObject extractWatsonEnrichedDataFromUnzippedFile(MultipartFile zipFile) {
    	
        JSONObject responseFromAnalyzer = new JSONObject(); 
        JSONObject result = new JSONObject(); 


        logger.info("Uploading document: " + zipFile.getOriginalFilename()); 
        responseFromAnalyzer = analyzerMicroservice.analyzeFile(zipFile); 
        result.put("responseFromAnalyzer", responseFromAnalyzer); 
            
        JSONObject attachmentId = new JSONObject(); 
        attachmentId.put("idAttachment", responseFromAnalyzer.getString("idAttachment")); 
        attachmentId.put("fileName", zipFile.getOriginalFilename()); 
        result.put("attachmentId", attachmentId); 

        return result;   
        
    }
}
