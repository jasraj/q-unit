// q-unit
//  Utility Functions
// Copyright (C) 2014 Jaskirat M.S. Rajasansir
// License BSD, see LICENSE for details

/ Performs an 'is empty' check on the input. This is useful in the case where
/ the object can be a list of nulls, it is defined as 'empty'.
/  @param obj () Any valid kdb object
/  @returns (Boolean) True if the input is classed as 'empty', false otherwise
.util.isEmpty:{[obj]
    :all null obj;
 };
 
/ Ensures that a string is returned to the caller, regardless of input. Useful for logging. NOTE:
/ Uses 'string' to print symbols, '.Q.s1' for all other types.
/  @param input (Atom) Any atom to ensure is a string
/  @returns (String) The string representation of the atom
.util.ensureString:{[input]
    if[.util.isString input;
        :input;
    ];

    if[.util.isAtom input;
        :string input;
    ];

    :.Q.s1 input;
 };
 
/ @returns (Boolean) True if the input is a String, false otherwise.
.util.isString:{[str]
    :10h~type str;
 };

/ @returns (Boolean) True if the input is an atom type, false otherwise.
.util.isAtom:{[atom]
    :type[atom] within -19 -1h;
 };
