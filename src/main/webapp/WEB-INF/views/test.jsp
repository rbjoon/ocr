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
</head>
<body>
<form id="fileForm" method="post" enctype="multipart/form-data"><input type="file" name="file" multiple="true"></form>
<button onclick="uploadFile()"></button>

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
