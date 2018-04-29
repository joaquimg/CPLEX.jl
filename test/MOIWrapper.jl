using CPLEX, Base.Test, MathOptInterface, MathOptInterface.Test

const MOIT = MathOptInterface.Test

@testset "Linear solver" begin
    config = MOIT.TestConfig()
    solver = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
    MOIT.atomictest(solver, config, ["singlevariable_obj"])
end

@testset "Linear tests" begin
    linconfig = MOIT.TestConfig()
    @testset "Default Solver"  begin
        solver = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
        MOIT.contlineartest(solver, linconfig, ["linear10","linear12","linear8a","linear8b","linear8c"])
    end
    # @testset "InfUnbdInfo=1" begin
    #     solver_nopresolve =CPLEXOptimizer(CPX_PARAM_SCRIND=0)
    #     MOIT.contlineartest(solver_nopresolve, linconfig, ["linear10","linear12","linear8a"])
    # end
    @testset "No certificate" begin
        solver = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
        linconfig_nocertificate = MOIT.TestConfig(infeas_certificates=false)
        MOIT.linear12test(solver, linconfig_nocertificate)
        MOIT.linear8atest(solver, linconfig_nocertificate)
    end
    # 10 is ranged
end

@testset "Quadratic tests" begin
    quadconfig = MOIT.TestConfig(atol=1e-4, rtol=1e-4, duals=false, query=false)
    solver = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
    MOIT.contquadratictest(solver, quadconfig, ["qcp"])
end

@testset "Linear Conic tests" begin
    linconfig = MOIT.TestConfig()
    solver = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
    MOIT.lintest(solver, linconfig, ["lin3","lin4"])

    # solver_nopresolve = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
    # MOIT.lintest(solver_nopresolve, linconfig)
end

@testset "Integer Linear tests" begin
    intconfig = MOIT.TestConfig()
    solver = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
    MOIT.intlineartest(solver, intconfig, ["int3"])

    # 3 is ranged
end
@testset "ModelLike tests" begin
    solver =CPLEXOptimizer(CPX_PARAM_SCRIND=0)
    MOIT.nametest(solver)
    @testset "validtest" begin
        MOIT.validtest(solver)
    end
    @testset "emptytest" begin
        MOIT.emptytest(solver)
    end
    @testset "orderedindicestest" begin
        MOIT.orderedindicestest(solver)
    end
    @testset "canaddconstrainttest" begin
        MOIT.canaddconstrainttest(solver, Float64, Complex{Float64})
    end
    @testset "copytest" begin
        solver2 = CPLEXOptimizer(CPX_PARAM_SCRIND=0)
        MOIT.copytest(solver,solver2)
    end
end