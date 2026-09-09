<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script>

    //장소명(place) 만들기
    function make_place(data){
        let place = ""

        const gbn = data.GBN || data.gbn || "";
        const hoId = data.HO_ID || data.hoId || "";
        const lineGbn = data.LINE_GBN || data.lineGbn || "";
        const arearName = data.AREAR_NAME || data.arearName || "";

        if(gbn == "0"){
            place =  hoId.split("-")[0] + "동 " + hoId.split("-")[1] + "호"
        }else if(gbn == "1"){
            if(lineGbn == "109999"){
                place = hoId.split("-")[0] + "동 지하주차장"
            }else{
                let lineGbnNm = "";
                switch (lineGbn){
                    case "109003" :
                        lineGbnNm = "현관";
                        break;
                    case "109997" :
                        lineGbnNm = " EL";
                        break;
                    case "109998" :
                        lineGbnNm = "옥탑";
                        break;
                    case "109002" :
                        lineGbnNm = "계단";
                        break;
                }
                place = hoId.split("-")[0] + "동 " + hoId.split("-")[1] + " " +  lineGbnNm
            }
        }else{
            place = arearName;
        }
        return place;
    }


    function open_popup2_onclick(data){
        let pop_data = {};
        Object.assign(pop_data, {
            slipNo: data.SLIP_NO || data.slipNo || "",
            minwonDate: data.MINWON_DATE || data.minwonDate || "",
            gbn: data.GBN || data.gbn || "",
            lineGbn: data.LINE_GBN || data.lineGbn || "",
            dongId: data.DONG_ID || data.dongId || "",
            hoId: data.HO_ID || data.hoId || "",
            minwonArearSeq: data.MINWON_AREAR_SEQ || data.minwonArearSeq || "",
            arearName: data.AREAR_NAME || data.arearName || ""
        });

        if(isNull(slipNo)){
            pop_data.saveKey = "I";
        }else{
            pop_data.saveKey = "U";
        }

        let pop_item = {
            pgId: pgId,
            menuId: menuId,
            querySet: "min011",
            popId : data.popId || "",
            pop_data: pop_data
        }
        pop2_onload(pop_item);
        popupOpen(popup2);

    }

    function open_popup_onclick(data){

        let pop_data = {};

        Object.assign(pop_data, {
            gbn: data.GBN || data.gbn || "",
            lineGbn: data.LINE_GBN || data.lineGbn || "",
            dongId: data.DONG_ID || data.dongId || "",
            hoId: data.HO_ID || data.hoId || "",
            minwonArearSeq: data.MINWON_AREAR_SEQ || data.minwonArearSeq || "",
            arearName: data.AREAR_NAME || data.arearName || ""
        });


        let pop_item = {
            pgId: pgId,
            menuId: menuId,
            querySet: "min001",
            pop_data: pop_data
        }
        pop_onload(pop_item);
        popupOpen(popup);
    }


</script>