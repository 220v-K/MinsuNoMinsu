function openPopup(){
    var email = sessionStorage.getItem("email");
    console.log(email);
    if (email != null) {
        // change location to mypagechange.html
        window.location.href = "../jsp/mypagechange.jsp";
    } else {
        window.open("../html/popup.html", "팝업", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0");
    }
}
//팝업 창에서 링크타고 다른 페이지로 이동하면 그 페이지까지 팝업창 크기로 보인다...재원이에게 물어보기