function generatexml() {

    var e = document.getElementById("ddlTemplate");
    var templatetype = e.options[e.selectedIndex].text;

    //$.createElement = function (name) {
    //    return $('<' + name + ' />');
    //};

    //$.fn.appendNewElement = function (name) {
    //    this.each(function (i) {
    //        $(this).append('<' + name + ' />');
    //    });
    //    return this;
    //}

    var $root = $('<XMLDocument />');
    $root.append
    (
        $('<ProductMonographTemplate />').append
        (
            $('<TemplateVersion />').append
            (
                //$('<value />').text(templatetype)
                templatetype
            )
        )
    );

    _window = window.open("");
    _window.document.write($root.html());
    _window.document.close();
    _window.document.execCommand('SaveAs', true, "productionmonograph.xml")
    _window.close();

    window.location = "Coverpage.aspx";
}

function submit() {
    if (confirm("Would you like to save a draft?")) {
        generatexml();        
    }
}


    
