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

classdef Scall2Command
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Property1
    end

    methods
        function obj = Scall2Command(obj,varargin)
            x = dir();
            filename = varargin(1);
            file_array = [];
            for i = 1:length(x)
                if contains(x(i).name,filename,'IgnoreCase',1)
                    file_array = [file_array;...
                        x(i).name];
                end
            end
            if length(file_array) > 1
                [s,v] = listdlg('PromptString','Select a file:',...
                'SelectionMode','single',...
                'ListString', file_array);
                y = find(v==1);
                filerun = s(y);
            else
                filerun = filename;
            end
            if length(s(y)) > 1
                error('The world is now broken; congrats')
            end

        end
    end
end