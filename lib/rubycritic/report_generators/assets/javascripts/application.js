prettyPrint();

$("#js-toggle-smells").on("click", toggleSmells);

function toggleSmells() {
    $(".js-smells").toggle();
}
