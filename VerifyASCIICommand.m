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

classdef VerifyASCIICommand
    %VerifyASCIICommand Conversion of CR_VerifyASCII.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = VerifyASCIICommand(obj, varargin)
            dataTableObj, userData, variableTwo, variableThree, variableFour, test_report_list, report_idx, handles
          outputArg = false;    
            if (obj.debugMode == 0)
            match = [variableTwo, variableThree, variableFour];
            var_name    = variableTwo;
            asciiCode = str2double(variableThree);
            expectedStr = variableFour;
            for i = 5:length(match)
                expectedStr = [expectedStr,' ',match{i}];
            end
            expectedStr = uint8(expectedStr);
            obj.userData = get(handles.figure1,'obj.userData');
            if any(cellfun(@(x) ~isempty(x),regexp(obj.userData.varNames,['^{FRZ} ',var_name])))
                %The value is in a Freeze Ascii and can't be immediately treated as an array.
                [index, machine] = TestGUI('findReadIndex',handles, var_name);
                if contains(machine, 'tg6111')
                    values = getsignal(handles.tg6111, obj.userData.varValues{index}.signal);
                else
                    values = getsignal(handles.tg6112, obj.userData.varValues{index}.signal);
                end

                ok = 1;

                if length(values)>length(expectedStr)
                    expectedStr = [expectedStr,ones(1,numel(values)-numel(expectedStr))*asciiCode];
                elseif length(values)<length(expectedStr)
                    ok = 0;
                    var_name = strcat(var_name,' [ARRAY VARIABLE LENGTH EXCEEDED]');
                end



                if(index == -1)
                    var_name = [var_name,' [DOES NOT EXIST]'];
                    ok = 0;
                end

            else
                [names, values] = findArrayValues(handles, var_name);

                ok = 0;
                if isempty(names)
                    var_name = strcat(var_name,' [ARRAY VARIABLES DO NOT EXIST]');
                elseif isempty(values)
                    var_name = strcat(var_name,' [ARRAY VALUES DO NOT EXIST]');
                else
                    ok = 1;
                end
            end
            if ~ok
                test_report_list{report_idx}.total_verify =  test_report_list{report_idx}.total_verify + 1;

                % Update test report variables
                var_name = strcat(var_name,' [DOES NOT EXIST]');
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}                = verify_type;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.variable_name  = var_name;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value   = 0;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_lower = 1;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_upper = 1;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.msg            = 'ARRAY VARIABLES DO NOT EXIST';
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
                if test_report_list{report_idx}.idx.reqt == 1
                    SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt};
                else
                    SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt-1};
                end
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS = SRS;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.line = test_report_list{report_idx}.lineNumber;
                test_report_list{report_idx}.total_fail = test_report_list{report_idx}.total_fail + 1;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
                test_report_list{report_idx}.idx.verify = test_report_list{report_idx}.idx.verify + 1;
                scriptVarsUpdated = true;
                %TODO ERROR HANDLER

            else

                for i = 1:length(expectedStr)

                    test_report_list{report_idx}.total_verify =  test_report_list{report_idx}.total_verify + 1;

                    % Update test report variables
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}                = verify_type;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.variable_name  = var_name;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value   = [char(uint8(values(i))),'(',num2str(values(i)),')'];
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_lower = [char(expectedStr(i)),'(',num2str(expectedStr(i)),')'];
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_upper = [char(expectedStr(i)),'(',num2str(expectedStr(i)),')'];
                    if test_report_list{report_idx}.idx.reqt == 1
                        SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt};
                    else
                        SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt-1};
                    end
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS = SRS;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.line = test_report_list{report_idx}.lineNumber;

                    % Determine PASS or FAIL
                    if (uint8(values(i)) == expectedStr(i))
                        test_report_list{report_idx}.total_pass = test_report_list{report_idx}.total_pass + 1;
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = true;
                    else
                        test_report_list{report_idx}.total_fail = test_report_list{report_idx}.total_fail + 1;
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
                    end

                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 1;
                    test_report_list{report_idx}.idx.verify = test_report_list{report_idx}.idx.verify + 1;
                    scriptVarsUpdated = true;
                end
            
            end
            
            end
    
        end
    end
end