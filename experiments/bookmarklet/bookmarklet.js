javascript:(function() {
    var jsCode = document.createElement('script');
    var params = ["test", document.title]; //Define parameter(s)
    var thisObject = {}; // `this` inside the callback function will point to
                         // the object as defined here.
    jsCode.onload = function() {
        // If the function exists, call it:
        if (typeof special_func == "function") {
            special_func.apply(thisObject, params);
        }
    };
    jsCode.setAttribute('src', 'http://camparijet.github.io/experiments/bookmarklet/io.github.camparijet.js');
    document.body.appendChild(jsCode);
})();
