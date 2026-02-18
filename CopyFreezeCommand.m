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

classdef CopyFreezeCommand
    %CopyFreezeCommand Conversion of CR_copyfreeze.m
    %   CR_copyfreeze.m
    
    properties
        instr   = [];
        outstr  = [];
    end
    
    methods
        
        %copies variable and freezes it
        %returns true if successful, false otherwise
        function [obj] = copyFreezeCommand(obj)
           
        end
        function [obj] = copyFreezeVariable(obj)
            global BLASTT_table
            x = BLASTT_table;
            
           stringout = [strjoin(["% Line ",obj.instr(1)," - Copy Command"],"");...
                strjoin(["%",obj.instr(2:4)]," ");...
                strjoin([obj.instr(4)," = ",obj.instr(3),";"]," ")];
           cmd = x.m_FreezeSetValsCmds(char(obj.instr(4)),[str2double(obj.instr(3)) 1]);
           obj.outstr = [stringout;cmd];
        end
    end
end