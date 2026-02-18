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

classdef VerifyWaitForCommand
    %VerifyWaitForCommand Conversion of CR_VerifyWaitForCommand.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = VerifyWaitForCommand(obj, varargin)
             test_report_list, report_idx, variableTwo, variableThree, variableFour, variableFive
            outputArg = false;  
            match = [variableTwo, variableThree, variableFour, variableFive];
            % setup the waitfor list default value (function error)
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_list(test_report_list{report_idx}.idx.waitfor) = -2; % default to usage error

            % setup the verify structure
            test_report_list{report_idx}.total_verify =  test_report_list{report_idx}.total_verify + 1;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}                = verify_type;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.type           = 2;            % waitfor type
            % if test_report_list{report_idx}.idx.reqt == 1
            %   SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt};
            % else
            %   SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt-1};
            % end
            % test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS = SRS;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.line = test_report_list{report_idx}.lineNumber;

            % link all unconsumed requirement structures to this action
            for i = test_report_list{report_idx}.idx.reqt_consumed : test_report_list{report_idx}.idx.reqt-1
                SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{i};
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS{end+1} = SRS;
            end
            % mark these requirements as consumed now
            test_report_list{report_idx}.idx.reqt_consumed = test_report_list{report_idx}.idx.reqt;
            

                if length(match) ~= 3 && length(match) ~= 4
                    %TODO ERROR HANDLER
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.msg            = ['Error, Incorrect number of arguments in call "' command '"'];
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
                else
                    waitfor_var      = variableTwo;
                    waitfor_operator = variableThree;
                    waitfor_num      = variableFour;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.variable_name  = waitfor_var;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.comment        = [waitfor_var waitfor_operator waitfor_num];
                    if length(match) == 4
                        waitfor_timeout = str2double(variableFive);
                        waitfor_useTimeout = 1;
                    else
                        waitfor_useTimeout = 0;
                    end

                    if ~(strcmp(waitfor_operator,'!=')||strcmp(waitfor_operator,'<')||strcmp(waitfor_operator,'<=')...
                       ||strcmp(waitfor_operator,'==')||strcmp(waitfor_operator,'>')||strcmp(waitfor_operator,'>='))
                       %TODO ERROR HANDLER
                    end

                    % In Matlab, Not Equals is "~=" rather than "!="
                    if(strcmp(waitfor_operator, '!='))
                      waitfor_operator = '~=';
                    end

                    [index, machine] = TestGUI('findReadIndex',handles, waitfor_var);

                    if index == -1
                        %TODO ERROR HANDLER
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.msg            = ['Signal ' waitfor_var ' not found in signal list.'];
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
                    elseif obj.userData.varTypes(index) == 2
                        %TODO ERROR HANDLER
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.msg            = [waitfor_var ' is a parameter; do not use with WAITFOR.'];
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
                    elseif obj.userData.varTypes(index) == 3
                        %TODO ERROR HANDLER
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.msg            = [waitfor_var ' is a script variable; do not use with WAITFOR.'];
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
                    elseif obj.debugMode == 0
                        if obj.userData.varTypes(index) == 1
                            index = obj.userData.varIndexes(index);
                        else
                            index = obj.userData.varValues{index}.signal;
                        end

                        % Either way the verification is valid at this point
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 1;

                        tic;
                        while(true)

                            if contains(machine,'tg6111')
                            currentVal = getsignal(handles.tg6111,index);
                            else
                               currentVal = getsignal(handles.tg6112,index); 
                            end

                            if eval([num2str(currentVal) waitfor_operator waitfor_num])
                                %TODO LOG FILE
                                % log waitfor acceptance value and final wait time
                                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_list(test_report_list{report_idx}.idx.waitfor) = toc*1000;
                                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_val_list(test_report_list{report_idx}.idx.waitfor) = currentVal;

                                % verification passes
                                test_report_list{report_idx}.total_pass = test_report_list{report_idx}.total_pass + 1;
                                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = true;
                                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value   = currentVal;
                                break;
                            end

                            if (waitfor_useTimeout == 1)
                                if (toc*1000 >= waitfor_timeout)
            %                         %TODO ERROR HANDLER
                                    % log that a timeout error occurred
                                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.waitfor_list(test_report_list{report_idx}.idx.waitfor) = -1; % Timeout Error

                                    % verification fails
                                    test_report_list{report_idx}.total_fail = test_report_list{report_idx}.total_fail + 1;
                                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
                                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value   = currentVal;
                                    break;
                                end
                            end

                            % Allow events to be processed
                            pause(0.001);
                        end
                    end
                end

            test_report_list{report_idx}.idx.waitfor = test_report_list{report_idx}.idx.waitfor + 1;
            test_report_list{report_idx}.idx.verify = test_report_list{report_idx}.idx.verify + 1;
            outputArg = true;
        end
    end
end