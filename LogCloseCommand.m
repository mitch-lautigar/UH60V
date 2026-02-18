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

classdef LogCloseCommand
    %logCloseCommand Conversion of CR_logclose.m
    
    properties
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = logCloseCommand(obj, varargin)
          if ~isequal(nargin,3)
            outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the handles and event data.');
            errorFlag = true;
          else
            handles = varargin{1};
            eventData = varargin{2};
            errorFlag = false;
            if isstruct(eventdata)
                    % only execute for top level script, not embedded ones
                    %TODO LOG FILE
            else
                    if handles.logfile == -1
                        errorFlag = true;
                        outputStr = sprintf('Error log file close.');
                    end
                    status = fclose(handles.logfile);
                    if status == -1
                        errorFlag = true;
                        outputStr = sprintf('Error log file close');
                    end
                    
                    handles.logfile = -1;
                    % Update handles structure
                    guidata(hObject, handles);
                    outputStr = sprintf('Log File Close Success.');
            end
          end
        end
    end
end