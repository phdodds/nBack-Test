function [ ] = recordResults( TestVect, n_Number, timing, SubjectLastName, response, LureVect, TestLength, NbrTargets, NbrLures, NoUserResponse)
%recordResults calculates the results of the user n-Back test, formats
%them, and sends them to a text file in the results folder.
%   Detailed explanation goes here

AnswerVect = zeros(1, length(TestVect)-3); %Create answer sheet
UserScore = zeros(1, length(AnswerVect)); %create user score matrix
LureCheckVect = zeros(1, length(AnswerVect));
TestTime = num2str(fix(clock)); %record the test time
LureVectCounter = 1;


%% FIND CORRECT ANSWERS AND PLACE THEM IN THE ANSWER VECTOR
for idx = 4:length(TestVect)
   if  TestVect(idx) == TestVect(idx-n_Number)
       AnswerVect(idx-3) = 1;
   end
   
   check = ismember(idx, LureVect);
   
   if check == 1
       LureCheckVect(idx-3) = 'Y';
   else
       LureCheckVect(idx-3) = 'N';
   end
   
   
end

if NoUserResponse > 0
    for idx = 1:length(NoUserResponse)
        response = [response(1:NoUserResponse(idx)-1) 2 response(NoUserResponse(idx)+1:end)];
        timing = [timing(1:NoUserResponse(idx)-1) 3.000 timing(NoUserResponse(idx)+1:end)];
    end
end

%% CHECK USER RESPONSE AGAINST THE SCORE SHEET
for ScoreIdx = 1:length(AnswerVect)
   if response(ScoreIdx) == AnswerVect(ScoreIdx) %Check user response against answer sheet
       UserScore(ScoreIdx) = 1;
   else
       UserScore(ScoreIdx) = 0;
   end
end


%% CALCULATE RESULTS
 clc; 
 PercentCorrect = sum(UserScore)/length(UserScore)*100; %caculate percent correct
 AvgResponseTime = sum(timing)/length(timing); %calculate average time in seconds
 
 
 DataVect = [timing; response; AnswerVect; UserScore; LureCheckVect;];
 
 fileID = fopen(strcat(SubjectLastName,'Results.txt'), 'a+');%Create Text File for results 
 fprintf(fileID,'Subject Last Name: %s\r\n', SubjectLastName); %Record subject's last name
 fprintf(fileID, 'Test Date and Time (Y/M/D/H/M/S): %s\r\n', TestTime);
 fprintf(fileID,'\r\n');
 fprintf(fileID, 'Test Length: %u\r\n', TestLength);
 fprintf(fileID, 'Number of Targets: %u\r\n', NbrTargets);
 fprintf(fileID, 'Number of Lures: %u\r\n', NbrLures);
 fprintf(fileID,'\r\n');
 fprintf(fileID, '%s  ', 'Timing (s)','User Resp.','Correct Resp.','Result','Lure (Y/N)');
 fprintf(fileID, '\r\n');
 fprintf(fileID, '%4.3f %7u %11u %14u %7s \r\n', DataVect  );
 fprintf(fileID, '\r\n');
 fprintf(fileID, 'Percent Correct: %6.3f\r\n', PercentCorrect);
 fprintf(fileID, 'Average Response Time (s): %4.3f \r\n', AvgResponseTime');
 fprintf(fileID, '\r\n');
 fprintf(fileID, '\r\n');
 fprintf(fileID, '\r\n');
 
 fclose(fileID);

end

%%
% Peter Dodds
% Rensselear Polytechnic Institute
% M.S. Architectural Acoustics - 2015
