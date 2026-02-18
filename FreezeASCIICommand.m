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

classdef FreezeASCIICommand
    %FreezeASCIICommand Conversion of CR_freezeASCII.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = freezeASCIIVariable(obj, varargin)
            if ~isequal(nargin,5)
                outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the blast date table and variable name and the ascii code and the value to change the variable to.');
                errorFlag = true;
            else
                errorFlag = false;
                dataTableObj = varargin{1};
                freezeVariable = varargin{2};
                asciiCode = varargin{3};
                inputStr = varargin{4};
                
                [target, paramID, frzIdx, inbounds] = dataTableObj.queryIndex(freezeVariable, 4);
                varName = 'existingTableValue';
                existingTableValueCmdString = dataTableObj.table.queryValue(target,frzIdx,varName);
                %'existingTableValue = getparm(.....)'
                eval(existingTableValueCmdString)
                paramLength = numel(existingTableValue);
                inputASCII = ones(1,paramLength).*str2double(asciiCode);
                inputASCII(1:numel(inputStr)) = uint8(inputStr);
                inputASCII(paramLength+1:end) = [];                
                
                [target, paramID, frzIdx, inbounds] = dataTableObj.queryIndex(freezeVariable, inputASCII, 4);
                
                if ~isemptyfrzBlk % CAN FIND FREEZE MATCH ONLY
                    idx = paramID(frzBlk(1));
                    target = target(frzBlk(1));
                    outputStr1 = sprintf('%s.setparam(%d,%d)', target(1), idx(1), value); % Value
                    outputStr2 = sprintf('%s.setparam(%d,%d)', target(2), idx(2), 1); % Control
                    outputStr = strcat(outputStr1, outputStr2);       
                end      
            end
        end
    end
end