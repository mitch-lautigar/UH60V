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

classdef FreezeRCommand
    %FreezeRCommand Conversion of CR_freezer.m
    
    properties
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = freezeRVariable(obj, varargin)
            if ~isequal(nargin,5)
                outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the blast date table and variable name and the value and the time delay.');
                errorFlag = true;
            else
                errorFlag = false;
                dataTableObj = varargin{1};
                freezeVariable = varargin{2};
                valueVariable = varargin{3};
                timeDelayVariable = varargin{4};
            
            [target, paramID, freeze_index, inbounds] = dataTableObj.queryIndex(freezeVariable, valueVariable, 4);
            
            value = str2double(valueVariable);
            if ~isnan(timeDelayVariable)
                pauseTime = str2double(timeDelayVariable);
            else
                pauseTime = 0.02; % 50 hz
            end
                 if ~isemptyfrzBlk 
                    idx = paramID(frzBlk(1));
                    target = target(frzBlk(1));
                    outputStr1 = sprintf('%s.setparam(%d,%d);', target(1), idx(1), value); % Value
                    outputStr2 = sprintf('%s.setparam(%d,%d);', target(2), idx(2), 1); % Control
                    outputStr = strcat(outputStr1, outputStr2);
                    pause(pauseTime);
                 end
            end
        end
    end
end