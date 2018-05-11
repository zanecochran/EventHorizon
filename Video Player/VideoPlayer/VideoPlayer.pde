import processing.video.*;

Movie movie;

void setup() {
  size(100, 100);
  background(0);
  movie = new Movie(this, "test.mov");
  movie.loop();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  //if (movie.available() == true) {
  //  movie.read(); 
  //}
  image(movie, 0, 0, width, height);
}