class particula {
  // ATRIBUTOS
  PVector pos, vel, fuerza;
  float masa, tamanyo, KF;
  color color_p;
  boolean estatica;

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
  }
  // MÉTODOS
  void muevete() {  // El SOLVER!!! empleamos un EULER :)
    // 1- Fuerza y la Aceleracion
    PVector acel;
    acel = new PVector(0.0, 0.0, 0.0);
    
    // Las fuerzas de gravedad y fricción
    
    fuerza.x += -KF * vel.x;
    fuerza.y += -KF * vel.y;
    
    fuerza.x += 0.0;
    fuerza.y += 9.8;
    
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

  void pintate() {  // ME DIBUJO
    strokeWeight(2);
    fill(255,0,0);
    stroke(color_p);
    ellipse(pos.x, pos.y, tamanyo, tamanyo);
  }
}
