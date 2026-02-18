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

classdef ScreenshotCommand
    %ScreenshotDeleteCommand Conversion of CR_screenshotDelete.m
    
    properties
        debugMode = false;
        screens = [];
        outcmd = [];
        instr = [];
    end
    
    methods
        %examine variable
        function [obj] = ScreenshotCommand(obj)

        end
        function [obj] = screenshot_run(obj)
            obj.outcmd = [strjoin(["% Line ",obj.instr(1)," -- Screenshot Command"],"");...
                strjoin(["%",obj.instr(2:3)]," ");... end
                strjoin(["pkgObj.recordData('command',",...
                "'",obj.instr(2:3),"', '",obj.instr(1),"');"]," ");... end
                strjoin(["screens = {'",obj.instr(3),"'};"],"");... end
                "for ii = 1:numel(screens)";...end
                "   files{ii} = pkgObj.createFilename(pkgObj.test_report_list{pkgObj.report_idx}.script_file,...";...
                "   pkgObj.section_idx,...";...
                "   pkgObj.test_report_list{pkgObj.report_idx}.idx.screenshot,...";...
                "   screens{ii},'png');";...
                "end";...
                "getScreens('MC',1,'screen',screens,'file',files);";...
                "pkgObj.recordData('screenshot',screens, files);"];
        end
    end
end