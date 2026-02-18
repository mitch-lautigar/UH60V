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

classdef SubTestCommand
    %SubTestCommand Conversion of CR_subTest.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = SubTestCommand(obj, varargin)
            variableTwo, test_report_list, report_idx, handles
            outputArg = false;    
            if ~strcmp(handles.tg6111.Status,'running')
                    %TODO ERROR HANDLER
            else
                test_report_list{report_idx}.testTitleIndex(test_report_list{report_idx}.cur_section_time).subTestTitle{test_report_list{report_idx}.test(test_report_list{report_idx}.cur_section_time).subtest} = variableTwo;
                test_report_list{report_idx}.test(test_report_list{report_idx}.cur_section_time).subtest = test_report_list{report_idx}.test(test_report_list{report_idx}.cur_section_time).subtest + 1;
                try %#ok<TRYNC>
                   if handles.speak
                       Speak(handles.speaker, variableTwo);
                       outputArg = true;
                   end
                end
            end
        end
    end
end