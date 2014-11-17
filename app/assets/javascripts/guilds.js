$(document).ready(function(){
  $(".color > input").click(function(){
    $(".guild_icon").css("background-color",$(this).css("background-color"));
  });

  $(".icon > input").click(function(){
    console.log($(this).parent().find("svg").val());
    $(".guild_icon #svg").html($(this).parent().find("#svg").html());
  });

  $("#guild_name").keyup(function(){
    $(".guild_title").text($(this).val());
  });
});