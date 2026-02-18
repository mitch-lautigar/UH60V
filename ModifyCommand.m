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

classdef ModifyCommand
    %ModifyCommand Conversion of CR_modify.m
    
    properties
        instr = [];
        outstr = [];
    end
    
    methods
        %examine variable
        function [obj] = ModifyCommand(obj)

        end
        function [obj] = modifyvariable(obj)
            global BLASTT_table
           x = BLASTT_table;
           cmd_array = [];
            
                try
            cmd = x.m_ModifySetValCmd(char(obj.instr(3)),...
                str2double(obj.instr(4)));
                catch
                    cmd = ...
               [strjoin(["%could not find a modify param in the data table named ",...
               string(obj.instr(3)),")"],'');...
               "%This line is because a non-existant variable was passed in"];
                    
                end
            cmd_array = [cmd_array;...
                strjoin(["% Line ",obj.instr(1)," - Modify_command"],"");...
                strjoin(["pkObj.recordData('command', 'modify",...
                obj.instr(3:4),"',",obj.instr(1),");"]," ");...
                cellstr(cmd)];
            
            obj.outstr = cmd_array;
        end
    end
end