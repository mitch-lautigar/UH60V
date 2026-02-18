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

classdef MathCommand
    %%MathCommand Conversion of CR_math.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = MathCommand(obj, varargin)
            dataTableObj, variableTwo, variableThree, variableFour, variableFive, userData
            outputArg = false;
            outIndex = findWriteIndex(handles,variableTwo);
            in1Index = findReadIndex(handles,variableThree);
            in2Index = findReadIndex(handles,variableFive);
            if (outIndex == -1)
                %TODO ERROR HANDLER
            elseif (in1Index == -1)
                %TODO ERROR HANDLER
            elseif (in2Index == -1)
                %TODO ERROR HANDLER
            elseif ~( strcmp(variableFour,'+') || strcmp(variableFour,'-')...
                   || strcmp(variableFour,'*') || strcmp(variableFour,'/')...
                   || strcmp(variableFour,'pow') || strcmp(variableFour,'fmod') )
                %TODO ERROR HANDLER
            elseif debugMode == 0
                outputArg = true;
                % valid I/O has been checked, get input values
                if obj.userData.varTypes(in1Index) == 1
                    in1value = getsignal(handles.tg,obj.userData.varIndexes(in1Index));
                elseif obj.userData.varTypes(in1Index) == 2
                    in1value = getparam(handles.tg,obj.userData.varIndexes(in1Index));
                elseif obj.userData.varTypes(in1Index) == 3
                    in1value = obj.userData.varValues{in1Index};
                else
                    in1value = getsignal(handles.tg,...
                        obj.userData.varValues{in1Index}.signal);
                end
                %TODO LOG FILE
                if obj.userData.varTypes(in2Index) == 1
                    in2value = getsignal(handles.tg,obj.userData.varIndexes(in2Index));
                elseif obj.userData.varTypes(in2Index) == 2
                    in2value = getparam(handles.tg,obj.userData.varIndexes(in2Index));
                elseif obj.userData.varTypes(in2Index) == 3
                    in2value = obj.userData.varValues{in2Index};
                else
                    in2value = getsignal(handles.tg,...
                        obj.userData.varValues{in2Index}.signal);
                end
                %TODO LOG FILE
                % caculate output value
                if strcmp(variableFour,'+')
                    value = in1value + in2value;
                elseif strcmp(variableFour,'-')
                    value = in1value - in2value;
                elseif strcmp(variableFour,'*')
                    value = in1value * in2value;
                elseif strcmp(variableFour,'/')
                    value = in1value / in2value;
                elseif strcmp(variableFour,'pow')
                    value = in1value ^ in2value;
                elseif strcmp(variableFour,'fmod')
                    value = mod(in1value,in2value);
                end
                %TODO LOG FILE
                % set output
                if obj.userData.varTypes(outIndex) == 2
                    setparam(handles.tg,obj.userData.varIndexes(outIndex),value);
                elseif obj.userData.varTypes(outIndex) == 3
                    scriptVarsUpdated = true;
                    obj.userData.varValues{outIndex} = value;
                elseif obj.userData.varTypes(outIndex) == 4
                    setparam(handles.tg,obj.userData.varValues{outIndex}.value,value);
                end
            end
        end
    end
end