class muelle{
  // ATRIBUTOS
  PVector longitud_natural;
  float KM;
  color color_muelle;
  // CONSTRUCTOR
  muelle(PVector ln, float cm, color c){
    longitud_natural = new PVector(ln.x, ln.y);
    KM = cm;
    color_muelle = c;
  }
  // METODOS
  PVector fuerza_que_hago(particula p0, particula p1){
    PVector f = new PVector (0.0,0.0);
    // Ley de Hook
    // F muelle = -KF *(longitud natural - longitud real)
    // longitud real = longitud entre ambas partículas
    f.x = -KM * (longitud_natural.x - (p1.pos.x - p0.pos.x));
    f.y = -KM * (longitud_natural.y - (p1.pos.y - p0.pos.y));
    
    return f;
  }
  
  void pintate(particula p0, particula p1){
    strokeWeight(3);
    stroke(255,255,0);
    line(p0.pos.x, p0.pos.y, p1.pos.x, p1.pos.y);
  }
}
