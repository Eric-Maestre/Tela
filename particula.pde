class particula {
  // ATRIBUTOS
  PVector pos, vel, fuerza;
  float masa, tamanyo, KF;
  color color_p;
  boolean estatica;
  PVector posPrev;

  // CONSTRUCTOR
  particula(PVector p, PVector v, float m,
    float t, float f,color c, boolean e) {
    pos = p;
    vel = v;
    fuerza = new PVector(0.0,0.0,0.0);
    masa = m;
    tamanyo = t;
    KF = f;
    color_p = c;
    estatica = e;
    posPrev = pos.copy();
  }
  // MÉTODOS
  void mueveteEuler() {  // El SOLVER!!! empleamos un EULER :)
    // 1- Fuerza y la Aceleracion
    PVector acel;
    acel = new PVector(0.0, 0.0);
    
    // Las fuerzas de gravedad y fricción
    
    if (!estatica)
    {
    fuerza.x += -KF * vel.x;
    fuerza.y += -KF * vel.y;
    
    if(wind_activated)
    {
      if(wind_right)
      {
        fuerza.x += 5.0;
    fuerza.y += 9.8;
      }
      if(wind_left)
      {
    fuerza.x -= 5.0;
    fuerza.y += 9.8;
      }
    }
    else
    {
    fuerza.x += 0.0;
    fuerza.y += 9.8;
    }
    // De fuerza a aceleración
    // NEWTON Suma Fuerzas = Masa x Aceleracion
    acel.x = fuerza.x/masa;
    acel.y = fuerza.y/masa;

    // 2- Velocidad
    vel.x = vel.x + acel.x * inc_t;
    vel.y = vel.y + acel.y * inc_t;

    // 3- Posicion
    pos.x = pos.x + vel.x * inc_t;
    pos.y = pos.y + vel.y * inc_t;
    }
    
    
  }
  
  void mueveteVerlet()
  {
   PVector acel;
    acel = new PVector(0.0, 0.0);
    

    if (!estatica)
    {

    // Compute acceleration
    fuerza.x += -KF * vel.x;
    fuerza.y += -KF * vel.y;
    fuerza.y += 9.8; // gravity
     if(wind_activated)
    {
      if(wind_right)
      {
        fuerza.x +=5.0;
      }
      if(wind_left)
      {
    fuerza.x -= 5.0;
      }
    }

    // 2- Calcular acceleracio
    acel.x=fuerza.x/masa;
    acel.y=fuerza.y/masa;
    // Compute new position using Verlet method
    PVector posNext = PVector.mult(pos, 2).sub(posPrev).add(PVector.mult(acel, inc_t * inc_t));
    posPrev = pos.copy();
    pos = posNext;
    

    // Compute velocity using central difference method
    vel = PVector.sub(pos, posPrev).div(2 * inc_t); 
    }
  }

  void pintate() {  // ME DIBUJO
    strokeWeight(2);
    fill(255,0,0);
    stroke(color_p);
    ellipse(pos.x, pos.y, tamanyo, tamanyo);
  }
}
