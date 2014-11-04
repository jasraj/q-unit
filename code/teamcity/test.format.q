// q-unit
//  Test Output Formating for TeamCity
// Copyright (C) 2014 Jaskirat M.S. Rajasansir
// License BSD, see LICENSE for details

// SEE: http://confluence.jetbrains.com/display/TCD7/Build+Script+Interaction+with+TeamCity

/ Character conversions for TeamCity service messages
/  @see .qunit.ci.tc.escapeValues
.qunit.ci.tc.characterMap:enlist ("|";"||");
.qunit.ci.tc.characterMap,:("'";"|'");
.qunit.ci.tc.characterMap,:("\n";"|n");
.qunit.ci.tc.characterMap,:("\r";"|r");

/ Mandatory parameters for all TeamCity messaes
.qunit.ci.tc.requiredMsgParams:()!();
.qunit.ci.tc.requiredMsgParams[`flowId]:.z.i;


/ Generic TeamCity message printer
/  @param msgDict (Dict) The elements to print in the service message. Empty list is parsed as no value.
.qunit.ci.tc.printMessage:{[msgDict]
    msgDict,:.qunit.ci.tc.requiredMsgParams;

    msgDetail:{
        $[.util.isEmpty x y;
            :string y;
            :string[y],"='",.qunit.ci.tc.escapeValues[.util.ensureString x y],"'"
        ];
    }[msgDict;] each key msgDict;

    -1 "##teamcity[",(" " sv msgDetail),"]";
 };
 
/ Escapes any known characters that are not supported natively by TeamCity.
/  @param str (String) The string to escape the characters from
/  @returns (String) The string with escaped characters
/  @throws InvalidCharactersForTeamCityMessageException If any square brackets are detected in the string. They are not supported AT ALL by TeamCity.
/  @see .qunit.ci.tc.characterMap
.qunit.ci.tc.escapeValues:{[str]
    if[any "[]" in\: str;
        .log.error "Invalid characters detected in message provided for TeamCity conversion. Square brackets are not permitted.";
        '"InvalidCharactersForTeamCityMessageException";
    ];

    :{ ssr[x;y 0;y 1] }/[str;.qunit.ci.tc.characterMap]
 };
