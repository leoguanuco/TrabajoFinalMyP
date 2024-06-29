class Egg {
  private PVector posicion;
  private PVector velocidad;
  private PVector gravedad = new PVector(0, 0.1);
  private boolean isFalling;  //Está cayendo
  private boolean onPlatform; //Está sobre la plataforma

  public Egg(PVector posicion, PVector velocidad) {
    this.posicion = posicion;
    this.velocidad = velocidad;
    this.isFalling = true;
    this.onPlatform = false;
  }

  public void mover() {
    velocidad.add(gravedad);
    posicion.add(velocidad);
  }

  public void display() {
    ellipse(posicion.x, posicion.y, 20, 20);
  }

  public PVector getPosicion() {
    return posicion;
  }
  public boolean isFalling() {
    return isFalling;
  }
  public boolean isOnPlatform() {
    return onPlatform;
  }

  public void handleCollision(ArrayList<Platform> platforms, float camX) {
    for (Platform p : platforms) {
      if (isInSweepRange(this.posicion, p, camX)) {
        PVector nextPosition = PVector.add(this.posicion, this.velocidad);
        if (willCollide(this.posicion, nextPosition, p, camX)) {
          this.posicion.y = p.y - 10; // Ajusta la posición del huevo encima de la plataforma
          this.velocidad.y = 0;
          this.isFalling = false; // Detiene la caída del huevo
          this.onPlatform = true; // Marca que está sobre una plataforma
          break;
        }
      }
    }
  }

  private boolean isInSweepRange(PVector position, Platform platform, float camX) {
    float sweepRange = 900; // Definir un rango de barrido adecuado
    return Math.abs((position.x+camX) - platform.x) <= sweepRange;
  }

  private boolean willCollide(PVector currentPos, PVector nextPos, Platform platform, float camX) {
    if (currentPos.y < platform.y && nextPos.y + 40 >= platform.y) {
      if ((currentPos.x+camX) > platform.x- 30 && (currentPos.x+camX) < platform.x + platform.w + 40) {
        return true;
      }
    }
    return false;
  }
}
