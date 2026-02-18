%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%            U.S. Army Combat Capabilities Development Command            %
%        Systems Simulation, Software and Integration Directorate         %
%                          Redstone Arsenal, AL                           %
%*************************************************************************%
% Copyright $<year> US Army                                               %                    
%                                                                         %
% Licensed under the Apache License, Version 2.0 (the "License");         %
% you may not use this file except in compliance with the License.        %
% You may obtain a copy of the License at:                                %
%                                                                         %
%    http://www.apache.org/licenses/LICENSE-2.0                           %
%                                                                         %
% Unless required by applicable law or agreed to in writing, software     %
% distributed under the License is distributed on an "AS IS" BASIS,       %
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.%
% See the License for the specific language governing permissions and     %
% limitations under the License.                                          %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODIFICATION HISTORY:
%   15 NOV 2021 - Ryan Mabry, CCDC AVMC, ryan.m.mabry2.civ@army.mil
%       * Initial implementation' 
%

classdef FreezePCommand
    %FreezePCommand Conversion of CR_freezep.m
    
    properties
        instr = [];
        outstr = [];
    end
    
    methods
        %examine variable
        function [obj] = freezePVariable(obj)
            %[cmd, success] = m_FreezeSetValsCmds(obj, variable, value)
            global BLASTT_table
            x = BLASTT_table;
            cmd_array = [];
            var_name = obj.instr(5);
                try
                    cmd = x.m_FreezeSetValsCmds(char(var_name),[1 1]);
                catch
                    cmd = ...
               [strjoin(["%could not find a freezep param in the data table named",...
               string(obj.instr(5)),")"],'');...
               "%This line is because a non-existant variable was passed in"];
                    
                end
            cmd_array = [cmd_array;...
                strjoin(["% Line ",obj.instr(1)," - Freezep_command"],"");...
                strjoin(["pkgObj.recordData('command', 'freezep",...
                obj.instr(3), obj.instr(5:6),"',", obj.instr(1),");"]," ");...
                cellstr(cmd); strjoin(["pause(",obj.instr(3),")"],"")];

            obj.outstr = cmd_array;
        end
        function obj = freezePcommand(obj)

        end
    end
end