//Crear una imagen que almacenará la imagen del maá 
PImage mapImage;

//Crea una tabla que guarda los datos del archivo .tsv
Table dataTable;
PFont miTitulo;
PFont etiquetas;
//numero de filas en el archivo
int rowCount;

// ubicacion de los circulos
float x = 0;
float y = 0;

//diametro de la elipse
float diametro = 35;

//segundo
//guarda el valor de la columna 3
float columna3 = 0;
//valor maximo y minimo de la columna 3 del archivo
float dataMinColumna3 = 0;
float dataMaxColumna3 = 0;

//tercero

//guarda el valor de la columna 4
float columna4 = 0;
//valor maximo y minimo de la columna 4 del archivo
float dataMinColumna4 = 0;
float dataMaxColumna4 = 0;
//se utiliza para dar el color segun el valor de la columna 4
float aproxColor = 0;
//da el color a cada circulo
color colorIntermedio;

//cuarto
//guarda el valor de la columna 5
float columna5 = 0;
//valor maximo y minimo de la columna 5 del archivo
float dataMinColumna5 = 0;
float dataMaxColumna5 = 0;
//el alpha-color de cada circulo
float transparencia = 0; 


//quinto
//guarda el nombre de la fila
String nombreEstado;

void setup() 
{
  //Tamaño de lienzo x,y
  size(960, 600);  
  //traer imagen de la carpeta data
  mapImage = loadImage("MapaCalidadAire.png");
  miTitulo = loadFont("Catamaran-Bold-32.vlw");
  etiquetas = loadFont("Archivo-Regular-16.vlw");
  
   //traer datos de la carpeta data
  dataTable = loadTable("CalidadAire.tsv");
 
  // da el numero de filas del archivo
  rowCount = dataTable.getRowCount();
  //"Hay x cantidad de filas"
  println("Hay un total de " + rowCount + " filas");
  
  //recorre el archivo 
  for (int i = 0; i < rowCount; i++) 
   {
    
    //segundo
    columna3 = dataTable.getFloat(i, 3); // column 3
    //determina el valor max y minimo de la columna 3   
    if (columna3 > dataMaxColumna3) 
    {
      dataMaxColumna3 = columna3;
    }
    if (columna3 < dataMinColumna3) 
    {
      dataMinColumna3 = columna3;
    }

    
    //tercero
 
    columna4 = dataTable.getFloat(i, 4); // column 4
    //determina el valor max y minimo de la columna 4
    if (columna4 > dataMaxColumna4) 
    {
      dataMaxColumna4 = columna4;
    }
    if (columna4 < dataMinColumna4) 
    {
      dataMinColumna4 = columna4;
    }
    
    //cuarto
    columna5 = dataTable.getFloat(i, 5); // column 5
    //determina el valor max y minimo de la columna 5
    if (columna5 > dataMaxColumna5) 
    {
      dataMaxColumna5 = columna5;
    }
    if (columna5 < dataMinColumna5) 
    {
      dataMinColumna5 = columna5;
    }
    
   }
  
}

void draw() 
{  
  //Cambiar color de fondo 
  background(255);
  //insertar y ubicar imagen 
  image(mapImage, 0, 0);
  fill(0);
  textFont(miTitulo, 32);
  textAlign(BOTTOM);
  text("Informe Anual de Calidad del Aire en Bogotá (2018)",130, 124);

  //suaviza el borde del circulo  
  smooth();
  
  // Loop through the rows of the locations file and draw the points  
  for (int i = 0; i < rowCount; i++) 
  {
    //Posición de los circulos 
    x = dataTable.getFloat(i, 1);  // column 1
    y = dataTable.getFloat(i, 2);  // column 2
    
    //segundo
    
    columna3 = dataTable.getFloat(i, 3);  // column 3
    //map(variableAModificar, minOriginal, maxOriginal, minAsignado, maxAsignado
    diametro = map(columna3, dataMinColumna3, dataMaxColumna3, 2, 40);
  
    //tercero
    columna4 = dataTable.getFloat(i, 4);  // column 4
    //Hayar nuevo valor entre 0 y 1 para representar color
    aproxColor = map(columna4, dataMinColumna4, dataMaxColumna4, 0, 1);
    //lerpColor(Color1, Color3, valorIntermedio)
    colorIntermedio = lerpColor(#CE4D4D,#4ECC51,aproxColor);
    fill(colorIntermedio);
    
    //cuarto
    columna5 = dataTable.getFloat(i, 5);  // column 5
    transparencia = map(columna5, dataMinColumna5, dataMaxColumna5, 0, 255);
    //fill(color, alpha)
    fill(colorIntermedio,transparencia);
           
    noStroke();
    
    //posicion x, posicion y, alto y ancho
    ellipse(x, y, diametro, diametro);
    
    //quinto
    //Seleccionar un String de determinada fila y columna
    nombreEstado = dataTable.getString(i,0);
    //Calcula distancia entre dos puntos, en este caso determina
    //si el mouse está sobre el círculo. 
    if (dist(x, y, mouseX, mouseY) < diametro) 
    {
      fill(0);
      textFont(etiquetas, 14);
      textAlign(CENTER);
      // Show the data value and the state abbreviation in parentheses
      //text("palabra", x, y)
      text(nombreEstado + ":" + columna3, x, y);
    }
 
   
  }
}
