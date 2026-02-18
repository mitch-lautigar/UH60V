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

classdef IFNCommand
    %IFNCommand Conversion of CR_ifn.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = IFNCommand(obj, varargin)
            dataTableObj, variableTwo, variableThree, variableFour, variableFive
            outputArg = false;
            index = findReadIndex(handles, variableTwo);
            if index == -1
                myError(handles.logfile,depth,[variableTwo ' not found in variable '...
                        'lists for IFN command']);
            elseif obj.debugMode == 0
                outputArg = true;
                if UserDataVariableType.convertIntToEnum(obj.userData.varTypes(readIndex)) == UserDataVariableType.GET_SIGNAL
                    value = getsignal(handles.tg,obj.userData.varIndexes(index));
                elseif UserDataVariableType.convertIntToEnum(obj.userData.varTypes(readIndex)) == UserDataVariableType.GET_PARAM
                    value = getparam(handles.tg,obj.userData.varIndexes(index));
                elseif UserDataVariableType.convertIntToEnum(obj.userData.varTypes(readIndex)) == UserDataVariableType.VAR_VALUE
                    value = obj.userData.varValues{index};
                else
                    value = getsignal(handles.tg,...
                        obj.userData.varValues{index}.signal);
                end
                %TODO LOG FILE
                if ~( value >= str2double(variableThree) && ...
                     value <= str2double(variableFour) )
                    lineNumber = goto(script_fid,variableFive);
                end
            end
        end
    end
end