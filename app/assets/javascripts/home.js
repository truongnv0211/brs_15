$(document).ready(function(){
  $(function(){
    $("#book_publish_date").datepicker();
  });

  $( "#suggest_books_default" ).click(function() {
    document.getElementById("suggest_books_default").style.display = "none";
    document.getElementById("suggest_books_expand").style.display = "";
    document.getElementById("suggest_books").style.display = "";
  });

  $( "#suggest_books_expand" ).click(function() {
    document.getElementById("suggest_books_default").style.display = "";
    document.getElementById("suggest_books_expand").style.display = "none";
    document.getElementById("suggest_books").style.display = "none";
  });
});
