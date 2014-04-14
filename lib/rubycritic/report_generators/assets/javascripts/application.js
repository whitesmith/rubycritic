prettyPrint();

highlightLine();

$("#js-toggle-smells").on("click", toggleSmells);

function toggleSmells() {
    $(".js-smells").toggle();
}

function highlightLine() {
    $(window.location.hash).addClass("highlight");
}
