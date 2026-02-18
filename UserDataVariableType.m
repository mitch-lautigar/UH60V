classdef UserDataVariableType
   enumeration
      GET_SIGNAL, GET_PARAM, VAR_VALUE, VAR_VALUE_GET_SIGNAL;
   end
   methods(Static)
       function outputArg = convertIntToEnum(numeric_value)
           if numeric_value == 1
               outputArg = UserDataVariableType.GET_SIGNAL;
           elseif numeric_value == 2
               outputArg = UserDataVariableType.GET_PARAM;
           elseif numeric_value == 3
               outputArg = UserDataVariableType.VAR_VALUE;
           elseif numeric_value == 2
               outputArg = UserDataVariableType.VAR_VALUE_GET_SIGNAL;
           end
       end
   end
end