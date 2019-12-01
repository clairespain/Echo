class MessageSystem {
  ArrayList<Messages> particles;
  PVector origin;

  MessageSystem(PVector v) {
    particles = new ArrayList<Messages>();
    origin = v.copy();
    for(int i = 0; i < 1; i++) {
      particles.add(new Messages(origin));    // Add "num" amount of particles to the arraylist
    }
    
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Messages p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  boolean dead() {
    return particles.isEmpty();
  }
}
