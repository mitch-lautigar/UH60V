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

classdef RangeCheckCommand
    %RangeCheckCommand Conversion of CR_rangecheck.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = rangeCheckCommand(obj, varargin)
            dataTableObj, variableOne, variableThree, variableFour, variableFive
            outputArg = false;
            allMatches = variableOne;

            min    = str2double(variableThree);
            max    = str2double(variableFour);
            delta  = str2double(variableFive);
            range  = (max-min);
            points = [min-delta min+delta max-delta max+delta min+range*0.5];

            for i=1:length(points)
                value = num2str(points(i));
                % freeze value
                match = (['freeze ' allMatches(2) value]); %#ok<*NASGU>
                CR_freeze;
                % Add report note
                for j=6:length(allMatches)
                    match = ['Rept_Note' {['Variable ' allMatches(2) ' value set to ' value]}];
                    CR_rept_note;
                    % pause
                    pause(5);
                    % Take screenshot
                    match = ['CR_screenshot' allMatches(j)];
                    CR_screenshot;
                end
                outputArg = true;
            end
        end
    end
end