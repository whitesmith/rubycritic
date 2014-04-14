prettyPrint();

highlightLineFromFragment();

function highlightLineFromFragment() {
    highlightLine(window.location.hash)
}

$(".js-file-code").on("click", ".js-smell-location", highlightSmellyLine);

function highlightSmellyLine() {
    var lineId = "#" + this.href.split("#")[1];
    $(".js-file-code li").removeClass("highlight");
    highlightLine(lineId);
}

function highlightLine(lineReference) {
    $(lineReference).addClass("highlight");
}

$("#js-toggle-smells").on("click", toggleSmells);

function toggleSmells() {
    $(".js-smells").toggle();
}
