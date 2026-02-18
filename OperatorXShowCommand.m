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

classdef OperatorXShowCommand
    %OperatorXShowCommand Conversion of CR_operatorXShow.m
    
    properties
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = operatorXShowCommand(obj, varargin)
          if ~isequal(nargin,4)
            outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the handles, rest report list, and report index.');
            errorFlag = true;
          else
            handles = varargin{1};
            test_report_list = varargin{2};
            report_idx = varargin{3};
            errorFlag = false;
            if ~exist('showDialogs','var') || showDialogs==1
            user_response = modaldlg('Title',modalTitle,'String',modalDlg,'Type',modalType,'sound',~handles.speak);

                % pass / fail operator type - include results in report as a verify
                if strcmpi(modalType,'pfoperator')
                    test_report_list{report_idx}.total_verify =  test_report_list{report_idx}.total_verify + 1;

                    % Update test report variables
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}                = verify_type;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.type           = 1;            % operator P/F type
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.variable_name  = modalTitle;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.comment        = user_response{2};
            %         if test_report_list{report_idx}.idx.reqt == 1
            %           SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt};
            %         else
            %           SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{test_report_list{report_idx}.idx.reqt-1};
            %         end
            %         test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS = SRS;
                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.line = test_report_list{report_idx}.lineNumber;

                    % Determine PASS or FAIL
                    if strcmpi(user_response{1},'pass');
                      test_report_list{report_idx}.total_pass = test_report_list{report_idx}.total_pass + 1;
                      test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = true;
                    else
                      test_report_list{report_idx}.total_fail = test_report_list{report_idx}.total_fail + 1;
                      test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.passed = false;
                    end

                    % link all unconsumed requirement structures to this action
                    for i = test_report_list{report_idx}.idx.reqt_consumed : test_report_list{report_idx}.idx.reqt-1
                        SRS = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{i};
                        test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.SRS{end+1} = SRS;
                    end
                    % mark these requirements as consumed now
                    test_report_list{report_idx}.idx.reqt_consumed = test_report_list{report_idx}.idx.reqt;

                    test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_list{test_report_list{report_idx}.idx.verify}.valid = 1;
                    test_report_list{report_idx}.idx.verify = test_report_list{report_idx}.idx.verify + 1;
                    scriptVarsUpdated = true;
                    outputStr = sprintf('Operator X Show Command Success.');
                end
            end
          end
         end
    end
end