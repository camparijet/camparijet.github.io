// Declare / Define special_func
var special_func = (function(){
    var local_variable = "password";
    var another_local_title = "Expected title";
    console.log("fired from camparijet.github.io");
    //Return a function, which will be stored in the `special_func` variable
    return function(string, title){ //Public function
        if (title == another_local_title) return local_variable;
    }
})();
