using Memento

# Create our module level logger (this will get precompiled)
const LOGGER = getlogger(current_module())   # or `getlogger(@__MODULE__)` on 0.7

# Register the module level logger at runtime so that folks can access the logger via 
# `getlogger(MyModule)`
# NOTE: If this line is not included then the precompiled `MyModule.LOGGER` won't be 
# registered at runtime.
__init__() = Memento.register(LOGGER)

# function getlogger()::Memento.Logger
#     Memento.getlogger(current_module())
# end

function setloglevel!(level::String)
    # Options correspond to Memento.jl's levels.
    # https://invenia.github.io/Memento.jl/latest/man/intro.html#Logging-levels-1
    logger = MIPVerify.LOGGER
    Memento.setlevel!(logger, level)
    while logger.name != "root"
        logger = Memento.getparent(logger.name)
        Memento.setlevel!(logger, level)
    end
end

setloglevel!("notice")
