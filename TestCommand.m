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

classdef TestCommand
    %TestCommand Conversion of CR_Test.m
    
    properties
        debugMode = false;
        indata = [];
        outdata = [];
    end
    
    methods
        %examine variable
        function [obj] = TestCommand(obj)
              
        end
        function [obj] = Testcommandrun(obj)
                  obj.outdata = [strjoin(["% Line ",obj.indata(1),...
                  " -- Test Command"],""); ... %end 1
                  strjoin(["%",obj.indata(2:3)]," ");...
                  strjoin(["pkgObj.recordData('command',","'",...
                  strjoin(obj.indata(2:3)," "),"'",", ",...
                  obj.indata(1),");"],"");...%end 3
                  strjoin(["pkgObj.recordData('Test',",...
                  strjoin(obj.indata(3)," "),");"],"")];%end 4
        end
    end
end