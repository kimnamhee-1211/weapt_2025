<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/3.3.2/jsencrypt.min.js"></script>
    <div class="layer_bg" id="pop_changePass">
        <div class="popup" style="width:450px;">
            <span class="pop_title" style="border:none" >&#10004; &nbsp;비밀번호 변경</span>
            <span class="section_middle_btn" id="pop_changePass_btn"></span>
            <div>
                <span id="text_userId" style="font-weight:bold;"> &#9726&nbsp;사용자ID : <****> </span>&emsp;
                <span id="text_userName" style="font-weight:bold;"> &#9726&nbsp;사용자명 : <****> </span>
            </div>
            <form id="changePass_form" method="post" action="/changePass">
                <table style="line-height:40px;">
                    <tbody>
                        <tr>
                            <th style="width: 200px;">변경전 비밀번호</th>
                            <td style="width: 200px;"><input type="password" id="input_password"></td>
                        </tr>
                        <tr>
                            <th style="width: 200px;">변경후 비밀번호</th>
                            <td style="width: 200px;"><input type="password" id="input_nextPassword" name="PASSWORD" oninput="match_password()"></td>
                        </tr>
                        <tr>
                            <th style="width: 200px;">변경후 비밀번호 확인</th>
                            <td style="width: 200px;"><input type="password" id="input_nextPassword2" oninput="match_password()"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>

<script>
    const pop_changePass = document.querySelector("#pop_changePass");
    const pop_changePass_btn = document.querySelector("#pop_changePass_btn");
    const text_userId = document.querySelector("#text_userId");
    const text_userName = document.querySelector("#text_userName");
    const changePass_form = document.querySelector("#changePass_form");
    const input_password = document.querySelector("#input_password");
    const input_nextPassword = document.querySelector("#input_nextPassword");
    const input_nextPassword2 = document.querySelector("#input_nextPassword2");


    //팝업 닫기 이벤트
    function close_changePass_onclick(){
        popupClose(pop_changePass);
        clearInput(pop_changePass);
    }

    input_nextPassword.addEventListener("input", match_password);
    input_nextPassword2.addEventListener("input", match_password);

    //변경 후 비밀번호 == 변경 후 비밀번호 확인 검증
    function match_password(){
        if(input_nextPassword.value != input_nextPassword2.value){
            input_nextPassword2.style.borderColor = "red";
        }else{
            input_nextPassword2.style.borderColor = "#bcbcbc";
        }
    }

    //입력 검증
    function save_officeGrid1_onclick() {

        if (isNull(input_password.value)) {
            alert("기존 비밀번호를 입력해주십시오,");
            return;
        }
        if (isNull(input_nextPassword.value)) {
            alert("변경할 비밀번호를 입력해주십시오,");
            return;
        }
        if (input_nextPassword.value != input_nextPassword2.value) {
            alert("변경 후 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            return;
        }

        if (!confirm("비밀번호를 변경하겠습니까?")) return;

        checkPass();

    }

    //기존 비밀번호 검증
    async function checkPass(){

        let param = {
            PASSWORD : encryptWithJS(input_password.value)
        }
        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), 60_000);
        try {
            const jsonParam = JSON.stringify(param);

            const res = await fetch(
                ctx + "/checkPass",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "X-PG-ID": "pop_changePass",
                    },
                    body: jsonParam,
                    signal: controller.signal,
                    credentials: 'include'
                });

            if (!res.ok) {
                alert("요청이 실패하였습니다");
                return;
            }
            const data = await res.json();

            if (data.result < 1) {
                alert("기존 비밀번호가 일치하지 않습니다.");
                return;
            }
            changePass();

        } catch (err) {
            if (err.name === "AbortError") {
                console.error("요청 타임아웃");
                alert("조회 시간이 초과되었습니다");
            } else {
                console.error(err);
                alert("조회에 실패하였습니다");
            }
            throw err;

        } finally {
            clearTimeout(timer);
            //로딩종료
        }
    }

    //비밀번호 변경
    async function changePass() {

        let param = {
            PASSWORD: encryptWithJS(input_nextPassword.value)
        }
        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), 60_000);
        try {
            const jsonParam = await JSON.stringify(param);

            const res = await fetch(
                ctx + "/changePass",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "X-PG-ID": "pop_changePass",
                    },
                    body: jsonParam,
                    signal: controller.signal,
                    credentials: 'include'
                });

            if (!res.ok) {
                alert("요청이 실패하였습니다");
                return;
            }
            const data = await res.json();

            if (data.result < 1) {
                alert("비밀번호 변경에 실패하였습니다.");
                return;
            }else{
                if(confirm("비밀번호 변경을 완료하였습니다. 새로운 비밀번호로 다시 로그인해주십시오")){
                    location.href = ctx + "/restart"

                }
            }

        } catch (err) {
            if (err.name === "AbortError") {
                console.error("요청 타임아웃");
                alert("조회 시간이 초과되었습니다");
            } else {
                console.error(err);
                alert("조회에 실패하였습니다");
            }
            throw err;

        } finally {
            clearTimeout(timer);
            //로딩종료
        }

    }


    function encryptWithJS(input) {
        let encryptedText = "";
        let pbkey = "${pbkey}";
        let jsEncrypt = new JSEncrypt();
        jsEncrypt.setPublicKey('-----BEGIN PUBLIC KEY-----\n' + pbkey + '\n-----END PUBLIC KEY-----');

        if (!jsEncrypt) {
            alert("먼저 공개키를 가져와주세요.");
            return;
        }

        if (!input.trim()) {
            alert("암호화할 텍스트를 입력해주세요");
            return;
        }

        try {
            const encrypted = jsEncrypt.encrypt(input);
            if (encrypted) {
                encryptedText = encrypted;
            } else {
                alert("JavaScript 암호화 실패");
            }
        } catch (error) {
            alert("JavaScript 암호화 중 오류: " + error.message);
        }

        return encryptedText;
    }


    // //getPublicKey 가져오기
    // function get_pbkey(){
    //
    //     const controller = new AbortController();
    //     const timer = setTimeout(() => controller.abort(), 60_000);
    //
    //     try {
    //
    //         const res = fetch(
    //             ctx + "/getPbkey",
    //             {
    //                 method: "GET",
    //                 headers: {
    //                     "Accept": "application/json",
    //                 },
    //                 credentials: "include",
    //                 signal: controller.signal
    //             });
    //         if (!res.ok) {
    //             alert("요청이 실패하였습니다");
    //             return;
    //         }
    //
    //     } catch (err) {
    //         if (err.name === "AbortError") {
    //             console.error("요청 타임아웃");
    //             alert("시간이 초과되었습니다");
    //         } else {
    //             console.error(err);
    //             alert("실패하였습니다");
    //         }
    //         throw err;
    //
    //     } finally {
    //         clearTimeout(timer);
    //         //로딩종료
    //     }
    //
    // }





    function changePass_onload(){
        //기본 crud 버튼 생성(검색/추가/저장/삭제/인쇄)
        btnMaker({ tag: "#pop_changePass_btn", grid: "officeGrid1", save : true});
        pop_changePass_btn.insertAdjacentHTML("beforeend",
            "<button id='close_btn1' class='btn_left3' onclick='close_changePass_onclick()'>닫기</button>");

        text_userId.innerHTML = "사용자ID : " + loginUser.userId;
        text_userName.innerHTML = "사용자명 : " +loginUser.userName;

        //getPublicKey 가져오기
        //get_pbkey()

    }



</script>

