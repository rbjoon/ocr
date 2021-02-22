<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Test Page</title>
    <script
            src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<style>
    /* 레이아웃 틀 */
    html {
        height: 100%;
    }

    body {
        margin: 0;
        height: 100%;
        background: #f5f6f7;
        font-family: Dotum, '돋움', Helvetica, sans-serif;
    }

    #logo {
        width: 240px;
        height: 44px;
        cursor: pointer;
    }

    #header {
        padding-top: 62px;
        padding-bottom: 20px;
        text-align: center;
    }

    #wrapper {
        position: relative;
        height: 100%;
    }

    #content {
        position: absolute;
        left: 50%;
        transform: translate(-50%);
        width: 460px;
    }

    /* 입력폼 */

    h3 {
        margin: 19px 0 8px;
        font-size: 14px;
        font-weight: 700;
    }

    .box {
        display: block;
        width: 100%;
        height: 51px;
        border: solid 1px #dadada;
        padding: 10px 14px 10px 14px;
        box-sizing: border-box;
        background: #fff;
        position: relative;
    }

    .int {
        display: block;
        position: relative;
        width: 100%;
        height: 29px;
        border: none;
        background: #fff;
        font-size: 15px;
    }

    input {
        font-family: Dotum, '돋움', Helvetica, sans-serif;
    }

    .box.int_id {
        padding-right: 110px;
    }

    .box.int_pass {
        padding-right: 40px;
    }

    .box.int_pass_check {
        padding-right: 40px;
    }

    .step_url {
        /*@naver.com*/
        position: absolute;
        top: 16px;
        right: 13px;
        font-size: 15px;
        color: #8e8e8e;
    }

    .pswdImg {
        width: 18px;
        height: 20px;
        display: inline-block;
        position: absolute;
        top: 50%;
        right: 16px;
        margin-top: -10px;
        cursor: pointer;
    }

    #bir_wrap {
        display: table;
        width: 100%;
    }

    #bir_yy {
        display: table-cell;
        width: 147px;

    }

    #bir_mm {
        display: table-cell;
        width: 147px;
        vertical-align: middle;
    }

    #bir_dd {
        display: table-cell;
        width: 147px;
    }

    #bir_mm, #bir_dd {
        padding-left: 10px;
    }

    select {
        width: 100%;
        height: 29px;
        font-size: 15px;
        background: #fff url(https://static.nid.naver.com/images/join/pc/sel_arr_2x.gif) 100% 50% no-repeat;
        background-size: 20px 8px;
        -webkit-appearance: none;
        display: inline-block;
        text-align: start;
        border: none;
        cursor: default;
        font-family: Dotum, '돋움', Helvetica, sans-serif;
    }

    /* 에러메세지 */

    .error_next_box {
        margin-top: 9px;
        font-size: 12px;
        color: red;
        display: none;
    }

    #alertTxt {
        position: absolute;
        top: 19px;
        right: 38px;
        font-size: 12px;
        color: red;
        display: none;
    }

    /* 버튼 */

    .btn_area {
        margin: 30px 0 91px;
    }

    #btnJoin {
        width: 100%;
        padding: 21px 0 17px;
        border: 0;
        cursor: pointer;
        color: #fff;
        background-color: #08a600;
        font-size: 20px;
        font-weight: 400;
        font-family: Dotum, '돋움', Helvetica, sans-serif;
    }
</style>
<body>
<form id="fileForm" method="post" enctype="multipart/form-data">
    <!-- wrapper -->
    <div id="wrapper">
        <!-- content-->
        <div id="content">
            <!-- MOBILE -->
            <div>
                <h3 class="join_title"><label>사용방법</label></h3>
                <h3 class="join_title"><label>1. 이미지 첨부</label></h3>
                <h3 class="join_title"><label>2. 텍스트 출력 버튼 클릭</label></h3>
                <h3 class="join_title"><label>OCR 문서 경로 : 07.학습자료\ocr\google vision ocr.pptx</label></h3>
                <h3 class="join_title"><label>구글 VISION 계정 설정후 사용 가능합니다.</label></h3>
            </div>
            <br><br><br>
            <div>
                <h3 class="join_title"><label>이미지 첨부</label></h3>
                <span class="box int_mobile">
                        <input type="file" name="file" multiple="true">
                    </span>
                <span class="error_next_box"></span>
            </div>

            <!-- JOIN BTN-->
            <div class="btn_area">
                <button type="button" id="btnJoin" onclick="uploadFile();">
                    <span>텍스트 출력</span>
                </button>
            </div>


        </div>
        <!-- content-->

    </div>
    <!-- wrapper -->
</form>
</body>

<script type="text/javascript">
    function uploadFile() {
        var formData = new FormData($('#fileForm')[0]);
        $.ajax({
            type       : "POST",
            enctype    : 'multipart/form-data',
            url        : '/multipartUpload',
            data       : formData,
            processData: false,
            contentType: false,
            cache      : false,
            success    : function (result) {
            },
            error      : function (e) {
            }
        });

    }
</script>
</html>
