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

classdef DataSliderCommand
    %DataSliderCommand Conversion of CR_dataslider.m
    
    properties
        debugMode = false;
        userData = [];
    end
    
    methods
        function [outputStr, errorFlag] = DataSlider(obj, varargin)
            dataTable, writeVariable, handles, min, max, step
            index = findWriteIndex(handles,writeVariable);
            if index == -1
                %TODO ERROR HANDLER
                outputArg = false;
            else
                if    (strcmp(num2str(step),'NaN')...
                    || strcmp(num2str(min),'NaN') || strcmp(num2str(max),'NaN'))
                    %TODO ERROR HANDLER
                    outputArg = false;
                elseif min > max
                    myError(handles.logfile,depth,['MIN parameter in DATASLIDER command is'...
                        ' greater than MAX parameter value.']);
                    outputArg = false;
                end
                if obj.debugMode == 0
                    sliderHandles = sliderdlg('Handles',handles,'ParamName',writeVariable,...
                        'Step',step,'Min',min,'Max',max);

                    % The next 2 lines will force the variable textbox changed
                    % handler to get called which will perform additional setup.
                    % Without this, an exception will occur as soon as the slider
                    % is moved.
                    sliderGuiData = guidata(sliderHandles);
                    sliderdlg('param_menu_Callback', 0, 0, sliderGuiData);

                    % Setup some of the fields that get overwritten by param_menu_Callback
                    set(sliderGuiData.step_edit, 'String', num2str(step));
                    set(sliderGuiData.min_edit, 'String', num2str(min));
                    set(sliderGuiData.max_edit, 'String', num2str(max));
                    sliderdlg('step_edit_Callback', sliderGuiData.step_edit, [], sliderGuiData);
                    outputArg = true;
                end
            end
        end
    end
end