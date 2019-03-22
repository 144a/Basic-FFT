// Fast Fourier Transform example for curve fitting 
// Written by 144a


// Fast Fourier Example of the Cooley-Tukey Algorithm with no
// pre-calculated twiddle factors and only one base case (n=1)
// Made as a proof of consept and to help improve further projects

// This program assumes:
// #1 - That the data is equidistant (delta x = #)
// #2 - That n will always be a power of 2

final static float E = 2.718281828;

public Complex[] FFT(Complex[] x) {
  // Degree of Fourier Model (assuming it is a power of two)
  int n = x.length;
  
  // Base case of one element
  if(n == 1) {
    return new Complex[] {x[0]};
  }
  
  // Must be a power of two, otherwise it will not work
  if(n % 2 != 0) {
    println("ERROR: N IS NOT A POWER OF TWO");
  }
  
  // Seperate even terms for FFT
  Complex[] even = new Complex[n/2];
  for(int k = 0; k < n/2; k++) {
    even[k] = x[2*k];
  }
  Complex[] p1 = FFT(even);
  
  // Seperate odd terms for FFT
  // Reusing the even array
  Complex[] odd = even;
  for(int k = 0; k < n/2; k++) {
    even[k] = x[2*k + 1];
  }
  Complex[] p2 = FFT(odd);
  
  // Combine FFT of both even and odd 
  Complex[] y = new Complex[n];
  for(int k = 0; k < n/2; k++) {
    float t = -2 * k * PI / n;
    Complex w = new Complex((float)(Math.cos(t)), (float)(Math.sin(t)));
    y[k] = p1[k].add(w.mult(p2[k]));
    y[k + n/2] = p1[k].sub(w.mult(p2[k]));
  }
  
  // Recursively returns each array
  return y;
}

// Generate the coefficients for the Descrite Fourier Series
public void genFourierSeriesCoefficients(Complex[] inp) {
  String output = "x(t) = ";
  float[] xt = new float[inp.length];
  int P = 1;
  output += (float)(Math.sqrt((inp[0].getReal() * inp[0].getReal()) + (inp[0].getImag() * inp[0].getImag()))) + " + "; 
  println(output);
  for(int n = 1; n < xt.length; n++) {
    float An = (float)(Math.sqrt((inp[n].getReal() * inp[n].getReal()) + (inp[n].getImag() * inp[n].getImag())));
    float phi = (float)(Math.atan2((double)(-1 * inp[n].getImag()), (double)(inp[n].getReal())));
    println(An + " * cos(2 * PI * " + n + " * t / " + P + " + "  + phi + ") + ");
    output += An + " * cos(2 * PI * " + n + " * t / " + P + " + "  + phi + ") + ";
  }
  output = output.substring(0, output.length() - 2);
  println(output);
  num1.println(output);
  
  
}


PrintWriter num1;

void setup() {
  // Set up text file for data logging
  num1 = createWriter("datalog.txt");
  
  int n = 16;
  Complex[] input = new Complex[n];
  for (int i = 0; i < n; i++) {
    input[i] = new Complex((float)(-2 * Math.random() + 1), 0);
  }
  
  Complex[] y = FFT(input);
  
  for(Complex a:y) {
    println(a.toString());
  }
  
  genFourierSeriesCoefficients(y);
  
  // Writes the remaining data to the file
  num1.flush(); 
  // Finishes the file
  num1.close(); 

  exit();
}


void loop() {
  
}
