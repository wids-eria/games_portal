$(document).ready(function(){
  $(".checkbox > input").click(function(){

    $(".checkbox > input").each(function(k){
    //  console.log(k.css("background-color");
    });
    $(".swords_guild").css("background-color",$(this).css("background-color"));

  });

});