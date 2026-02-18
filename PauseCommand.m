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

classdef PauseCommand
    %PauseCommand Conversion of CR_pause.m
    
    properties
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = pauseCommand(obj, varargin)
          if ~isequal(nargin,3)
            outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the variableTwo and handles.');
            errorFlag = true;
          else
            variableTwo = varargin{1};
            handles = varargin{2};
            errorFlag = false;
            set(handles.status,'String','Status : Paused')
            pause(str2double(variableTwo))
            set(handles.status,'String','Status :')
            outputStr = sprintf('Pause Command Success.');
          end
        end
    end
end