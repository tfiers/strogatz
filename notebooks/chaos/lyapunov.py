import matplotlib.pyplot as plt
import numpy as np
from scipy.integrate import solve_ivp

# f = fun(t, y)
# y0 = a phase point
# st = dt = time step
# kkmax = imax = max iter

def lyapunov(f, y0, dt=0.01, imax=1000):
    
    y0 = np.array(y0)
    
    # Dimensionality (== 3)
    n = y0.size

    # Initialise singular value sums to 0
    log_sv_cumul = np.zeros(n)

    # Container to track Lyaponov exponent convergence
    LE = np.zeros((imax, n))

    # Initialise tangent vectors as columns of identity matrix
    U = np.eye(n)

    # Integrate ODE & tangent vectors over dt,
    # then Gram-Schmidt orthogonalise ( {vecs}   -->   {orthogonal vecs} that span same space )
    for it in range(imax):
        t = it*dt
        # Long column vector containing phase point and tangent vectors
        var = np.concatenate([y0, np.reshape(U, n*n)])
        # Solve ODE for phase point and tangent vectors
        # var_new = solve_ivp(f, (t-dt, t), var, t_eval=[t], method='RK23').y[:,0]
        var_new = var + f(t, var) * dt
        # Recover new phase point and tangent vectors
        y0 = var_new[:n]
        dx = np.reshape(var_new[n:], (n,n))
        # GS-orthogonalise tangent vectors
        # U, s, _ = np.linalg.svd(dx)
        V = np.zeros_like(dx)
        for i in range(n):
            V[:,i] = dx[:,i]
            for j in range(i):
                dotp = V[:,i].T @ U[:,j]
                V[:,i] -= dotp * U[:,j]
            veclen = np.sqrt(V[:,i].T @ V[:,i])
            U[:,i] = V[:,i] / veclen
            log_sv_cumul[i] += np.log(veclen)
            LE[it,i] += log_sv_cumul[i] / t
            
        # Accumulate logs of singular values
        # log_sv_cumul += np.log(s)
        # Division by current time yields Lyapunov exponents
        # LE[it,:] = log_sv_cumul / t
    
    fig, ax = plt.subplots()
    for i in range(3):
        ax.plot(np.arange(imax)+1, LE[:,i])
    ax.set_xlabel('Iteration')
    ax.set_ylabel('Lyapunov exponent')
    print(LE[-1, :])
    return fig, ax, LE[-1,:]
