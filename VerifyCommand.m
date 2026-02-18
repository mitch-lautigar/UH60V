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

classdef VerifyCommand
    %VerifyCommand Conversion of CR_Verify.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = VerifyCommand(obj, varargin)
            variableTwo, variableThree, variableFour, test_report_list, report_idx, handles
          outputArg = false;    
          var_name    = variableTwo;
          lower_bound = variableThree;
          upper_bound = variableFour;

          [index, machine] = TestGUI('findReadIndex', handles, var_name);

          if(index == -1)
            test_report_list{report_idx}.total_verify =  test_report_list{report_idx}.total_verify + 1;

            % Update test report variables
            var_name = strcat(var_name,' [DOES NOT EXIST]');
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}                = verify_type;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.variable_name  = var_name;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value   = 0;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_lower = 1;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_upper = 1;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.msg            = 'VARIABLE DOES NOT EXIST';
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
        %     if test_report_list{report_idx}.idx.reqt == 1
        %       SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt};
        %     else
        %       SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt-1};
        %     end
        %     test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS = SRS;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.line = test_report_list{report_idx}.lineNumber;
            test_report_list{report_idx}.total_fail = test_report_list{report_idx}.total_fail + 1;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
            test_report_list{report_idx}.idx.verify = test_report_list{report_idx}.idx.verify + 1;
            scriptVarsUpdated = true;
            myError(handles.logfile, depth, ['verify: Error, "' var_name '" is not valid variable!']);
          elseif (obj.debugMode == 0)
            % Get the value of the variable to verify
            if obj.userData.varTypes(index) == 1
                if contains(machine,'tg6111')
                    value = getsignal(handles.tg6111,obj.userData.varIndexes(index));
                else
                    value = getsignal(handles.tg6112,obj.userData.varIndexes(index));   
                end
            elseif obj.userData.varTypes(index) == 2
                if contains(machine,'tg6111')
                    value = getparam(handles.tg6111,obj.userData.varIndexes(index));
                else
                    value = getparam(handles.tg6112,obj.userData.varIndexes(index));
                end
            elseif obj.userData.varTypes(index) == 3
              value = obj.userData.varValues{index};
            else
                if contains(machine,'tg6111')
                    value = getsignal(handles.tg6111, obj.userData.varValues{index}.signal);
                else
                    value = getsignal(handles.tg6112, obj.userData.varValues{index}.signal);
                end
            end				

            test_report_list{report_idx}.total_verify =  test_report_list{report_idx}.total_verify + 1;

            % Update test report variables
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}                = verify_type;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.variable_name  = var_name;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value   = value;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_lower = lower_bound;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_upper = upper_bound;
        %     if test_report_list{report_idx}.idx.reqt == 1
        %       SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt};
        %     else
        %       SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt-1};
        %     end
        %     test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS = SRS;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.line = test_report_list{report_idx}.lineNumber;

            % Determine PASS or FAIL
            if((value >= str2double(lower_bound)) && (value <= str2double(upper_bound)))
              test_report_list{report_idx}.total_pass = test_report_list{report_idx}.total_pass + 1;
              test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = true;
            else
              test_report_list{report_idx}.total_fail = test_report_list{report_idx}.total_fail + 1;
              test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
            end

            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 1;
            test_report_list{report_idx}.idx.verify = test_report_list{report_idx}.idx.verify + 1;
            scriptVarsUpdated = true;

            % link all unconsumed requirement structures to this action
            for i = test_report_list{report_idx}.idx.reqt_consumed : test_report_list{report_idx}.idx.reqt-1
                SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{i};
                % note that the verify index has already been incremented here
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify-1}.SRS{end+1} = SRS;
            end


            % mark these requirements as consumed now (even if we have an error)
            test_report_list{report_idx}.idx.reqt_consumed = test_report_list{report_idx}.idx.reqt;
            outputArg = true;
          end
          
          
        end
    end
end