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

classdef ReportRequirementCommand
    %ReportRequirementCommand Conversion of CR_rept_reqt.m
    
    properties
        instr = [];
        outstr = [];
    end
    
    methods
        %examine variable
        function [obj] = reportRequirementCommand(obj)
          
        end
        function [obj] = reportrequirement(obj)
            temp_check = obj.instr(3);
                   temp_check_split = strsplit(temp_check," ");
                   cont_check = contains(temp_check_split,"'");
                   x = find(cont_check == 1);
                   if ~isempty(x)
                       str_check = temp_check_split(x);
                        for i = 1:length(x)
                            temp = strsplit(str_check(i),"'");
                            temp_empty = strcmpi(temp,"");
                            temp_idx = find(temp_empty == 1);
                            if (temp_idx == 1) && (length(temp)~= 2)
                                temp_check_split(x(i)) = strjoin(["'",...
                                temp_check_split(x(i))],"");
                            elseif temp_idx == 2 && (length(temp)~= 2)
                             temp_check_split(x(i)) = strjoin(...
                                [temp_check_split(x(i)),"'"],"");
                            end
                            if length(temp) == 3
                                temp_check_split(x(i)) = strjoin([temp(1),...
                                    "''",temp(2),"''",temp(3)],"");
                            end
                        end
                   end
                   obj.instr(3) = strjoin(temp_check_split," ");
           obj.outstr = [strjoin(["% Line ",obj.instr(1),...
                  " -- Report Requirement Command"],""); ... %end 1
                  strjoin(["%",obj.instr(2:3)]," ");...%end 2
                  strjoin(["pkObj.recordData('command',","'",...
                  strjoin(obj.instr(2:3)," "),"'",", ",...
                  obj.instr(1),");"],"");...%end 3
                  strjoin(["pkObj.recordData('Report Requirement',","'",...
                  strjoin(obj.instr(3)," "),"');"],"")];
        end
    end
end