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

classdef WaitForCommand
    %WaitForCommand Conversion of CR_WaitFor.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = WaitForCommand(obj, varargin)
            dataTableObj, test_report_list, report_idx, variableTwo, variableThree, variableFour, variableFive
            outputArg = false;    
            
            match = [variableTwo, variableThree, variableFour, variableFive];
            
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_list(test_report_list{report_idx}.idx.waitfor) = -2; % default to usage error
            
            if length(match) ~= 3 && length(match) ~= 4
                %TODO ERROR HANDLER
            else
                waitfor_var      = variableTwo;
                waitfor_operator = variableThree;
                waitfor_num      = variableFour;
                if length(match) == 5
                    waitfor_timeout = str2double(variableFive);
                    waitfor_useTimeout = 1;
                else
                    waitfor_useTimeout = 0;
                end

                if ~(strcmp(waitfor_operator,'!=')||strcmp(waitfor_operator,'<')||strcmp(waitfor_operator,'<=')...
                        ||strcmp(waitfor_operator,'==')||strcmp(waitfor_operator,'>')||strcmp(waitfor_operator,'>='))
                    myError(handles.logfile,depth,['Operator ' waitfor_operator ' is not recognized for WAITFOR command'])
                end

                % In Matlab, Not Equals is "~=" rather than "!="
                if(strcmp(waitfor_operator, '!='))
                    waitfor_operator = '~=';
                end

                [index, machine] = TestGUI('findReadIndex',handles, waitfor_var);

                if index == -1
                    %TODO ERROR HANDLER
                elseif obj.userData.varTypes(index) == 2
                    %TODO ERROR HANDLER
                elseif obj.userData.varTypes(index) == 3
                    %TODO ERROR HANDLER
                elseif obj.debugMode == 0
                    if obj.userData.varTypes(index) == 1
                        index = obj.userData.varIndexes(index);
                    else
                        index = obj.userData.varValues{index}.signal;
                    end

                    waitfor_startTime = now;

                    while(true)
                        if contains(machine,'tg6111')
                            currentVal = getsignal(handles.tg6111,index);
                        else
                            currentVal = getsignal(handles.tg6112,index);
                        end

                        if eval([num2str(currentVal) waitfor_operator waitfor_num])
                            %TODO LOG FILE
                            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_list(test_report_list{report_idx}.idx.waitfor) = (now-waitfor_startTime)*24*3600*1000;
                            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_val_list(test_report_list{report_idx}.idx.waitfor) = currentVal;
                            break;
                        end

                        if (waitfor_useTimeout == 1)
                            if ((now-waitfor_startTime)*24*3600*1000 >= waitfor_timeout)
                                %TODO ERROR HANDLER
                                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_list(test_report_list{report_idx}.idx.waitfor) = -1; % Timeout Error
                                break;
                            end
                        end

                        % Allow events to be processed
                        pause(0.001);
                    end
                end
            end

            test_report_list{report_idx}.idx.waitfor = test_report_list{report_idx}.idx.waitfor + 1;
            outputArg = true;
        end
    end
end