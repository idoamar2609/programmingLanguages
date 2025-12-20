use crate::ast::*;
use crate::semantics::*;

// The main Natural Operational Semantics function:
// nos: (Stm, State) -> State
pub fn nos(c: (Stm, State)) -> State {
    let (stm, state) = c;

    match stm {
        // Assignment: [ass]
        Stm::Ass(x, e) => update(&x, &e, &state),

        // Skip: [skip]
        Stm::Skip => state,

        // Composition: [comp]
        Stm::Comp(s1, s2) => {
            let new_state = nos((*s1, state));
            nos((*s2, new_state))
        }

        // If: [if_tt] and [if_ff]
        Stm::If(b, s1, s2) => {
            if solve_b(&b, &state) == "tt" {
                nos((*s1, state))
            } else {
                nos((*s2, state))
            }
        }

        // While: [while_tt] and [while_ff]
        Stm::While(b, s) => {
            if solve_b(&b, &state) == "tt" {
                let new_state = nos((*s.clone(), state));
                nos((Stm::While(b, s), new_state))
            } else {
                state
            }
        }

        // DoWhile: [dowhile_tt] and [dowhile_ff]
        Stm::DoWhile(s, b) => {
            let new_state = nos((*s.clone(), state));
            if solve_b(&b, &new_state) == "tt" {
                nos((Stm::DoWhile(s, b), new_state))
            } else {
                new_state
            }
        }
    }
}