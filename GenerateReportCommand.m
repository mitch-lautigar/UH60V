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

classdef GenerateReportCommand
    %GenerateReportCommand Conversion of CR_generatereport.m
    
    properties
        test_report_list = [];
        debugMode = false;
        userData = [];
        speedGoatName = "";
    end
    
    methods
        %examine variable
        function [outputStr, errorFlag] = generateReport(obj, varargin)
            openReportVariable, modelNameVariable, test_report_list, userData
            outputArg = false;

%-------------------------------------------------------------------------
% Description:
%   Generate a test report PDF file. This would normally be called at the
%   end of the script. Report will be formatted as follows:
%
%     * Title page containing the title of the report, the author of the
%       script, and the version of the script. These items are set with the
%       ÿtitleÿ, ÿauthorÿ, and ÿversionÿ commands.
%
%     * Results summary table containing the PASS/FAIL results of each
%       ÿverifyÿ command for each section.
%
%     * One or more sections. A new section is created each time the ÿ+ÿ
%       command is encountered. Each section is formatted as follows:
%
%       - Title of section that contains the time at which the commands
%         in the section took place.
%
%       - List of commands that were executed in this section.
%
%       - Table containing the PASS/FAIL results of each ÿverifyÿ command
%         in this section.
%
%       - Screenshots that were taken in this section.
%
%       - Screenshots that were taken in this section using the ÿscreenshotÿ command.
%
%       - Links to videos that were recorded in this section using the ÿvideoÿ command.
%
% Parameters:
%
%   1 (optional) boolean open_report OR string model_name
%     open_report: 0 = Do not open the report automatically. This is the default.
%                  1 = Open the report automatically.
%     model_name: model name without extension
%   2 (optional) string model_name
%                first parameter must be open_report
%
%   if no parameters are given, the model name is set to Total_xPC_SIM.mdl
%
% Examples:
%   generateReport
%   generateReport 1
%   generateReport test
%   generateReport 0 test
%
% Date -- Author -- Change Description
% ------- --------- ----------------------------------------------------
% 050216  VP        Change backup file extension from .m to .mat. This file
%                   contains the workpace variables and should be a .mat
%-------------------------------------------------------------------------

            try
            % --------------------------------------------------------------------
            % -uncomment these fields only for scripts run before 09/14/16 at 6pm-
            %     modelName = 'Total_xPC_SIM';
            %     modelVer = 'Model version : 1.3773';
            %     SimulinkCoderVer = 'Simulink Coder version : 8.5 (R2013b) 08-Aug-2013';
            %     CodedDate = 'C source code generated on : Wed Sep 07 23:07:49 2016';
            %     timeComplete = '08-Sep-2016 18:02:55';
            %     report_filename = 'RequirementTestsMVA_2016-09-08-180255';
            % --------------------------------------------------------------------

                if ~exist('PostProcessing')
                    % let's get all the stuff we need
                    modelName = handles.tg6111.Application;

                    % Get model info
                    % At the moment, this does not get the model on the xPC, but the one on
                    % The test machine, which is usually the same.
                    direc = pwd;

                    [XPCdir, ~, ~] = fileparts(which([modelName '.mldatx']));
                    if isempty(XPCdir)
                        modelName = handles.tg6111.Application;
                        [XPCdir, ~, ~] = fileparts(which([modelName '.mldatx']));
                    end
                    if isempty(XPCdir)
                        error('ERROR: unable to cd to model location!');
                    end

                    % throw an error if there's more than one location Total_xPC_SIM is found
                    % in the path
                    if strcmp(modelName, 'Total_xPC_SIM_6111')
                        [nModels, ~] = size(XPCdir);
                        if nModels > 1
                            error('ERROR: Total_xPC_SIM found in multiple path locations!');
                        end
                    end
                    cd(XPCdir);
                    [modelVer,SimulinkCoderVer,CodedDate] = getXPCModelVersionNumber([modelName '.mldatx']);
                    SimulinkCoderVer = SimulinkCoderVer(4:length(SimulinkCoderVer));
                    CodedDate = CodedDate(4:length(CodedDate));
                    modelVer = modelVer(4:length(modelVer));
                    cd(direc);
                    % test_report.modelVer = char(TEST_VERSION);  % Future implementation

                    timeComplete = datestr(now);

                    [~, script_file_name, ~] = fileparts(obj.test_report_list{report_idx}.script_file);
                    script_file_name = strrep(script_file_name, ' ', '_');
                    report_filename = sprintf('%s_%s', script_file_name, datestr(now, 'yyyy-mm-dd-HHMMSS'));

                    % and save the backup file for post processing
                    backupFile = ['Reportg6111enerator_Backup',datestr(now, 'yyyy_mm_dd_HHMMSS'),'.mat'];
                    save(backupFile)
                else
                    backupFile = ['Reportg6111enerator_Backup',datestr(now, 'yyyy_mm_dd_HHMMSS'),'_PostProcessed.mat'];
                    save(backupFile)
                end


                if ~exist('modelName');
                    compatibilityMode = 1;
                else
                    compatibilityMode = 0;
                end

                if ~obj.debugMode

                    open_report = '0';

                    try  %#ok<*TRYNC>
                        if handles.speak
                            Speak(handles.speaker,'Generating report');
                        end
                    end

                    if compatibilityMode == 1
                        modelName = 'some model name';
                    end

                    % Handle input parameters.  If the first input is a number, use it as
                    % the value for opening the report or not.
                    % If it is not a number, the Open Report option is not being used, set
                    % it to 0 and take the incoming parameter as the name of the model to
                    % report on.

                    modelName = modelNameVariable;
                    open_report = openReportVariable;

                    if exist('PostProcessing')
                        report_filename = [report_filename '_POST_PROCESSED'];
                    end

                    obj.test_report_list{report_idx}.file_name = report_filename;

                    % Export the structure needed by the test report to the base workspace
                    test_report = obj.test_report_list{report_idx};

                    % JC 19 Oct 2015 - remove hard-coded path to Total_xPC_SIM and made
                    %  modelName an optional input
                    test_report.modelName = modelName;

                    test_report.SimulinkCoderVer = SimulinkCoderVer;
                    test_report.CodedDate = CodedDate;
                    test_report.modelVer = modelVer;
                    test_report.timeComplete = timeComplete;

                    % Calculate Pass/Fail Results
                    totals = numel(test_report.section_list);
                    verify_count = 0;
                    verify_pass = 0;
                    video_count = 0;
                    verify_manual_count = 0; % total count of verify_manual commands
                    verify_manual_needed = 0; % count of all commands that need manual verification
                    ver_manual_count = 0; % count of verify_manual commands that were post-processed
                    ver_manual_pass = 0; % count of verify_manual commands that passed during post-processing
                    test_report.verify_reqs = 0;
                    screenshot_count = 0;
                    screenshot_verify_count = 0;
                    screenshot_verify_pass = 0;
                    video_verify_count = 0;
                    video_verify_pass = 0;
                    reqt_total_count = 0;
                    reqt_consumed_count = 0;
                    missing_reqs = {};
                    for dataindex = 1:totals
                        reqt_consumed_count = 0;
                        % screenshot and video counts are now the number of
                        % requirements associated with videos and screenshots
                        test_report.section_list{1,dataindex}.numScreenReqs = 0;
                        for screenshot_idx = 1:length(test_report.section_list{1,dataindex}.screenshot_SRS)
                            for srs_idx = 1:length(test_report.section_list{1,dataindex}.screenshot_SRS{screenshot_idx}.SRS)
                                if isfield(test_report.section_list{1,dataindex}.screenshot_SRS{screenshot_idx}.SRS{srs_idx},'pass')
                                    screenshot_verify_count = screenshot_verify_count + 1;
                                    if test_report.section_list{1,dataindex}.screenshot_SRS{screenshot_idx}.SRS{srs_idx}.pass == 1
                                        screenshot_verify_pass = screenshot_verify_pass + 1;
                                    end
                                else
                                    verify_manual_needed = verify_manual_needed + 1;
                                end
                            end
                            test_report.section_list{1,dataindex}.numScreenReqs = test_report.section_list{1,dataindex}.numScreenReqs + length(test_report.section_list{1,dataindex}.screenshot_SRS{screenshot_idx}.SRS);
                        end
                        screenshot_count = screenshot_count + test_report.section_list{1,dataindex}.numScreenReqs;
                        reqt_consumed_count = reqt_consumed_count + test_report.section_list{1,dataindex}.numScreenReqs;

                        % video requirements
                        test_report.section_list{1,dataindex}.numVideoReqs = 0;
                        for video_idx = 1:length(test_report.section_list{1,dataindex}.video_SRS)
                            for srs_idx = 1:length(test_report.section_list{1,dataindex}.video_SRS{video_idx}.SRS)
                                if isfield(test_report.section_list{1,dataindex}.video_SRS{video_idx}.SRS{srs_idx},'pass')
                                    video_verify_count = video_verify_count + 1;
                                    if test_report.section_list{1,dataindex}.video_SRS{video_idx}.SRS{srs_idx}.pass == 1
                                        video_verify_pass = video_verify_pass + 1;
                                    end
                                else
                                    verify_manual_needed = verify_manual_needed + 1;
                                end
                            end
                            test_report.section_list{1,dataindex}.numVideoReqs = test_report.section_list{1,dataindex}.numVideoReqs + length(test_report.section_list{1,dataindex}.video_SRS{video_idx}.SRS);
                        end
                        video_count = video_count + test_report.section_list{1,dataindex}.numVideoReqs;
                        reqt_consumed_count = reqt_consumed_count + test_report.section_list{1,dataindex}.numVideoReqs;

                        % verify type requirements
                        test_report.section_list{1,dataindex}.numVerifyReqs = 0;
                        for verify_idx = 1:length(test_report.section_list{1,dataindex}.verify_list)
                            test_report.section_list{1,dataindex}.numVerifyReqs = test_report.section_list{1,dataindex}.numVerifyReqs + length(test_report.section_list{1,dataindex}.verify_list{verify_idx}.SRS);
                        end
                        test_report.verify_reqs = test_report.verify_reqs + test_report.section_list{1,dataindex}.numVerifyReqs;
                        reqt_consumed_count = reqt_consumed_count + test_report.section_list{1,dataindex}.numVerifyReqs;

                        % verify manual requirements
                        for verify_manual_idx = 1:length(test_report.section_list{1,dataindex}.verify_manual_SRS)
                            for srs_idx = 1:length(test_report.section_list{1,dataindex}.verify_manual_SRS{verify_manual_idx}.SRS)
                                if isfield(test_report.section_list{1,dataindex}.verify_manual_SRS{verify_manual_idx}.SRS{srs_idx},'pass')
                                    ver_manual_count = ver_manual_count + 1;
                                    if test_report.section_list{1,dataindex}.verify_manual_SRS{verify_manual_idx}.SRS{srs_idx}.pass == 1
                                        ver_manual_pass = ver_manual_pass + 1;
                                    end
                                else
                                    verify_manual_needed = verify_manual_needed + 1;
                                end
                            end
                            verify_manual_count = verify_manual_count + length(test_report.section_list{1,dataindex}.verify_manual_SRS{verify_manual_idx}.SRS);
                            reqt_consumed_count = reqt_consumed_count + length(test_report.section_list{1,dataindex}.verify_manual_SRS{verify_manual_idx}.SRS);
                        end

                        % all requirements count - check that it's not default string
                        % (which indicates there are no reqt's)
                        if ~ischar(test_report.section_list{1,dataindex}.reqt_list{1})
                            reqt_total_count =  reqt_total_count + length(test_report.section_list{1,dataindex}.reqt_list);
                            for i = reqt_consumed_count+1 : length(test_report.section_list{1,dataindex}.reqt_list)
                                missing_reqs{end+1} = test_report.section_list{1,dataindex}.reqt_list{i};
                                missing_reqs{end}.section = dataindex;
                            end
            %                 missing_reqs = {missing_reqs{1:end} test_report.section_list{1,dataindex}.reqt_list{reqt_consumed_count+1:length(test_report.section_list{1,dataindex}.reqt_list)}};
                        end
                    end
                    verify_count = verify_count + obj.test_report_list{report_idx}.total_verify;
                    verify_pass  = verify_pass + obj.test_report_list{report_idx}.total_pass;

                    if(verify_count == 0)
                        test_report.verify_result_text = 'N/A';
                    elseif(verify_count == verify_pass)
                        test_report.verify_result_text = 'PASS';
                    end

                    if(video_count > 0)
                        test_report.video_exist = 'YES';
                    end

                    if(screenshot_count > 0)
                        test_report.screenshot_exist = 'YES';
                    end

                    if(verify_manual_count > 0)
                        test_report.verify_manual_exist = 'YES';
                    end

                    % new test report subtitles
                    if ( ~exist('PostProcessing') || verify_manual_needed > 0 )
                        test_report.overall = [num2str(verify_pass + screenshot_verify_pass + video_verify_pass + ver_manual_pass) ' passed, ' ...
                            num2str( (verify_count-verify_pass) + (screenshot_verify_count-screenshot_verify_pass) + (video_verify_count-video_verify_pass) + (ver_manual_count-ver_manual_pass)) ' failed, ' ...
                            num2str(verify_manual_needed) ' manual verifications'];
                    else
                        test_report.overall = [num2str(verify_pass + screenshot_verify_pass + video_verify_pass + ver_manual_pass) ' passed, ' ...
                            num2str( (verify_count-verify_pass) + (screenshot_verify_count-screenshot_verify_pass) + (video_verify_count-video_verify_pass) + (ver_manual_count-ver_manual_pass)) ' failed'];
                    end

                    if (reqt_total_count - screenshot_count - video_count - test_report.verify_reqs - verify_manual_count > 0)
                        test_report.overall = [test_report.overall ', ' num2str(reqt_total_count - screenshot_count - video_count - test_report.verify_reqs - verify_manual_count) ...
                            ' unverified'];
                    end

                    if compatibilityMode == 1
                        test_report.modelVer = 'test model ver';
                        test_report.SimulinkCoderVer = 'test simulink coder ver';
                        test_report.CodedDate = 'test coded date';
                        test_report.timeComplete = datestr(now);
                    end

                    % wrap lines by adding in newline characters where needed
                    for dataindex = 1:totals
                        for commandindex = 1:numel(test_report.section_list{1,dataindex}.command_text_list)
                            commTextIn = test_report.section_list{1,dataindex}.command_text_list{commandindex};
                            commTextOut = '';
                            commLenRem = length(commTextIn);
                            while(1)
                                if commLenRem > 90
                                    commTextOut = [commTextOut commTextIn(1:87) sprintf('...\r\n       ')];
                                    commTextIn = commTextIn(88:end);
                                    commLenRem = commLenRem - 87;
                                else
                                    commTextOut = [commTextOut commTextIn];
                                    break;
                                end
                            end
                            test_report.section_list{1,dataindex}.command_text_list{commandindex} = commTextOut;
                        end
                    end

                    % wrap comments for verifies as well
                    for dataindex = 1:totals
                        for verifyindex = 1:numel(test_report.section_list{1,dataindex}.verify_list)
                            commTextIn = test_report.section_list{1,dataindex}.verify_list{verifyindex}.comment;
                            commTextOut = '';
                            commLenRem = length(commTextIn);
                            while(1)
                                if commLenRem > 87
                                    commTextOut = [commTextOut commTextIn(1:84) sprintf('...\r\n       ')];
                                    commTextIn = commTextIn(85:end);
                                    commLenRem = commLenRem - 84;
                                else
                                    commTextOut = [commTextOut commTextIn];
                                    break;
                                end
                            end
                            test_report.section_list{1,dataindex}.verify_list{verifyindex}.comment = commTextOut;
                        end
                    end

                    assignin('base', 'test_report', test_report)

                    % Generate report based on the contents of the 'test_report' workspace structure.
                    report xpc_testing_gui_report_template;

                    % If the user desires, open the report
                    if(open_report == '1')

                        generated_report_path = [report_filename '.pdf'];

                        % Use LaunchApp.ahk to open the report to avoid the DOS prompt
                        autohotkey_exe = which('AutoHotkey.exe');
                        launch_app_script = which('LaunchApp.ahk');
                        launch_pdf_args = sprintf('"%s" "%s" "%s"', ...
                            autohotkey_exe, launch_app_script, generated_report_path);
                        [error_code, ~] = system(launch_pdf_args);

                        if(error_code == 1)
                            error('Not enough arguments for LaunchApp!');
                        elseif(error_code == 2)
                            error(['LaunchApp was not given a valid application path! (' generated_report_path ')']);
                        elseif(error_code == 3)
                            error('LaunchApp was given a bad flag!');
                        elseif(error_code ~= 0)
                            error('LaunchApp encountered unknown error!');
                        end
                    end
                end

            catch e
                if ~exist('PostProcessing')
                    %TODO ERROR HANDLER
                else
                    error(['generateReport: Error, ######### ' e.message ' #########']);
                end
            end
        end
    end
end
