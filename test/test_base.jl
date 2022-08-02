using MLFlowClient
using Test
using UUIDs
using Dates

function mlflow_server_is_running(mlf::MLFlow)
    try
        response = MLFlowClient.mlfget(mlf, "experiments/list")
        return isa(response, Dict)
    catch e
        return false
    end
end

# creates an instance of mlf
# skips test if mlflow is not available on default location, http://127.0.0.1:5000
macro ensuremlf()
    e = quote
        mlf = MLFlow("http://127.0.0.1:5000")
        mlflow_server_is_running(mlf) || return nothing
    end
    eval(e)
end
