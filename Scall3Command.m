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

classdef Scall3Command
    %SaveSubImagesCommand Conversion of CR_saveSubImages.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = Scall3Command(obj,varargin)
             path, test_report_list, nextEventData, handles
            outputArg = false;
            scriptPath = path;
            if exist(path,'file')
                nextEventData.depth  = depth + 1;
                nextEventData.script = scriptPath;
                nextEventData.test_report_list = test_report_list;
                if nextEventData.depth > 8
                   %TODO ERROR HANDLER
                else
                    %TODO LOG FILE
                    try %#ok<TRYNC>
                       if handles.speak
                           Speak(handles.speaker,['Running the embedded script ' path]);
                       end
                    end
                    TestGUI('scriptpb_Callback',hObject, nextEventData, handles)
                    % delete('powerPanel.png');
                    %TODO LOG FILE
                end
            else
               %TODO ERROR HANDLER
            end
        end
    end
end