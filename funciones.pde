

void keyPressed()
{
  if(key == 'e')
  {
    euler_activated = true;
  }
  else if(key == 'v')
  {
    euler_activated = false;
  }
  
  if(key == 'w')
  {
   wind_activated = true; 
  }
  else if (key == 's')
  {
   wind_activated = false; 
  }
  if(wind_activated)
  {
   if(key == 'd')
   {
    wind_right = true;
    wind_left = false;
   }
   else if(key == 'a')
   {
    wind_right = false;
    wind_left = true;
   }    
    
  }
  
}
