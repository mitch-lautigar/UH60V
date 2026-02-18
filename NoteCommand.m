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

classdef NoteCommand
    %NoteCommand Conversion of CR_note.m
    
    properties
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = noteCommand(obj, varargin)
          if ~isequal(nargin,5)
            outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the handles, variableTwo, test report list, and report index.');
            errorFlag = true;
          else
            handles = varargin{1};
            variableTwo = varargin{2};
            test_report_list = varargin{3};
            report_idx = varargin{4};
            errorFlag = false;
            note = variableTwo;
            test_report_list{report_idx}.section_list{test_report_list{report_idx}.idx.section}.note_list{test_report_list{report_idx}.idx.note} = note;
            test_report_list{report_idx}.idx.note = test_report_list{report_idx}.idx.note + 1;
            try %#ok<TRYNC>
               if handles.speak
                   Speak(handles.speaker,note);
                   outputStr = sprintf('Note Command Success.');
               end
            end
          end
        end
    end
end