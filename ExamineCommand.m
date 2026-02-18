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

classdef ExamineCommand
    %ExamineCommand Conversion of CR_examine.m
    
    properties
        instr   = [];
        outstr  = [];
    end
    
    methods
        %examine variable
        function [obj] = examineCommand(obj)
           
        end
        function [obj] = examineVariable(obj)
           cmd = [strjoin(["% Line ",obj.instr(1)," - Examine Command"],"");...
                strjoin(["%",obj.instr(2:3)]," ");...
                strjoin(["if exist(",obj.instr(3),")"],"");...
                strjoin(["pkObj.recordData('command',","'",...
                  strjoin(obj.instr(2:3)," "),"'",", ",...
                  obj.instr(1),");"],"");...%end 3
                  strjoin(["pkObj.recordData('Report Requirement',","'",...
                  strjoin(obj.instr(3)," "),"');"],"")];
                obj.outstr = cmd;
        end
    end
end