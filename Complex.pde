public class Complex {
  
  float a;
  float b;
  
  public Complex(float ai, float bi) {
    a = ai;
    b = bi;
  }
  
  public Complex() {
    a = 0;
    b = 0;
  }
  
  public Complex add(Complex n) {
    return new Complex(this.getReal() + n.getReal(), this.getImag() + n.getImag());
  }
  
  public Complex sub(Complex n) {
    return new Complex(this.getReal() - n.getReal(), this.getImag() - n.getImag());
  }
  
  public Complex mult(Complex n) {
    return new Complex((this.getReal() * n.getReal()) - (this.getImag() * n.getImag()), (this.getImag() * n.getReal()) + (this.getReal() * n.getImag()));
  }
  
  public float getReal() {
    return a;
  }
  
  public float getImag() {
    return b;
  }

  public String toString() {
    return getReal() + " + " + getImag() + "i";
  }
  
}
