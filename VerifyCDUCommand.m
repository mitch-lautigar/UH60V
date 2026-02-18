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

classdef VerifyCDUCommand
    %VerifyCDUCommand Conversion of CR_VerifyCDU.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = VerifyCDUCommand(obj, varargin)
            variableTwo, variableThree, variableFour, variableFive, variableSix, variableSeven, variableEight, test_report_list, report_idx, handles)
          outputArg = false;    
            test_report_list{report_idx}.total_verify =  test_report_list{report_idx}.total_verify + 1;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}                = verify_type;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.type           = 3;            % CDU type
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.line = test_report_list{report_idx}.lineNumber;

            % link all unconsumed requirement structures to this action
            for i = test_report_list{report_idx}.idx.reqt_consumed : test_report_list{report_idx}.idx.reqt-1
                SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{i};
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS{end+1} = SRS;
            end
            % mark these requirements as consumed now
            test_report_list{report_idx}.idx.reqt_consumed = test_report_list{report_idx}.idx.reqt;

            % default values in case we hit an error
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_value = '';
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value = '';

            if length(match) ~= 8
                myError(handles.logfile, depth, ['Error, Incorrect number of arguments in call "' command '"']);
                cdu_error_message = ['Error, Incorrect number of arguments in call'];
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.comment = cdu_error_message;
                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
            else
                cdu_error = 0;
                cdu_error_message = [];
                cdu_row      = str2double(variableTwo);
                cdu_col      = str2double(variableThree);
                cdu_text     = ParseCDUText(variableFour);

                switch lower(variableFive)
                    case {'large','lg','l'}
                        cdu_size = 1;   % large size
                    case {'small','sm','s'}
                        cdu_size = 0;   % small size
                    otherwise
                        cdu_error = 1;
                        cdu_error_message=['invalid size ' variableFive ' for verifyCDU command.'];
                end

                switch lower(variableSix)
                    case {'black','b'}
                        cdu_color = 0;
                    case {'cyan','c'}
                        cdu_color = 1;
                    case {'red','r'}
                        cdu_color = 2;
                    case {'yellow','y'}
                        cdu_color = 3;
                    case {'green','g'}
                        cdu_color = 4;
                    case {'magenta','m'}
                        cdu_color = 5;
                    case {'amber','a'}
                        cdu_color = 6;
                    case {'white','w'}
                        cdu_color = 7;
                    otherwise
                        cdu_error = 1;
                        cdu_error_message=['invalid color ' variableSix ' for verifyCDU command.'];
                end

                switch lower(variableSeven)
                    case {'normal','nrm','n'}
                        cdu_option = 0;
                    case {'reverse','rev','r'}
                        cdu_option = 16;
                    case {'underline','und','u'}
                        cdu_option = 32;
                    case {'outline','out','o'}
                        cdu_option = 64;
                    case {'cupped','cup','c'}
                        cdu_option = 128;
                    otherwise
                        cdu_error = 1;
                        cdu_error_message=['invalid option ' variableSeven ' for verifyCDU command.'];
                end

                switch lower(variableEight)
                    case {'cdu1','cdu_copilot'}
                        cdu_num = 1;
                    case {'cdu2','cdu_pilot'}
                        cdu_num = 2;
                    otherwise
                        cdu_error = 1;
                        cdu_error_message=['invalid CDU number ' variableEight ' for verifyCDU command.'];
                end

                if isnan(cdu_row)
                    cdu_error = 1;
                    cdu_error_message='invalid CDU row (NaN) for verifyCDU command.';
                else if (cdu_row < 1 || cdu_row > 21 || mod(cdu_row,1) ~= 0)
                        cdu_error = 1;
                        cdu_error_message='invalid CDU row value (1:21) for verifyCDU command.';
                    end
                end

                if isnan(cdu_col)
                    cdu_error = 1;
                    cdu_error_message='invalid CDU col (NaN) for verifyCDU command.';
                else if (cdu_col < 1 || (cdu_col > 21 && cdu_size == 1) || (cdu_col > 27 && cdu_size == 0) || mod(cdu_col,1) ~= 0)
                        cdu_error = 1;
                        cdu_error_message='invalid CDU col value (1:21 for large text, 1:27 for small text) for verifyCDU command.';
                    else if (cdu_col < 1 || (cdu_col + length(cdu_text) - 1 > 21 && cdu_size == 1) || (cdu_col + length(cdu_text) - 1 > 27 && cdu_size == 0))
                            cdu_error = 1;
                            cdu_error_message='CDU text overflows column length (1:21 for large text, 1:27 for small text) for verifyCDU command.';
                        end
                    end
                end

                if (cdu_text == -1)
                    cdu_error = 1;
                    cdu_error_message='invalid CDU text special character for verifyCDU command.';
                else if (length(cdu_text) < 1)
                        cdu_error = 1;
                        cdu_error_message='no CDU text for verifyCDU command.';
                    end
                end

                test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.variable_name  = variableFour;
                if cdu_error == 0
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.comment        = ['row ' num2str(cdu_row) ' col ' num2str(cdu_col) ' : '];

                    cdu_verify_error = 0;
                    cdu_option = cdu_color + cdu_option;
                    if cdu_num == 1
                        cdu_string_base = 'CDU_1_';
                    else
                        cdu_string_base = 'CDU_2_';
                    end
                    if cdu_size == 0
                        cdu_string_base = [cdu_string_base 'SmallBuffer_'];
                    else
                        cdu_string_base = [cdu_string_base 'LargeBuffer_'];
                    end

                    currentString = '';
                    for i = 1:length(cdu_text)
                        cdu_string_attributes = [cdu_string_base 'Row' num2str(cdu_row) '_Col' num2str(cdu_col+i-1) '_Attributes'];
                        cdu_string_text       = [cdu_string_base 'Row' num2str(cdu_row) '_Col' num2str(cdu_col+i-1) '_Text'];

                        [index_attributes, machineAtt] = TestGUI('findReadIndex',handles, cdu_string_attributes);
                        [index_text, machineText]      = TestGUI('findReadIndex',handles, cdu_string_text);
                        if (index_attributes == -1 || index_text == -1)
                            myError(handles.logfile,depth,['error finding read index for verifyCDU command.']);
                            cdu_verify_error = 1;
                            break;
                        else if (obj.userData.varTypes(index_attributes) ~= 1 || obj.userData.varTypes(index_text) ~= 1)
                                myError(handles.logfile,depth,['error finding read index for verifyCDU command.']);
                                cdu_verify_error = 1;
                                break;
                            end
                        end
                        if contains(machineText,'tg6111')
                            currentString = [currentString char(getsignal(handles.tg6111,obj.userData.varIndexes(index_text)))];
                        else
                            currentString = [currentString char(getsignal(handles.tg6112,obj.userData.varIndexes(index_text)))];
                        end
                        if contains(machineAtt,'tg6111')
                            currentAttributes = getsignal(handles.tg6111,obj.userData.varIndexes(index_attributes));
                        else
                            currentAttributes = getsignal(handles.tg6112,obj.userData.varIndexes(index_attributes));
                        end
                        if currentAttributes ~= cdu_option
                            % cdu options mismatch
                            cdu_verify_error = 2;
                            errorAttribute = currentAttributes;
                        end
                    end

                    % make a modified string that takes wildcards (2048) into account
                    currentStringModified = currentString;
                    idxs = find(cdu_text == char(255));
                    currentStringModified(idxs) = char(255);
                    if ~strcmp(currentStringModified,cdu_text)
                        cdu_verify_error = 3;
                    end

                    % when generating a test report, report generator will crash if
                    % given special ascii characters so we need to replace them
                    % with the identifiers we have specified
                    currentString = ReverseParseCDUText(currentString);

                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 1;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.expected_value = variableFour;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.actual_value = currentString;

                    comment = '';
                    switch cdu_verify_error
                        case 0
                            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = true;
                            comment = ['Expected "' variableFour '" found "' currentString '"'];
                        case 1
                            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
                            comment = ['verifyCDU error: couldn''t find a read index - please report this issue to VanAntwerp'];
                        case 2
                            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
                            comment = ['Mismatched CDU options: expected 0x' dec2hex(cdu_option) ' found 0x' dec2hex(errorAttribute)];
                        case 3
                            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
                            comment = ['Mismatched CDU text: expected "' variableFour '" found "' currentString '"'];
                        otherwise
                            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
                            comment = 'Internal verifyCDU error: please report this issue to VanAntwerp';
                    end
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.comment = [test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.comment comment];
                else
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.comment = cdu_error_message;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 0;
                end
            end

            if (test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid == 1 &&...
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed == true)
                test_report_list{report_idx}.total_pass = test_report_list{report_idx}.total_pass + 1;
            else
                test_report_list{report_idx}.total_fail = test_report_list{report_idx}.total_fail + 1;
            end
            test_report_list{report_idx}.idx.verify = test_report_list{report_idx}.idx.verify + 1;
            outputArg = true;
            
        end
            
    end    
end
