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
%   17 APR 2022 - Mitch Lautigar, CCDC AVMC, 
%                 mitchell.a.lautigar.ctr@army.mil
%       * Initial implementation' 
%

classdef MatlabCMDCommand
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    

    methods
        function [outputStr, errorFlag] = matlab_cmd(command, varargin)
            if strcmpi(command,'MATLAB_CMD')
                num_output = varargin(2);
                output_args = varargin(3);
                num_input = varargin(4);
                input_args = varargin(5);
                if (num_output ~= length(output_args)) || ...
                        (num_input ~= length(output_args))
                    errorFlag = 1;
                else
                    outputStr = ['[', strjoin(output_args,','),...
                        '] = ',string(varargin(1)),...
                        '(',strjoin(input_args,','),')'];
                end
            else
                errorFlag = 1;
            end
        end

        
    end
end