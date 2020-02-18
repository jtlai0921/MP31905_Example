###################################################################
# abc_optim(par, fn, D=length(par), ..., NP=40, FoodNumber = NP/2,
#           lb=-Inf, ub=+Inf, limit=100, maxCycle=1000, optiinteger=FALSE,
#           criter=50)
# Arguments:
# par: Initial values for the parameters to be optimized over
# fn:  A function to be minimized, with first argument of the vector of parameters over
#      which minimization is to take place. It should return a scalar result.
# D:   Number of parameters to be optimized.
# ...  Further arguments to be passed to ¡¦fn¡¦.
# NP:  Number of bees.
# FoodNumber: Number of food sources to exploit.
# lb: Lower bound of the parameters to be optimized.
# ub: Upper bound of the parameters to be optimized.
# limit: Limit of a food source.
# maxCycle: Maximum number of iterations.
# optiinteger: Whether to optimize binary parameters or not.
# criter: Stop criteria (numer of unchanged results) until stopping

install.packages("ABCoptim")
library(ABCoptim)

# EXAMPLE: global minimum at about (-15.81515)
fw <- function (x)
  10*sin(0.3*x)*sin(1.3*x^2) + 0.00001*x^4 + 0.2*x+80
abc_optim(50, fw, lb=-100, ub=100, criter=100)

