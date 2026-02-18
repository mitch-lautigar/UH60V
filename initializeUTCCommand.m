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

classdef initializeUTCCommand
    %initializeUTCCommand Conversion of CR_initializeUTCTime.m
    
    properties
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = initializeUTCCommand(obj, varargin)
            dataTableObj, handles, userData
            outputArg = false;
        % First initialize the DD values we will need
            EGIAllIxs = [];
            EGIStrs = {
                        'EGI_1_UTC_Time_Propagate_Enable'
                        'EGI_1_UTC_Time_Hours_First_Digit'
                        'EGI_1_UTC_Time_Hours_Second_Digit'
                        'EGI_1_UTC_Time_Minutes_First_Digit'
                        'EGI_1_UTC_Time_Minutes_Second_Digit'
                        'EGI_1_UTC_Time_Seconds_First_Digit'
                        'EGI_1_UTC_Time_Seconds_Second_Digit'
                        'EGI_1_UTC_Day_of_Year_First_Digit'
                        'EGI_1_UTC_Day_of_Year_Second_Digit'
                        'EGI_1_UTC_Day_of_Year_Third_Digit'
                        'EGI_1_UTC_Calendar_Year_1st_Digit'
                        'EGI_1_UTC_Calendar_Year_2nd_Digit'
                        };
            EGIVarNames      = searchVar(handles,EGIStrs,1);
            [~,~,~,EGIIxs] = getValue(handles,EGIVarNames);
            EGIAllIxs = [EGIAllIxs EGIIxs];

            EGIStrs = {
                        'EGI_2_UTC_Time_Propagate_Enable'
                        'EGI_2_UTC_Time_Hours_First_Digit'
                        'EGI_2_UTC_Time_Hours_Second_Digit'
                        'EGI_2_UTC_Time_Minutes_First_Digit'
                        'EGI_2_UTC_Time_Minutes_Second_Digit'
                        'EGI_2_UTC_Time_Seconds_First_Digit'
                        'EGI_2_UTC_Time_Seconds_Second_Digit'
                        'EGI_2_UTC_Day_of_Year_First_Digit'
                        'EGI_2_UTC_Day_of_Year_Second_Digit'
                        'EGI_2_UTC_Day_of_Year_Third_Digit'
                        'EGI_2_UTC_Calendar_Year_1st_Digit'
                        'EGI_2_UTC_Calendar_Year_2nd_Digit'
                        };
            EGIVarNames      = searchVar(handles,EGIStrs,1);
            [~,~,~,EGIIxs] = getValue(handles,EGIVarNames);
            EGIAllIxs = [EGIAllIxs EGIIxs];

            % Now set the values
            c = datevec(now+7/24); % add 7 hours to convert to UTC time
            year = num2str(c(1)-2000,'%.2u');
            DOY = num2str(floor(datenum(c)) - datenum([c(1) 1 1 0 0 0]) + 1,'%.3u');
            hours = num2str(c(4),'%.2u');
            minutes = num2str(c(5),'%.2u');
            seconds = num2str(floor(c(6)),'%.2u');

            % Set the values for both EGIs
            values = str2double({hours(1) hours(2) minutes(1) minutes(2) seconds(1) seconds(2) DOY(1) DOY(2) DOY(3) year(1) year(2)});
            for offset = [0,length(EGIStrs)]
                setValue(handles,EGIAllIxs(offset+(2:12)),values);
            end

            % Set the propagate enable bits to 0
            for offset = [0,length(EGIStrs)]
                setValue(handles,EGIAllIxs(offset+1),0);
            end

            % Wait half a second to make sure the xPC has time for a tick
            pause(0.5);

            % Set the propagate enable bits to 1
            for offset = [0,length(EGIStrs)]
                setValue(handles,EGIAllIxs(offset+1),1);
            end
            outputArg = true;
        end
    end
end