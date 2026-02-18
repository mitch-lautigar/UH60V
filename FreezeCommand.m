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

classdef FreezeCommand
    %FreezeCommand Conversion of CR_freeze.m
    
     properties
        instr = [];
        outstr = [];
    end
    
    methods
        %examine variable
        function [obj] = freezeVariable(obj)
            %[cmd, success] = m_FreezeSetValsCmds(obj, variable, value)
            global BLASTT_table
            x = BLASTT_table;
            
            cmd_array = [];
            
                try
                cmd = x.m_FreezeSetValsCmds(char(obj.instr(3)),[str2double(obj.instr(4)) 1]);
                catch
                    cmd = ...
               [strjoin(["%could not find a freeze param in the data table named",...
               string(obj.instr(3))," "],'');...
               "%This line is because a non-existant variable was passed in"];
                    
                end
            cmd_array = [cmd_array;...
                strjoin(["% Line ",obj.instr(1)," - Freeze_command"],"");...
                strjoin(["%",obj.instr(2:4)]," ");...
                strjoin(["pkgObj.recordData('command', '",obj.instr(2:4)...
                "', ",obj.instr(1),");"]," ");...
                cellstr(cmd)];

            obj.outstr = cmd_array;
        end
        function obj = freezecommand(obj)

        end
    end
end