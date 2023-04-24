// UNA CUERDA HECHA DE PARTICULAS Y MUELLES

// ZONA DE VARIABLES Y OBJETOS

// LOS OBJETOS
int num_particsY = 7;
int num_particsX = 7;
int distanciaX = 100;
int distanciaY = 50;
particula[][] particulaArray = new particula[num_particsX][num_particsY];
int num_muellesX = (num_particsY-1)*num_particsX;
int num_muellesY = (num_particsX-1)*num_particsY;
int num_muelles =  num_muellesX+ num_muellesY;
muelle[] muelleArray = new muelle[num_muelles];
// DELTA TIEMPO
float inc_t;

boolean euler_activated;
boolean wind_activated;
boolean wind_right;
boolean wind_left;





// ZONA DE SETUP
void setup() {
  // Ventana
  size(1200, 1000, P3D);
  // Inicializar las particulas
  for (int i=0; i<num_particsX; i++) {
    for (int j=0; j<num_particsY; j++) {
      if ((i == 0 && j== 0) || (i == num_particsX -1 && j == 0) || j == 0 )
      {
        particulaArray[i][j] = new particula(new PVector((200.0)+ 100* i, (200.0)+ 50 * j), new PVector (0.0, 0.0), 10.0, 30.0, 0.5, color(255, 0, 0), true);
      } else
        particulaArray[i][j] = new particula(new PVector((200.0)+ 100 * i, (200.0)+ 50 * j), new PVector (0.0, 0.0), 10.0, 30.0, 0.5, color(255, 0, 0), false);
    }
  }
  //Inicializar los muelles
  for (int i=0; i<num_muelles; i++) {
    muelleArray[i]= new muelle(new PVector(75.0, 50.0), 0.5, color(255, 255, 0));
  }

  euler_activated = false;
  wind_activated = false;
  wind_right = false;
  wind_left = true;
  //Tiempo
  inc_t = 0.5;
}

// ZONA DE DRAW
void draw() {
  PVector fm = new PVector(0.0, 0.0);
  // Fondo negro
  background(0);
  // Reset fuerzas
  for (int i=0; i<num_particsX; i++) {
    for (int j=0; j<num_particsY; j++) {
      particulaArray[i][j].fuerza.x = 0.0;
      particulaArray[i][j].fuerza.y = 0.0;
    }
  }
  // Calcular fuerzas muelles
  //muelles linea


  for (int j = 1, k = 0; j < num_particsX; j++)
  {
    for (int i = 0; i < num_particsX -1; i++)
    {
      fm = muelleArray[k].fuerza_que_hago(particulaArray[i][j], particulaArray[i+1][j]);
      particulaArray[i][j].fuerza.x += fm.x;
      particulaArray[i+1][j].fuerza.x -= fm.x;
      k++;
    }
  }
  //muelles columna
  for (int i = 0, k = num_muellesX; i < num_particsX; i++)
  {
    for (int j = 0; j < num_particsY - 1; j++)
    {
      fm = muelleArray[k].fuerza_que_hago(particulaArray[i][j], particulaArray[i][j+1]);
      particulaArray[i][j].fuerza.y += fm.y;
      particulaArray[i][j+1].fuerza.y -= fm.y;
      k++;
    }
  }


  // Render de la escena

  // Calcular nuevas posiciones primero
  // para pintar después
  keyPressed();
  if (euler_activated)
  {
    for (int i=0; i<num_particsX; i++) {
      for (int j = 0; j < num_particsY; j++)
      {
        // Mover
        particulaArray[i][j].mueveteEuler();

        // Dibujar
        particulaArray[i][j].pintate();
        textSize(26);
        fill(0, 0, 255);
        text("Euler's Activated", 1000, 300);
      }
    }
  } else {
    for (int i=0; i<num_particsX; i++) {
      for (int j = 0; j < num_particsY; j++)
      {
        // Mover
        particulaArray[i][j].mueveteVerlet();

        // Dibujar
        particulaArray[i][j].pintate();
        textSize(26);
        fill(0, 0, 255);
        text("Verlet's Activated", 1000, 300);
      }
    }
  }
  if (wind_activated && wind_right)
  {
    text("Wind Activated", 1000, 400);
    text("Wind direction: Right", 1000, 500);
  }
else if (wind_activated && wind_left)
{
  text("Wind Activated", 1000, 400);
  text("Wind direction: Left", 1000, 500);
} else
{
  text("Wind Deactivated", 1000, 400);
}

//muelles linea

for (int j = 0, k = 0; k< num_muellesY; j++)
{
  for (int i = 0; i < num_particsX-1; i++)
  {

    muelleArray[k].pintate(particulaArray[i][j], particulaArray[i+1][j]);
    k++;
  }
}
for (int i = 0, k = num_muellesX; k < num_muelles; i++)
{
  for (int j = 0; j < num_particsY-1; j++)
  {
    muelleArray[k].pintate(particulaArray[i][j], particulaArray[i][j+1]);
    k++;
  }
}
}
