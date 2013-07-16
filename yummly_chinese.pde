import blprnt.nytimes.*;

PrintWriter output;

PFont f;              // A variable to hold onto a font

String [] url = loadStrings("http://api.yummly.com/v1/api/recipes?_app_id=fce85840&_app_key=b7b5bafb6c9be1ead4c0d0f237603e68&q=greece&maxResult=4000");

int counter = 0;
String[] listOfIngredients;
ArrayList<String> allIngredients;
//String type = "indian";

String FinalList;

//String delimiters = ",";


void setup() {
  size(400, 100);
  f = loadFont( "Georgia-Bold-16.vlw" );

  //Create a new file in the sketch directory
  output = createWriter("data/ing" + "_" + "greece" + ".txt");


  allIngredients = new ArrayList();
  loadYummly("http://api.yummly.com/v1/api/recipes?_app_id=fce85840&_app_key=b7b5bafb6c9be1ead4c0d0f237603e68&q=greece&maxResult=4000");


  println(allIngredients);
  //String[] s = allIngredients.toArray(s);
  //saveStrings("data/ing2" + "_" + type + ".txt", s);

  output.println(allIngredients);  // Write to the file
};



void draw() {
  background(255);
  f = createFont("Serif", 12);
  textFont(f);
  fill(0);
  //text(FinalList, 20, 20);
};


void loadYummly(String url)
{
  String jsonString = join(loadStrings(url), '\n');
  try
  {
    org.json.JSONObject yumJSON = new org.json.JSONObject(jsonString);
    //    String objName = "Ingredients.data.yummly_" + split(url, ".")[0];
    String objName = "matches";
    org.json.JSONArray yumList = yumJSON.getJSONArray(objName);
    for (int i = 0; i < yumList.length(); i++)
    {
      org.json.JSONObject obj = yumList.getJSONObject(i);
      String recipeName = obj.getString("recipeName");
      //println(recipeName);
      String tmp = "ingredients";
      org.json.JSONArray ingredients = obj.getJSONArray(tmp);
      String ingredientsText = ingredients.toString();


      ingredientsText = ingredientsText.replace("\"", "");
      ingredientsText = ingredientsText.replace("[", "");
      ingredientsText = ingredientsText.replace("]", "");
      String[] listOfIngredients = split(ingredientsText, ',');
      listOfIngredients = sort(listOfIngredients);

      // add every ingredient from this match to the global arraylist of ingredients
      for (int j=0; j < listOfIngredients.length; j++) {
        allIngredients.add(listOfIngredients[j]);
      }
      //println(FinalList);
      //String[] FinalList2 = split(ingredientsText, ',');

      //println(FinalList2);

      //      println (listOfIngredients);
      //
      //      FinalList = join(listOfIngredients, ",");
    }
  }
  catch(org.json.JSONException e)
  {
    println("ERROR PARSING JSON" + e);
  }
}



void keyPressed() {
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}

