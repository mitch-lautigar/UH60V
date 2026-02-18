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

classdef CommentCommand
    %%CommentCommand Conversion of ';'
    
    properties
      output_data = [];
      input_data  = [];
      input_obj  = [];
    end
    
    methods
        %examine variable
        function obj = str_convert(obj)
           
            obj.output_data = strjoin(['% Line Number',obj.input_data(1),' -- ',string(obj.input_data(3:end))]);
        end
        function [obj] = CommentCommand(obj)
            
           
        end
    end
end