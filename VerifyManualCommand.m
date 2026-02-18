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

classdef VerifyManualCommand
    %VerifyManualCommand Conversion of CR_VerifyManual.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = VerifyManualCommand(obj, varargin)
            test_report_list, report_idx
            outputArg = false;    
            % link all unconsumed requirement structures to this action
            SRS = {};
            for i = test_report_list{report_idx}.idx.reqt_consumed : test_report_list{report_idx}.idx.reqt-1
                SRS{end+1} = test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.reqt_list{i};
            end
            % mark these requirements as consumed now
            test_report_list{report_idx}.idx.reqt_consumed = test_report_list{report_idx}.idx.reqt;

            % populate the verifyManual SRS field and increment the pointer
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_manual_SRS{test_report_list{report_idx}.idx.verify_manual}.SRS = SRS;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.verify_manual_line{test_report_list{report_idx}.idx.verify_manual} = test_report_list{report_idx}.lineNumber;
            test_report_list{report_idx}.idx.verify_manual = test_report_list{report_idx}.idx.verify_manual + 1;
            outputArg = true;
        end
    end
end