// UNA CUERDA HECHA DE PARTICULAS Y MUELLES

// ZONA DE VARIABLES Y OBJETOS

// LOS OBJETOS
int numero_particulas = 25;
int anchura = 5; //numero particulas de lado a lado tela
int altura = 5; // numero particulas de arriba a abajo
int distanciaX = 100;
int distanciaY = 25; 
int numero_muelles = 4;
particula[] particulaArray = new particula[numero_particulas];
muelle[] muelleArray = new muelle[numero_muelles];
// DELTA TIEMPO
float inc_t;

// ZONA DE FUNCIONES





// ZONA DE SETUP
void setup() {
  // Ventana
  size(800, 600);
  // Llamo a los constructores de las particulas
  
  
  for(int i = 0; i < numero_particulas; i+=0)
  {
    for(int k = 0; k  < altura*distanciaY; k += distanciaY)
    {
  for(int j = 0; j < anchura*distanciaX; j+=distanciaX)
  {
    if(i !=0 || i != anchura - 1 || i != (anchura*altura) - anchura || i != anchura*altura - 1)
            particulaArray[i] = new particula(new PVector((width/2.0 - 200.0)+j, (height/2.0)+k), new PVector (0.0,0.0), 1.0,10.0, 0.3,color(255,0,0),false); 
    else
      particulaArray[i] = new particula(new PVector((width/2.0 - 200.0)+j, (height/2.0)+k), new PVector (0.0,0.0), 1.0,10.0, 0.3,color(255,0,0),true); 
      
      i++;
  }
  
  }
  particulaArray[0].estatica = false; //extremo izquierdo superior
  particulaArray[4].estatica = false; //extremo derecho superior 
  particulaArray[20].estatica = false; //extremo izquierdo inferior
  particulaArray[24].estatica = false; //extremo derecho inferior
  }
  //Inicializar los muelles
  muelleArray[0] = new muelle(new PVector(50.0,100.0),0.2,color(255,255,0));
  muelleArray[1] = new muelle(new PVector(50.0,100.0),0.2,color(255,255,0));
  muelleArray[2] = new muelle(new PVector(50.0,100.0),0.2,color(255,255,0));
  muelleArray[3] = new muelle(new PVector(50.0,100.0),0.2,color(255,255,0));
  //Tiempo
  inc_t = 0.04;
}

// ZONA DE DRAW
void draw() {
  PVector fm = new PVector(0.0,0.0);
  // Fondo negro
  background(0);
  // Reset fuerzas
  for(int i = 0; i < numero_particulas;i++){
    particulaArray[i].fuerza.x = 0.0;
    particulaArray[i].fuerza.y = 0.0;
  }
  // Calcular fuerzas muelles
   for(int i = 0; i < numero_muelles; i++)
  {
    fm = muelleArray[i].fuerza_que_hago(particulaArray[i],particulaArray[i + 1]);
    particulaArray[i].fuerza.x += fm.x;
    particulaArray[i].fuerza.y += fm.y;
    particulaArray[i + 1].fuerza.x -= fm.x;
    particulaArray[i + 1].fuerza.y -= fm.y;
  }
  // Render de la escena
  
  // Calcular nuevas posiciones primero
  // para pintar después
  for (int i=0; i<numero_particulas; i++) {
    // Mover
    if(particulaArray[i].estatica == false){
      particulaArray[i].muevete();
    }
    // Dibujar
    particulaArray[i].pintate();
  }
  //Los muelles
  for(int i = 0; i < numero_muelles; i++)
  {
    muelleArray[i].pintate(particulaArray[i], particulaArray[i+1]);
  }
}
