struct ForwardDiffADGradient <: ADBackend
  cfg
end
function ForwardDiffADGradient(
  nvar::Integer,
  f,
  ncon::Integer = 0;
  x0::AbstractVector = rand(nvar),
  kwargs...,
)
  @assert nvar > 0
  @lencheck nvar x0
  cfg = ForwardDiff.GradientConfig(f, x0)
  return ForwardDiffADGradient(cfg)
end
gradient(adbackend::ForwardDiffADGradient, f, x) = ForwardDiff.gradient(f, x, adbackend.cfg)
function gradient!(adbackend::ForwardDiffADGradient, g, f, x)
  return ForwardDiff.gradient!(g, f, x, adbackend.cfg)
end

struct ForwardDiffADJacobian <: ADBackend
  nnzj::Int
end
function ForwardDiffADJacobian(nvar::Integer, f, ncon::Integer = 0; kwargs...)
  @assert nvar > 0
  nnzj = nvar * ncon
  return ForwardDiffADJacobian(nnzj)
end
jacobian(::ForwardDiffADJacobian, f, x) = ForwardDiff.jacobian(f, x)

struct ForwardDiffADHessian <: ADBackend
  nnzh::Int
end
function ForwardDiffADHessian(nvar::Integer, f, ncon::Integer = 0; kwargs...)
  @assert nvar > 0
  nnzh = nvar * (nvar + 1) / 2
  return ForwardDiffADHessian(nnzh)
end
hessian(::ForwardDiffADHessian, f, x) = ForwardDiff.hessian(f, x)

struct ForwardDiffADJprod <: ADBackend end
function ForwardDiffADJprod(nvar::Integer, f, ncon::Integer = 0; kwargs...)
  return ForwardDiffADJprod()
end
function Jprod(::ForwardDiffADJprod, f, x, v)
  return ForwardDiff.derivative(t -> f(x + t * v), 0)
end

struct ForwardDiffADJtprod <: ADBackend end
function ForwardDiffADJtprod(nvar::Integer, f, ncon::Integer = 0; kwargs...)
  return ForwardDiffADJtprod()
end
function Jtprod(::ForwardDiffADJtprod, f, x, v)
  return ForwardDiff.gradient(x -> dot(f(x), v), x)
end

struct ForwardDiffADHvprod <: ADBackend end
function ForwardDiffADHvprod(nvar::Integer, f, ncon::Integer = 0; kwargs...)
  return ForwardDiffADHvprod()
end
function Hvprod(::ForwardDiffADHvprod, f, x, v)
  return ForwardDiff.derivative(t -> ForwardDiff.gradient(f, x + t * v), 0)
end

struct ForwardDiffADGHjvprod <: ADBackend end
function ForwardDiffADGHjvprod(nvar::Integer, f, ncon::Integer = 0; kwargs...)
  return ForwardDiffADGHjvprod()
end
function directional_second_derivative(::ForwardDiffADGHjvprod, f, x, v, w)
  return ForwardDiff.derivative(t -> ForwardDiff.derivative(s -> f(x + s * w + t * v), 0), 0)
end