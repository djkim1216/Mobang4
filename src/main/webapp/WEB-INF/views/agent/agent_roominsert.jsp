<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" type="text/css" href="resources/agent/css/reset.css">
<link rel="stylesheet" type="text/css" href="resources/agent/css/agent_roominsert.css">
<script type="text/javascript">

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;
            document.getElementById("jibunAddress").value = data.jibunAddress;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}

</script>
</head>
<body>
<%@ include file="form/agent_header.jsp" %>
	<section class = "top_container">
        <div class = "container">
            <div class = "main_title">
                방올리기
            </div>
        </div>
    </section>
			<form action="roominsertres.agent" method="post" enctype="multipart/form-data">
			<input type="hidden" value="missdla4929@naver.com" name="email"><!-- 나중에 session에 담긴 이메일값으로 변경 -->
    <section class = "map_container">
    	<div class = "container _00">
    		<p class = "title">위치정보</p>
				<div class="location">
					<input type="text" id="postcode" placeholder="우편번호" readonly="readonly">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br> 
					<input type="text" id="roadAddress" placeholder="도로명주소" readonly="readonly" name="addr_rm" required="required"> 
					<input type="text" id="jibunAddress" placeholder="지번주소">
					<input type="text" id="detailAddress" placeholder="상세주소" name="addr_dt_rm" required="required">
					<input type="text" id="extraAddress" placeholder="참고항목" readonly="readonly">
					<span id="guide" style="color: #999; display: none"></span><br> 
				</div>
		</div>
    </section>
    <section class = "photo_container">
    	<div class = "container _01">
    		<p class = "title">사진등록</p>
    		<input multiple="multiple" id ="gdsImgs" type="file" name="file" placeholder="파일선택 "/><br/>
    		<div class= "photo_wrap">
	    	</div>
    	</div>
    </section>
    
    
    <script>
    // 파일 업로드 한  파일을 미리 보는 script
    var sel_files =[];
    
    $(document).ready(function() {
    	$("#gdsImgs").on("change", handleImgFileSelect);
    });
    
    
    function handleImgFileSelect(e) {
    	
    	sel_files =[];
    	var files = e.target.files;
    	var fileArr = Array.prototype.slice.call(files);
    	
    	var index=0;
    	fileArr.forEach(function(f) {
    		if(!f.type.match("image.*")) {
    			alert("확장자는 이미지 확장자만 가능합니다.");
    			return;
    		}
    		
    		sel_files.push(f);
    		
    		var reader = new FileReader();
    		reader.onload = function(e) {
    			var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\""+
    						"id=\"img_id_"+index+"\"><img src=\""+e.target.result+"\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
    			$(".photo_wrap").append(html);
    			index++;
    		}
    		reader.readAsDataURL(f);
    	});
    	
    	
    	
    	
    	
    }
    // 사진 클릭하면 삭제
    function deleteImageAction(index) {
    	console.log("index : "+index);
    	sel_files.splice(index, 1);
    	
    	var img_id = "#img_id_"+index;
    	$(img_id).remove();
    	
    	console.log(sel_files);
    	
    }
    
    
	 
	 </script>
    
    <section class = "dt_container">
    	<div class = "container _02">
    		<p class = "title">상세정보</p>
    			<table class = "navy_theme">
    			
    				<tr>
    					<th>계약형태</th>
    					<td>
    						<div>
    							<input type = "radio" name= "rent_rm" checked="checked" value = "월세" required="required"/><span>월세</span>
    							<input type = "radio" name= "rent_rm" value = "전세"/><span>전세</span>
    							<input type = "radio" name= "rent_rm" value = "매매"/><span>매매</span>
    						</div>
    					</td>
    				</tr>
    				<tr>	
    					<th>보증금/월세</th>
    					<td><input type = "text" name = "roomprice_rm" placeholder="금액을 입력해주세요." required="required"/><span>만원</span><span class="remark">※무보증일 경우 0/월세를 입력, 월세가 없을시 보증금/0을 입력하세요.</span></td>
    				</tr>
    				<tr>	
    					<th>방구조</th>
    					<td>
    						<select name = "roomtype_rm" class="roomtype">
    							<option value = "원룸" selected="selected">원룸</option>
    							<option value = "투룸">투룸</option>
    							<option value = "쓰리룸">쓰리룸</option>
    							<option value = "오피스텔">오피스텔</option>
    							<option value = "아파트">아파트</option>
    						</select>
    					</td>
    				</tr>
    				<tr>	
    					<th>관리비</th>
    					<td><input type = "text" name = "expense_rm" placeholder="금액을 입력해주세요." required="required"/><span>만원</span><span class="remark">※ 없을시엔 0 입력.</span></td>
    				</tr>
    				<tr>	
    					<th>크기</th>
    					<td><span>전용 면적 : </span><input type = "text" name = "roomsize_rm" required="required"/><span>㎡ </span><br/>
    						<span>계약 면적 : </span><input type = "text" name = "roomsize2_rm" required="required"/><span>㎡</span><br/>
    					</td>
    				</tr>
    				<tr>
    					<th>층수</th>
    					<td>
    						<span>해당 층 수 : </span><input type = "text" name = "floor_rm" required="required"/><span> / 건물 층 수 : </span><input type = "text" name = "floor2_rm" required="required">
    					</td>
    				</tr>
    				<tr>
    					<th>옵션</th>
    					<td>
    						<div>
    							<input type = "checkbox" name = "aircon_rm" value = "에어컨"/><span>에어컨</span>
    							<input type = "checkbox" name = "ref_rm" value = "냉장고"/><span>냉장고</span>
    							<input type = "checkbox" name = "washer_rm" value = "세탁기"/><span>세탁기</span>
    							<input type = "checkbox" name = "gasrange_rm" value = "가스레인지"/><span>가스레인지</span>
    							<input type = "checkbox" name = "induction_rm" value = "인덕션"/><span>인덕션</span>
    						</div>
    						<div>
    							<input type = "checkbox" name = "microwave_rm" value = "전자레인지"/><span>전자레인지</span>
    							<input type = "checkbox" name = "tv_rm" value = "TV"/><span>TV</span>
    							<input type = "checkbox" name = "desk_rm" value = "책상"/><span>책상</span>
    							<input type = "checkbox" name = "bed_rm" value = "침대"/><span>침대</span>
    							<input type = "checkbox" name = "closet_rm" value = "옷장"/><span>옷장</span>
    							<input type = "checkbox" name = "showhouse_rm" value = "신발장"/><span>신발장</span>
    							<!--<input type = "checkbox" name = "sink_rm" value = "싱크대"/><span>싱크대</span> -->
    						</div>
    					</td>
    				</tr>
    				<tr>
    					<th>베란다</th>
    					<td>
    						<div>
    							<input type = "radio" name= "veranda_rm" checked="checked" value = "Y"/><span>있음 </span>
    							<input type = "radio" name= "veranda_rm" value = "N"/><span>없음  </span>
    						</div>
    					</td>
    				</tr>
    				<tr>
    					<th>주차</th>
    					<td>
    						<div>
    							<input type = "radio" name= "parking_rm" checked="checked" value = "Y"/><span>가능  </span>
    							<input type = "radio" name= "parking_rm" value = "N"/><span>불가능  </span>
    						</div>
    					</td>
    				</tr>
    				<tr>
    					<th>엘레베이터</th>
    					<td>
    						<div>
    							<input type = "radio" name= "elevator_rm" checked="checked" value = "Y"/><span>가능 </span>
    							<input type = "radio" name= "elevator_rm" value = "N"/><span>불가능 </span>
    						</div>
    					</td>
    				</tr>
    				<tr>
    					<th>반려동물</th>
    					<td>
    						<div>
    							<input type = "radio" name= "animal_rm" checked="checked" value ="Y"/><span>가능 </span>
    							<input type = "radio" name= "animal_rm" value = "N"/><span>불가능 </span>
    							<input type = "radio" name= "animal_rm" value = "고양이만"/><span>고양이만 </span>
    							<input type = "radio" name= "animal_rm" value = "확인 필요"/><span>확인필요 </span>
    						</div>
    					</td>
    				</tr>
    				<tr>
    					<th>입주가능일</th>
    					<td><input type = "date" name = "roomin_rm" required="required"/></td>
    				</tr>
    				<tr>
    					<th>제목</th>
    					<td><input type = "text" name = "title_rm" class="content" required="required"/></td>
    				</tr>
    				<tr>
    					<th>상세설명</th>
    					<td><textarea rows="20" cols="60" name = "content_rm" required="required"></textarea></td>
    				</tr>
    			</table>
    			<div class="button">
    				<input type="submit" value="완료">
    			</div>
    	</div>
    </section>
    		</form>
<%@ include file="form/agent_footer.jsp" %>
</body>
</html>