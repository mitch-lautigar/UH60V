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

classdef OperatorCommand
    %OperatorCommand Conversion of CR_operator.m
    
    properties
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = operatorCommand(obj, varargin)
          if ~isequal(nargin,2)
            outputStr = sprintf('Error, Incorrect number of arguments in call.\n\tThere needs to be the variableTwo.');
            errorFlag = true;
          else
            variableTwo = varargin{1};
            errorFlag = false;
            if ~exist('showDialogs','var') || showDialogs==1
                modalDlg = variableTwo;
                modaldlg('String',modalDlg,'Type','Operator');
                outputStr = sprintf('Operator Command Success.');
            end
          end
        end
    end
end