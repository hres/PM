tinymce.init({
    forced_root_block: '',
    mode: "specific_textareas",
    editor_selector: "textarea",
    width: '100%',
    height: 0,
    min_height: 50,
    plugins: [
    ],
    toolbar1: "bold italic | bullist numlist | indent",
    menubar: false,
    resize: "both",
    toolbar_items_size: 'small',
    style_formats: [
    ],
    templates: [
    ],
    setup: function (theEditor) {
        theEditor.on('focus', function () {
            $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").show();
        });
        theEditor.on('blur', function () {
            $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
        });
        theEditor.on("init", function () {
            $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
        }),
        theEditor.on('keyup', function (ed, e) {
            //not applicable
        }),
        theEditor.on('keydown', function (ed, e) {
            var tinymax, tinylen, htmlcount;
            tinymax = 1500;
            tinylen = theEditor.getContent().replace(/(<([^>]+)>)/ig, "").length;
            if (tinylen > tinymax) {
                if (ed.keyCode == 8 || ed.keyCode == 46) {
                    //backspace or delete
                } else {
                    alert("Maximum " + tinymax + " characters");
                    ed.preventDefault();
                    ed.stopPropagation();
                }
            }     
        });
    }
});

function setup() {
    tinymce.init({
        forced_root_block: '',
        selector: "textarea",
        width: '100%',
        height: 0,
        min_height: 50,
        plugins: [
        ],
        toolbar1: "bold italic | bullist numlist | indent",
        menubar: false,
        toolbar_items_size: 'small',
        style_formats: [
        ],
        templates: [
        ],
        setup: function (theEditor) {
            theEditor.on('focus', function () {
                $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").show();
            });
            theEditor.on('blur', function () {
                $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
            });
            theEditor.on("init", function () {
                $(this.contentAreaContainer.parentElement).find("div.mce-toolbar-grp").hide();
            }),
            theEditor.on('keydown', function (ed, e) {
                var tinymax, tinylen, htmlcount;
                tinymax = 1500;
                tinylen = theEditor.getContent().replace(/(<([^>]+)>)/ig, "").length;
                if (tinylen > tinymax) {
                    if (ed.keyCode == 8 || ed.keyCode == 46) {
                        //backspace or delete
                    } else {
                        alert("Maximum " + tinymax + " characters");
                        ed.preventDefault();
                        ed.stopPropagation();
                    }
                }
            });
        }
    });
}

$(function () {
    $("#Button3").click(function () {
        $("div.mce-toolbar").hide();
    });
    $("#Button4").click(function () {
        $("div.mce-toolbar").show();
    });
})

//var lang = document.getElementsByTagName("html")[0].getAttribute("lang");
//console.log("selected lang :" + lang);
var now = new Date();
var day = (now.getDate() < 10 ? '0' : '') + now.getDate();
var month = ((now.getMonth() + 1) < 10 ? '0' : '') + (now.getMonth() + 1);
var year = now.getFullYear();
var todayDate = year + "-" + month + "-" + day;
//$('input[type="date"]').attr("max", todayDate);
//window.addEventListener("load", function () {
//    var fix = function (el) {
//        el.setAttribute("name", el.getAttribute("id"));
//    };
//    var els = document.getElementsByTagName("input");
//    for (var i = 0; i < els.length; i++) {
//        var type =  els[i].getAttribute("type"); 
//        if( type = 'date')
//        {
//            fix(els[i]);
//        }
//    }
//    $('input[type="date"]').attr("max", todayDate);
  
//    //els = document.getElementsByTagName("select");
//    //for (var i = 0; i < els.length; i++) {
//    //    fix(els[i]);
//    //}
//    //els = document.getElementsByTagName("textarea");
//    //for (var i = 0; i < els.length; i++) {
//    //    fix(els[i]);
//    //}
//});


