<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>
        .wkrtjdBut {
            width: 130px;
            /* float: right; */
            margin: auto;
        }
    </style>
    <script>
        $(function(){
            $("#btnEdit").on("click",btnEdit);
            $("#btnList").on("click",btnList);
            $("#btnConfirm").on("click",btnConfirm);
            $("#btnCancel").on("click",btnCancel);
            // $("#customFile").on("change",changeFile);
        });//$functionEnd

        //수정버튼
        function btnEdit(){
            console.log("수정ck");
            $("#p1").css("display", "none");
            $("#p2").css("display", "block");

            $("#volStart").removeAttr("readonly")
            $("#volEnd").removeAttr("readonly")
            $("#volTime").removeAttr("readonly")
            $("#sample5_address").removeAttr("readonly")
            $("#volCon").removeAttr("readonly")
            $("#customFile").removeAttr("disabled")
            $("#btnAddrSearch").removeAttr("disabled")
            // let customFile= $("#customFileName").text(); // 파일업로드
            
        }//수정버튼 end
        //확인버튼
        function btnConfirm(){
            //파일 0이면 null로
            let inputFile = $("#customFile");
            console.log("inputFile>",inputFile)
            let file = inputFile[0].files;

            console.log("file:" + file);
            console.log("file.length:" + file.length);
            let volNo=`${volunteerVO.volNo}`;
            let volFileStr=`${volunteerVO.volFileStr}`;
            let volStart= $("#volStart").val();
            let volEnd= $("#volEnd").val();
            let volTime= $("#volTime").val();
            let volPlace= $("#sample5_address").val();
            let volCon= $("#volCon").val();

            let formData = new FormData();  
            formData.append("volFileStr", volFileStr);
            formData.append("volNo", volNo);
            formData.append("volStart", volStart);
            formData.append("volEnd", volEnd);
            formData.append("volTime", volTime);
            formData.append("volPlace", volPlace);
            formData.append("volCon", volCon);
            for (let i = 0; i < file.length; i++) {
                formData.append("vonFile", file[i]);
            }
                $.ajax({
                    url:"/employment/volDetailAjax",
                    processData: false,
                    contentType: false,
                    data: formData,
                    type : "post",
                    dataType : "text",
                    beforeSend:function(xhr){
                        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                    },
                    success: function(result){
                      console.log("result",result);
                      Swal.fire({
                             position: "center",
                             icon: "success",
                             title: "수정완료 되었습니다.",
                             timer: 1800,
                             showConfirmButton: false // 확인 버튼을 숨깁니다.
                           }).then(() => {
                             // Swal.fire의 타이머가 끝난 후 호출됩니다.
                             location.href="/employment/volDetail?menuId=cybJobHun&volNo=${volunteerVO.volNo}";
                           });
                    }
                });//ajaxend

            console.log("btnConfirm");

        }//확인버튼 end\
        //취소버튼
        function btnCancel(){
            console.log("취소버튼 ck");
            $("#p1").css("display", "block");
            $("#p2").css("display", "none");

            $("#volStart").attr("readonly", true);
            $("#volEnd").attr("readonly", true);
            $("#volTime").attr("readonly", true);
            $("#sample5_address").attr("readonly", true);
            $("#volCon").attr("readonly", true);
            $("#customFile").attr("readonly", true);
            $("#customFile").attr("disabled", true);
            $("#btnAddrSearch").attr("disabled", true);

            let yujin =`${volunteerVO.volCon}`;
            console.log("yujin >> ", yujin);
            $("#volStart").val('${volunteerVO.volStart}');
            $("#volEnd").val('${volunteerVO.volEnd}');
            $("#volTime").val('${volunteerVO.volTime}');
            $("#volCon").val(yujin);
            $("#customFile").val('${volunteerVO.volFileName}')

        }
        //목록 버튼
        function btnList(){
            console.log("ck");
            location.href="/employment/volunteer?menuId=cybJobHun";
        }

    </script>
    <!-- ${volunteerVO} -->
    <h3 style="color:black;margin-bottom:30px;margin-top: 40px;">봉사활동 상세 조회</h3>
    <br>
    <form id="frm" action="/" method="post" enctype="multipart/form-data">
        <div class="form-group row" style="margin-left: 1px;">
            <div>
                <label style="font-weight: bolder;">봉사시작날짜</label>
                <br>
                <input class="form-control" type="date" id="volStart" name="volStart" value="${volunteerVO.volStart}" readonly>
            </div>
            <div style="margin: 20px;margin-top: 35px;font-weight: 900;">
                ~
            </div>
            <div>
                <label style="font-weight: bolder;">봉사종료날짜</label>
                <br>
                <input class="form-control" type="date" id="volEnd" name="volEnd" value="${volunteerVO.volEnd}" readonly>
            </div>
            <br>
            <div style="margin-left: 15px;margin-top: -1px;">
                <label style="font-weight:bolder;">봉사시간</label>
                <br>
                <input class="form-control" type="number" id="volTime" name="volTime" value="${volunteerVO.volTime}" readonly
                    style="display: inline-block; width: 70px;">
            </div>
        </div><!-- row end -->
        <div>
            <input type="text" class="form-control col-6" name="volPlace" id="sample5_address" placeholder="봉사활동장소"
                value="${volunteerVO.volPlace}" readonly style="display: inline;">
            <input type="button" id="btnAddrSearch" class="btn btn-outline-primary" onclick="sample5_execDaumPostcode()" value="주소 검색"
                 disabled style="margin-bottom:5px;"><br>
            <div id="map" style="width:300px;height:300px;margin-top:10px;display:block"></div>
        </div>
        <br>
        <div class="form-group">
            <label>봉사내역</label>
            <textarea class="form-control" id="volCon" name="volCon" rows="3" cols="50" placeholder="봉사내역"
                readonly>${volunteerVO.volCon}</textarea>
        </div>
        <div class="form-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="customFile" name="vonFile" disabled>
                <label class="custom-file-label" for="customFile" id="customFileName">${volunteerVO.volFileName}</label>
            </div>
        </div>
        <div id="p1" class="wkrtjdBut row">
            <div>
                <button type="button" id="btnEdit" class="btn btn-block btn-outline-warning ">수정</button>
            </div>
            <div>
            </div>
            <div>
                <button type="button" id="btnList" class="btn btn-block btn-outline-secondary">목록</button>
            </div>
        </div>
        <div id="p2" class="wkrtjdBut row" style="display: none;">
                <button type="button" id="btnConfirm" class="btn btn-block btn-outline-primary ">확인</button>
                <button type="button" id="btnCancel" class="btn btn-block btn-outline-secondary">취소</button>
        </div>
        <sec:csrfInput />
    </form>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d4c2ba0057e1164adb08128bb0b217a7&libraries=services"></script>
    <script>
        document.querySelector('#customFile').addEventListener('change', function (e) {
            var fileName = document.getElementById("customFile").files[0].name;
            var nextSibling = e.target.nextElementSibling;
            nextSibling.innerText = fileName;
        });
        //다음 지도 api
        // 지도를 표시할 div와 옵션을 설정합니다.
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new daum.maps.LatLng(37.566535, 126.97796919999996), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
            };

        // 지도를 생성합니다.
        var map = new daum.maps.Map(mapContainer, mapOption);

        // 주소-좌표 변환 객체를 생성합니다.
        var geocoder = new daum.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch("${volunteerVO.volPlace}", function (result, status) {

            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;color:black;">봉사활동장소</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            }
        });
        var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });

    //지도 검색
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }

    </script>