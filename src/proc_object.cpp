#include "natalie.hpp"

namespace Natalie {

Value ProcObject::initialize(Env *env, Block *block) {
    m_block = block;
    return this;
}

Value ProcObject::call(Env *env, Args args, Block *block) {
    assert(m_block);
    if (is_lambda() && m_break_point != 0) {
        try {
            return NAT_RUN_BLOCK_WITHOUT_BREAK(env, m_block, args, block);
        } catch (ExceptionObject *exception) {
            if (exception->is_local_jump_error_with_break_point(m_break_point))
                return exception->send(env, "exit_value"_s);
            throw exception;
        }
    }
    return NAT_RUN_BLOCK_WITHOUT_BREAK(env, m_block, args, block);
}

Value block_wrapper_fn(Env *env, Value, Args, Block *) {
    auto proc = env->outer()->var_get("proc", 0);
    assert(proc);
    assert(proc->is_proc());
    return proc->as_proc()->call(env);
}

Block *ProcObject::wrap_in_block(ModuleObject *owner) {
    auto block_env = new Env {};
    block_env->var_set("proc", 0, true, this);
    return new Block { block_env, owner, block_wrapper_fn, 0 };
}

}
