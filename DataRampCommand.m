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

classdef DataRampCommand
    %DataRampCommand Conversion of CR_dataramp.m
    
    properties
        debugMode = false;
        userData = [];
    end
    
    methods
        function [outputStr, errorFlag] = DataRamp(obj, varargin)
            if ~isequal(nargin,8)
                outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the blast date table, freeze variable, initial ramp, step ramp, start ramp, min ramp, and max ramp.');
                errorFlag = true;
            else
                errorFlag = false;
                dataTableObj = varargin{1};
                freezeVariable = varargin{2};
                initialRamp = varargin{3};
                stepRamp = varargin{4};
                startRamp = varargin{5};
                minRamp = varargin{6};
                maxRamp = varargin{7};
                %Get the freeze variable index
                [target, paramID, index, inbounds] = dataTableObj.queryIndex(freezeVariable, 4);
                if index > 0
                else

                    if    (strcmp(num2str(initialRamp),'NaN') || strcmp(num2str(stepRamp),'NaN')...
                        || strcmp(num2str(minRamp),'NaN') || strcmp(num2str(maxRamp),'NaN'))
                        %TODO ERROR HANDLER
                    elseif (startRamp ~= -2 && startRamp ~= -1 && startRamp ~= 0)
                        myError(handles.logfile,depth,['Start parameter for DATARAMP must be -2 (visible/no autostart) , -1 (visible/autostart)'...
                            ' or 0 (invisible/autostart)']);
                    elseif minRamp > maxRamp
                        myError(handles.logfile,depth,['MIN parameter in DATARAMP command is'...
                            ' greater than MAX parameter value.']);
                    end

                      % Flag that determines if ramp dialog will be visible
                      visi = 'On';

                      % If -1 autostart is enabled, don't show the ramp dialog
                      if startRamp == 0
                        visi = 'Off';
                      end

                      rampHandles = rampdlg('Handles',handles,'ParamName',freezeVariable,...
                        'Initial',initialRamp,'Step',stepRamp,'Min',minRamp,'Max',maxRamp, 'Visi', visi);

                      % If autostart is enabled, start the ramp
                      if startRamp == -1 || startRamp==0
                        rampdlg('startRamp', rampHandles);
                        outputStr = sprintf('Ramp success.');
                      end
                end
            end
        end
    end
end