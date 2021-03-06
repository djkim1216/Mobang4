<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-bs4.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/admin/css/reset.css">
<title>부동산 필수웹 모방</title>
</head>
<body>




<div class ="container">

	<form action="notice_updateres.admin" method="post">
		<input type="hidden" value="${dto.seq_nt }" name="seq_nt"/> <!-- 수정할 때 글봐야하니까. -->
		<h2>${dto.title_nt }</h2>	
		<br/>
		
		
		<p>내용</p><br/>
		<textarea id="summernote" name="content_nt">${dto.content_nt }</textarea>
	    <script>
	      $('#summernote').summernote({

	        tabsize: 2,
	        height: 100
	      });
	    </script>
		
		
		
		<input type="submit" value="수정" />
		<input type="button" value="취소" onclick="location.href='notice_list.admin'"/>
		<input type="button" value="삭제" onclick="location.href='notice_delete.admin?seq_nt=${dto.seq_nt}'"/>
	</form>
</div>


</body>
</html>