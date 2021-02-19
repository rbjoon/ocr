package com.example.demo.controller;

import com.google.cloud.vision.v1.*;
import com.google.protobuf.ByteString;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class TestController {

    @RequestMapping(value = "/test")
    public String test(Model model) throws Exception {
        return "/test";

    }

    @RequestMapping(value = "/multipartUpload", method = RequestMethod.POST)
    public @ResponseBody
    String multipartUpload(MultipartHttpServletRequest request) throws Exception {
        List<MultipartFile> fileList = request.getFiles("file");

        String path = "C:\\Workspace\\theShop\\webapp\\upload\\wsale\\bbs\\";
        String saveFileName = "";
        File fileDir = new File(path);
        if (!fileDir.exists()) {
            fileDir.mkdirs();
        }
        long time = System.currentTimeMillis();
        for (MultipartFile mf : fileList) {
            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
            saveFileName = String.format("%d_%s", time, originFileName);
            try {
                // 파일생성
                mf.transferTo(new File(path, saveFileName));

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        InputStream newImg =  new FileInputStream(new File(path+saveFileName));

        String dd = ocrJpg(saveFileName);
        //List<String> kk = conversionPdf2Img(newImg, saveFileName);
       /*if("pdf".equals(fileType)){
           //p

        }else{

        }*/



        return "SUCCESS";
    }

    public String ocrJpg(String saveFileName) throws Exception{

        String result = "";
        Map<String, Object> modelMap = new HashMap<String, Object>();

        String filePath = "C:\\Workspace\\theShop\\webapp\\upload\\wsale\\bbs\\"+ saveFileName;

        List<AnnotateImageRequest> requestsList = new ArrayList<>();

        ByteString imgBytes = ByteString.readFrom(new FileInputStream(filePath));

        Image img = Image.newBuilder().setContent(imgBytes).build();
        Feature feat = Feature.newBuilder().setType(Feature.Type.TEXT_DETECTION).build();
        AnnotateImageRequest Annorequest =
                AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
        requestsList.add(Annorequest);

        // Initialize client that will be used to send requests. This client only needs to be created
        // once, and can be reused for multiple requests. After completing all of your requests, call
        // the "close" method on the client to safely clean up any remaining background resources.
        try {
            ImageAnnotatorClient client = ImageAnnotatorClient.create();
            BatchAnnotateImagesResponse batchResponse = client.batchAnnotateImages(requestsList);
            List<AnnotateImageResponse> responses = batchResponse.getResponsesList();


            String pharmacyName  = "";
            String userName = "" ;
            String bussinessNum ="" ;

            for (AnnotateImageResponse res : responses) {
                if (res.hasError()) {
                    System.out.print(res.getError());
                }

                // For full list of available annotations, see http://g.co/cloud/vision/docs
                for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
                    if(annotation.getLocale()!= ""){
                        String str = annotation.getDescription();
                        Pattern pattern1 = Pattern.compile("(?<=호 :).*.(?=\n)");
                        Pattern pattern2 = Pattern.compile("(?<=명 :).*.(?=\n)");
                        Matcher matcher1 = pattern1.matcher(str);
                        Matcher matcher2 = pattern2.matcher(str);

                        while (matcher1.find()) {
                            String findText = matcher1.group().toString();
                            if(findText.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
                                pharmacyName = findText;
                            }else{
                                bussinessNum = findText;
                            }
                        }
                        while (matcher2.find()) {
                            String findText = matcher2.group().toString();
                            userName = findText;
                        }
                    }

                    System.out.println(annotation);
                    /*System.out.println("사업자번호 : " + bussinessNum);
                    System.out.println("약국명 : " + pharmacyName);
                    System.out.println("이름 : " + userName);
                    break;
*/
                }
            }
            result = "SUCCESS";
            System.out.println("!@#!@#");
        } catch (Exception e) {
            System.out.println(e);
            result = "FAIL";
        }

        return result;
    }

    private List<String> conversionPdf2Img(InputStream is, String imgName) {
        List<String> savedImgList = new ArrayList<>(); //저장된 이미지 경로를 저장하는 List 객체
        try {
            PDDocument pdfDoc = PDDocument.load(is); //Document 생성
            PDFRenderer pdfRenderer = new PDFRenderer(pdfDoc);

            String resultImgPath = "C:\\Workspace\\theShop\\webapp\\upload\\wsale\\bbs\\pdf\\"; //이미지가 저장될 경로
            Files.createDirectories(Paths.get(resultImgPath)); //PDF 2 Img에서는 경로가 없는 경우 이미지 파일이 생성이 안되기 때문에 디렉토리를 만들어준다.

            //순회하며 이미지로 변환 처리
            for (int i=0; i<pdfDoc.getPages().getCount(); i++) {
                String imgFileName = resultImgPath + "/" + i + ".png";

                //DPI 설정
                BufferedImage bim = pdfRenderer.renderImageWithDPI(i, 300, ImageType.RGB);

                // 이미지로 만든다.
                ImageIOUtil.writeImage(bim, imgFileName , 300);

                System.out.println("!@#!@");
                //저장 완료된 이미지를 list에 추가한다.
                savedImgList.add(imgFileName);
            }
            pdfDoc.close(); //모두 사용한 PDF 문서는 닫는다.
        }
        catch (FileNotFoundException e) {
            System.out.println(e);
        }
        catch (IOException e) {
            System.out.println(e);
            System.out.println("Change fail pdf to image. IOException");
        }
        return savedImgList;
    }

}
