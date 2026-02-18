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

classdef DataPageCommand
    %DataPageCommand Conversion of CR_datapage.m
    %   CR_datapage.m
    
    properties
    end
    
    methods
        
        function [outputStr, errorFlag, userData] = showDataPage(obj, varargin)
           if ~isequal(nargin,4)
                outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the match, handles, and script_fid variable.');
                errorFlag = true;
                userData = [];
           else
            match = varargin{1};
            handles = varargin{2};
            script_fid = varargin{3};
            
            scriptdatadlg('Match', match, 'Handles', handles, 'Fid', script_fid);
            userData = get(handles.figure1, 'UserData');
            outputStr = sprintf('Success - Data Page Command.');
            errorFlag = false;
           end
        end
    end
end