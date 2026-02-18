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

classdef PlusCommand
    %PlusCommand Conversion of CR_plus.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = plusCommand(obj, varargin)
           if ~isequal(nargin,4)
            outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the datatable, handles, and variableTwo.');
            errorFlag = true;
          else
            dataTableObj = varargin{1};
            handles = varargin{2};
            variableTwo = varargin{3};
            errorFlag = false;
            if ~strcmp(handles.tg6111.Status,'running') && ~strcmp(handles.tg6112.Status,'running')
                errorFlag = true;
                outputStr = sprintf('Error in Plus Command.');
            else
                amount_to_pause = str2double(variableTwo);
                %test_report_list{report_idx}.cur_section_time = test_report_list{report_idx}.cur_section_time + amount_to_pause;
                startTime = handles.tg6112.ExecTime;
                endTime = startTime + amount_to_pause;
                set(handles.status,'String','Status : Waiting')
                while (handles.tg6112.ExecTime < endTime)
                    pause(0.01); %resolution is ~0.0023s without pauses
                end
                set(handles.status,'String','Status :')
                outputStr = sprintf('Plus Command Success.');
            end
           end
        end
    end
end