<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="layer_bg" id="pop_changePass">
        <div class="popup" style="width:600px;">
            <div class="pop_title" style="border:none" >&#10004; &nbsp;비밀번호 변경</div>
            <div class="pop_btn" id="pop_changePass_btn"></div>
            <div>
                <span> &#9726&nbsp;사용자ID : <****> </span>&emsp;
                <span> &#9726&nbsp;사용자명 : <****> </span>
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
                            <td style="width: 200px;"><input type="password" id="input_nextPassword" name="PASSWORD"></td>
                        </tr>
                        <tr>
                            <th style="width: 200px;">변경후 비밀번호 확인</th>
                            <td style="width: 200px;"><input type="password" id="input_nextPassword2" oninput="match_password"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>

<script>
    const pop_changePass = "pop_changePass";
    const pop_changePass_btn = document.querySelector("#pop_changePass_btn");
    const changePass_form = document.querySelector("#changePass_form");
    const input_password = document.querySelector("#input_password");
    const input_nextPassword = document.querySelector("#input_nextPassword");
    const input_nextPassword2 = document.querySelector("#input_nextPassword2");


    //팝업 닫기 이벤트
    function close_changePass_onclick(){
        popupClose(pop_changePass);
        clearInput(pop_changePass);
    }



    function match_password(){
        if(input_nextPassword.value != input_nextPassword2.value){
            input_nextPassword2.style.borderColor = "red";
        }else{
            input_nextPassword2.style.borderColor = "#bcbcbc";
        }
    }



    function save_officeGrid1_onclick(){

        if(input_nextPassword.value != input_nextPassword2.value){
            alert("변경 후 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            return;
        }

        if(!confirm("비밀번호를 변경하겠습니까?")) return;

        //검색데이터
        let selectParam = {
            PASSWORD :  encryptWithJS(input_password)
        }

        const controller = new AbortController();
        const timer = setTimeout(() => controller.abort(), 60_000);

        try {
            const query = new URLSearchParams(selectParam)

            const res = fetch(
                ctx + "/checkPass/" + "?" + query,
                {
                    method: "GET",
                    headers: {
                        "Accept": "application/json",
                    },
                    credentials: "include",
                    signal: controller.signal
                });
            if (!res.ok) {
                alert("요청이 실패하였습니다");
                return;
            }

            const data = res.json();

            if(data < 1){
                alert("기존 비밀번호가 일치하지 않습니다.");
                return;
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

        input_nextPassword.value = encryptWithJS(input_nextPassword);
        changePass_form.submit();

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

        //getPublicKey 가져오기
        //get_pbkey()

    }



</script>

