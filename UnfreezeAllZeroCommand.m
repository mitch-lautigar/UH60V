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

classdef UnfreezeAllZeroCommand
    %UnfreezeAllZeroCommand Conversion of CR_UnfreezeAllZero.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = UnfreezeAllZeroCommand(obj, varargin)
            dataTableObj
            outputArg = false;    
            if ~obj.debugMode
                for i = 1:length(obj.userData.varTypes)
                    if obj.userData.varTypes(i) == 4
                        setparam(handles.tg,obj.userData.varValues{i}.control,0);
                        setparam(handles.tg,obj.userData.varValues{i}.value,0);
                    end
                end
                outputArg = true;
            end
        end
    end
end