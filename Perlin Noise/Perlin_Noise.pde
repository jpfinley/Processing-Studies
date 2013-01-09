public Noise1(int x){
 x = (x << 13) ^ x;
 return ( 1.0 - (x * (x * x * 15731 + 789221) + 1376312589) / 1073741824.0);
}

public void SmoothedNoise_1(float x){
 return Noise(x)/2  +  Noise(x-1)/4  +  Noise(x+1)/4;
}


public InterpolatedNoise_1(float x){

   integer_X    = int(x);
   fractional_X = x - integer_X;

   v1 = SmoothedNoise1(integer_X);
   v2 = SmoothedNoise1(integer_X + 1);

   return Interpolate(v1 , v2 , fractional_X);
}


public PerlinNoise_1D(float x){

   float total = 0;
   float p = persistence;
   int n = Number_Of_Octaves - 1;

   for(int i = 0; i < n; i++){
       int frequency = 2i;
       int amplitude = pi;
       total = total + InterpolatedNoisei(x * frequency) * amplitude;
   }
   println total;
}
