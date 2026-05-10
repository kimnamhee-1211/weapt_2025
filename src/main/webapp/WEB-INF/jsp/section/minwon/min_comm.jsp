
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


    function open_popup1_onclick(data){
        let pop_data = {};

        const slipNo = data.SLIP_NO || data.slipNo || "";
        const minwonDate = data.MINWON_DATE || data.minwonDate || "";
        const gbn = data.GBN || data.gbn || "";
        const lineGbn = data.LINE_GBN || data.lineGbn || "";
        const dongId = data.DONG_ID || data.dongId || "";
        const hoId = data.HO_ID || data.hoId || "";
        const minwonArearSeq = data.MINWON_AREAR_SEQ || data.minwonArearSeq || "";
        const arearName = data.AREAR_NAME || data.arearName || "";

        pop_data.slipNo = slipNo;
        pop_data.minwonDate = minwonDate;
        pop_data.gbn = gbn;
        pop_data.lineGbn = lineGbn;
        pop_data.dongId = dongId;
        pop_data.hoId = hoId;
        pop_data.minwonArearSeq = minwonArearSeq;
        pop_data.arearName = arearName;

        if(isNull(slipNo)){
            pop_data.saveKey = "I";
        }else{
            pop_data.saveKey = "U";
        }

        let pop_item = {
            pgId: pgId,
            menuId: menuId,
            querySet: "min011",
            pop_data: pop_data
        }
        pop_onload1(pop_item);
        popupOpen(popupId1);

    }

    function open_popup_onclick(data){

        let pop_data = {};

        const gbn = data.GBN || data.gbn || "";
        const lineGbn = data.LINE_GBN || data.lineGbn || "";
        const dongId = data.DONG_ID || data.dongId || "";
        const hoId = data.HO_ID || data.hoId || "";
        const minwonArearSeq = data.MINWON_AREAR_SEQ || data.minwonArearSeq || "";
        const arearName = data.AREAR_NAME || data.arearName || "";

        pop_data.gbn = gbn;
        pop_data.lineGbn = lineGbn;
        pop_data.dongId = dongId;
        pop_data.hoId = hoId;
        pop_data.minwonArearSeq = minwonArearSeq;
        pop_data.arearName = arearName;

        let pop_item = {
            pgId: pgId,
            menuId: menuId,
            querySet: "min011",
            pop_data: pop_data
        }
        pop_onload(pop_item);
        popupOpen(popupId);
    }


</script>