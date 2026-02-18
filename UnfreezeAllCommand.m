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

classdef UnfreezeAllCommand
    %UnfreezeAllCommand Conversion of CR_UnfreezeAll.m
    
    properties
        freeze_array = [];
        instr = [];
        outstr = [];
    end
    
    methods
        %examine variable
        function [obj] = UnfreezeAllCommand(obj)
            
        end
        function [obj] = UnfreezeAll(obj)
            [a,~] = size(obj.freeze_array);
            cmd_array = [];
            global BLASTT_table
            x = BLASTT_table;
            for i = 1:a
                freeze_call = obj.freeze_array(i,1);
                if strcmpi(freeze_call,'freeze')
                    try
                    cmd = x.m_FreezeSetValsCmds(char(obj.freeze_array(i,2))...
                        ,[1 0]);
                    catch
                        cmd = ...
                           [strjoin(["%could not find a freeze param in the data table named",...
                           string(obj.freeze_array(i,2))," "],'');...
                           "%This line is because a non-existant variable was passed in"];
                                
                    end
                    cmd_array = [cmd_array;cellstr(cmd)];
                elseif strcmpi(freeze_call,'freezep')
                    cmd_array = [];
                    var_name = obj.freeze_array(i,2);
                    try
                        cmd = x.m_FreezeSetValsCmds(char(var_name),[1 0]);
                    catch
                        cmd = ...
                   [strjoin(["%could not find a freezep param in the data table named",...
                   string(var_name),")"],'');...
                   "%This line is because a non-existant variable was passed in"];
                        
                    end
                    cmd_array = [cmd_array;cellstr(cmd)];
                elseif strcmpi(freeze_call,'freezer')

                elseif strcmpi(freeze_call,'freezeascii')

                end
            end
            obj.outstr = [strjoin(["% Line Number",obj.instr(1),...
                "Unfreeze Command"]," ");... %end1;
                strjoin(["%",obj.instr(1:2)]," ");...end2
                cmd_array];
        end
    end
end