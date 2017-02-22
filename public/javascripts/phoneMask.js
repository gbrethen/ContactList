$(document).ready(function () {
    $("input[name='Phone']").keyup(function () {
        var curchr = this.value.length;
        var curval = $(this).val();
        if (curchr == 3) {
            $("input[name='Phone']").val("(" + curval + ")" + " ");
        } else if (curchr == 9) {
            $("input[name='Phone']").val(curval + "-");
        }
    });
});