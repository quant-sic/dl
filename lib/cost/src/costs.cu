/*
  CLASS FILE FOR COSTS
  
  AUTHOR  : FABIAN DECHANT / JANNIS SCHÜRMANN
  DATE    : 20.08.2020
  TO-DO   : 1. costs -> parent class -> inherit for different cost types
            2. 
  CAUTION : 
*/

#include "costs.h"

//_______________________________________________________________________________________________
// destructor
costs::~costs(void)
{
}



//_______________________________________________________________________________________________
// cost calculaion
double cce_soft_cost::cost(matrix predict,
			   matrix target,
			   bool   flag_host)
{
  if (flag_host)
    return cce_softmax_cpu(predict.data_host.get(), target.data_host.get(), predict.size(), predict.rows());
  else
    return cce_softmax_onDev(predict.data_device.get(), target.data_device.get(), predict.size(), predict.rows());
}

//_______________________________________________________________________________________________
// dcost calculation
matrix cce_soft_cost::dcost(matrix predict,
			    matrix target,
			    matrix dy,
			    bool   flag_host)
{
  if (flag_host)
    d_cce_softmax_cpu(predict.data_host.get(), target.data_host.get(), dy.data_host.get(), predict.size(), predict.rows());
  else
    d_cce_softmax_onDev(predict.data_device.get(), target.data_device.get(), dy.data_device.get(), predict.size(), predict.rows());
  matrix ret = dy;
  return ret;
}
