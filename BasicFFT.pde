// Fast Fourier Transform example for curve fitting 
// Written by 144a


// Fast Fourier Example of the Cooley-Tukey Algorithm with no
// pre-calculated twiddle factors and only one base case (n=1)
// Made as a proof of consept and to help improve further projects

// This program assumes:
// #1 - That the data is equidistant (delta x = #)
// #2 - That n will always be a power of 2

final static float E = 2.718281828;

public float[] FFT(float[] x) {
  // Degree of Fourier Model (assuming it is a power of two)
  int n = x.length;
  
  // Base case of one element
  if(n == 1) {
    return new float[] {x[0]};
  }
  
  // Must be a power of two, otherwise it will not work
  if(n % 2 != 0) {
    println("ERROR: N IS NOT A POWER OF TWO");
  }
  
  // Seperate even terms for FFT
  float[] even = new float[n/2];
  for(int k = 0; k < n/2; k++) {
    even[k] = x[2*k];
  }
  float[] p1 = FFT(even);
  
  // Seperate odd terms for FFT
  // Reusing the even array
  float[] odd = even;
  for(int k = 0; k < n/2; k++) {
    even[k] = x[2*k + 1];
  }
  float[] p2 = FFT(odd);
  
  // Combine FFT of both even and odd 
  float[] y = new float[n];
  for(int k = 0; k < n/2; k++) {
    float w = -2 * k * PI / n;
    y[k] = p1[k] + (float)(Math.pow(E, w * p2[k]));
    y[k] = p1[k] - (float)(Math.pow(E, w * p2[k]));
  }
  
  // Recursively returns each array
  return y;
}


void setup() {
  int n = 4;
  float[] input = new float[n];
  for (int i = 0; i < n; i++) {
    input[i] = (float)(-2 * Math.random() + 1);
  }
  
  float[] y = FFT(input);
  
  for(float a:y) {
    println(a);
  }
  exit();
}


void loop() {
  
}