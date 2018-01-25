function [ TestVect, LureVect ] = NbackGeneratorFunction( TestLengthInput, LureLevelInput, NbrTargetsInput, n_NumberInput, NbrLuresInput, TrialTypeAmountInput)

tic; %begin clock
%% INITIALIZE VARIABLES
TestLength = TestLengthInput+3; %length of n-Back test including 3 lead in stimui
n_Number = n_NumberInput; %n-Back number
NbrTargets = NbrTargetsInput; %number of targets in test
LureLevel = LureLevelInput; %Lure Level; 0 = No lures; 1 = Lures at n-1; 2 = Lures at n+1; 3 = Lures at n-1 and n+1;
NbrLures = NbrLuresInput; %Number of lures present in the test
TrialTypeAmount = TrialTypeAmountInput; %Number of different kinds of stimuli
ErrorMessage = 0; %Error Message Trigger
InitialConditions = 1; %initialize initial conditions check variable
VerificationLoop = 1; %initialize target stimuli creation loop
RunCode = 1;
disp('Generating test vector...');

%% CHECK INITIAL CONDITIONS
if NbrTargets+NbrLures >= TestLength/2
    RunCode = 0;
    ErrorMessage = 1;
    InitialConditions =0;
    errordlg('Target or lure amount must be reduced.','Error')
elseif LureLevelInput ==0
    LureVect = [];
else
    ErrorMessage = 0;
end

%% BEGIN ALGORITHM TO CREATE TEST VECTOR
while RunCode == 1

   %% SET LURE AMOUNTS 
    if LureLevel == 1
        LureBack = n_Number-1;
    elseif LureLevel == 2
        LureBack = n_Number+1;
    elseif LureLevel == 3;
        LureBackShort = n_Number-1;
        LureBackLong = n_Number+1;
    end
    
    %% BEGIN TARGET CREATION LOOP
    VerificationLoop = 1; %initialize target stimuli creation loop
    while VerificationLoop == 1
        clear CheckVect;
        %% GENERATE TARGET STIMULI
        Targets = 1:NbrTargets; %Create vector full of trials
        
        for idx = 1:NbrTargets %if more targets are requested than there are trial types, start over when idx >TrialTypeAmount
            if idx > TrialTypeAmount
               Targets(idx) = mod(idx,TrialTypeAmount)+1; 
            end
        end

        Targets = Targets(randperm(length(Targets))); %Scramble target stimuli into random order
        TestVect = zeros(1, TestLength); %generate the TestVector of zeros


        %% ENSURE THAT NO TARGETS ARE THE SAME AND THAT NO TARGET/MATCH PAIRS CONFLICT
        TargetLoop = 1;
        while TargetLoop == 1;
            TargPosChecker = 1;
            MatchPosChecker = 1;
            TargetPositions = sort(randi([4, TestLength], 1, NbrTargets));%generate the position of the targets within the vector
            TargetPositions = unique(TargetPositions); %Remove any duplicate values from the vector
                if length(TargetPositions) ~= NbrTargets %If there were any duplicate values, recreate the TargetPositions vector
                    TargPosChecker = 0;
                end

                for idx = 1:length(TargetPositions)-1 %if any values interfere with Target/Match placement recreate the TargetPosition vector
                    if TargetPositions(idx)+n_Number == TargetPositions(idx+1)
                        MatchPosChecker = 0;
                    end
                end

                if MatchPosChecker == 0 || TargPosChecker == 0; %if either issue exists, rerun the loop
                    TargetLoop = 1;
                else
                    TargetLoop = 0;
                end
        end

        %% PUT TARGETS AND MATCHES INTO TEST VECTOR
        for idx = 1:NbrTargets
            TestVect(TargetPositions(idx)) = Targets(idx); %place targets in position
            TestVect(TargetPositions(idx)-n_Number) = Targets(idx); %place matches in position
        end


        %% CHECK TO ENSURE N-BACKS ARE STILL IN PLACE
            check = 1; %initialize check counter
        for idx = n_Number+1:TestLength %scroll through the test vector
            if TestVect(idx) == TestVect(idx-n_Number) && TestVect(idx) ~=0 
                CheckVect(check) = idx; %place index position of above conditions into a vector
                check = check+1;  %advance check counter
            end
        end

        TF = isequal(CheckVect,TargetPositions); %compare Check positions to pre-determined target positions

        if TF == 1
            VerificationLoop = 0; %if target positions are shown to be correct continue with code
            RunCode = 0;
        end
        FirstTime = toc;
        if FirstTime > 30 %if loop must execute more than 500 times, cancel program and display error message.
            ErrorMessage = 1;
            disp('Error Triggered in Line 105');
            RunCode = 0;
            break;
        end
    end
    
    if RunCode == 0;
        break;
    end
    
end
if InitialConditions == 1 || VerificationLoop == 0
    RunCode = 1;
end


while RunCode == 1

    %% GET VECTOR OF TARGET AND MATCH POSITIONS
    TargetMatchVect = zeros(1,2*NbrTargets);
    Counter = 1;
    for idx = 1:TestLength
        if TestVect(idx) > 0
            TargetMatchVect(Counter) = idx;
            Counter = Counter+1;
        end

    end
    clear Counter
    FinalCheck = 1;
    
    %% BEGIN LOOP TO POPULATE THE REST OF THE VECTOR

    while FinalCheck == 1
       ElapsedTime = toc; %check elapsed time
        %% POPULATE THE VECTOR
        for idx = n_Number+1:TestLength
            if TestVect(idx) == 0 %if the test vector at that point is equal to zero
                TestVect(idx) = randi(TrialTypeAmount); %place a random trial into it
            end

        end

        %% ENSURE NO FALSE n-BACK PAIRS HAVE BEEN CREATED 
        FinalCounter = 0;
        for idx = n_Number+1:TestLength 
            if TestVect(idx) == TestVect(idx-n_Number) %find all instances of n-Back pairs
                FinalCounter = FinalCounter+1;
            end
        end

        if FinalCounter == NbrTargets % if no extra pairs continue on
            FinalCheck = 0;
        else
            FinalCheck = 1; %if extra pairs erase all but desired matches and targets and repopulate the vector
            Counter = 1;
            for idx = 1:TestLength
                if idx == TargetMatchVect(Counter)
                    if Counter < length(TargetMatchVect)
                    Counter = Counter+1;
                    end
                else
                    TestVect(idx) = 0;
                end
            end
        end

        %% CHECK IF LURE AMOUNTS ARE CORRECT
        if LureLevel < 3 && LureLevel > 0
            LureCounter = 0;
            Counter = 1;
            for idx = LureBack+1:TestLength %find all lures within the test vect
                if TestVect(idx) == TestVect(idx-LureBack)
                    LureVect(LureCounter+1) = idx;
                    LureCounter = LureCounter+1;
                end
            end
            if LureCounter == NbrLures
                FinalCheck = 0;
            else
                FinalCheck = 1;
                clear LureVect
                 for idx = 1:TestLength
                    if idx == TargetMatchVect(Counter)
                        if Counter < length(TargetMatchVect)
                        Counter = Counter+1;
                        end
                    else
                        TestVect(idx) = 0;
                    end
                end
            end
            
        elseif LureLevel == 3
            LureCounterLong = 0;
            LureCounterShort = 0;
            Counter = 1;
            for idx = LureBackLong+1:TestLength %find all lures within the test vect
                if TestVect(idx) == TestVect(idx-LureBackLong)
                    LureVectLong(LureCounterLong+1) = idx;
                    LureCounterLong = LureCounterLong+1;
                end
            end
            for idx = 4:TestLength
                if TestVect(idx) == TestVect(idx-LureBackShort)
                    LureVectShort(LureCounterShort+1) = idx;
                    LureCounterShort = LureCounterShort+1;
                end
            end
            if LureCounterLong+LureCounterShort == NbrLures
                FinalCheck = 0;
                if LureCounterShort > 0 && LureCounterLong > 0
                    LureVect = sort([LureVectShort LureVectLong]);
                elseif LureCounterShort > 0 && LureCounterLong == 0
                    LureVect = LureVectShort;
                elseif LureCounterShort == 0 && LureCounterLong > 0 
                    LureVect = LureVectLong;
                end
            else
                FinalCheck = 1;
                clear LureVectLong;
                clear LureVectShort;
                clear LureVect;
                 for idx = 1:TestLength
                    if idx == TargetMatchVect(Counter)
                        if Counter < length(TargetMatchVect)
                        Counter = Counter+1;
                        end
                    else
                        TestVect(idx) = 0;
                    end
                end
            end
        end
        
        if ElapsedTime > 30 %if this process takes more than 30 seconds, kill the program and ask user to rerun.
            FinalCheck = 0;
            ErrorMessage = 1;
            disp('Error triggered in line 245')
            break;
        end
    end
    RunCode = 0;

end

RunCode = 1;

%% POPULATE THE FIRST THREE TRIALS OF THE TEST VECTOR
while RunCode == 1
    ElapsedTime = toc;
    Counter = 1;
    LoopRelease = 1;
    for idx = 1:3
        if TestVect(idx) == 0
        TestVect(idx) = randi(TrialTypeAmount);
        IndexPosition(Counter) = idx;
        Counter = Counter+1;
        end
    end
    
    for CheckIdx = IndexPosition(1):length(IndexPosition)
        if TestVect(CheckIdx) == TestVect(CheckIdx+n_Number)||TestVect(CheckIdx) == TestVect(CheckIdx+n_Number+1)||TestVect(CheckIdx) == TestVect(CheckIdx+n_Number-1)        
            TestVect(CheckIdx) = 0;
            LoopRelease = 0;
        end
    end
      
    if LoopRelease == 1
        RunCode = 0;
    end

        if ElapsedTime > 30 %if this process takes more than 10 seconds, kill the program and ask user to rerun.
            RunCode = 0;
            ErrorMessage = 1;
            disp('Error triggered in line 283')
            break;
        end
        
end

%% CHECK TO ENSURE THAT ALL TESTVECT POSITIONS ARE FILLED
if LoopRelease == 1
        for idx = 1:TestLength
            if TestVect(idx) == 0 
                ErrorMessage = 1;
                disp('Error triggered in line 296')
                break;
            end
        end
end

%% DISPLAY RESULT TO USER

if ErrorMessage == 1
    errordlg('Error reported. Examine test parameters and regenerate test.','Error');
else
    toc;
    msgbox('n-Back series generated! Press "Start" to begin.', 'Series generated');
end


%%
%Peter Dodds
%Rensselaer Polytechnic Institute
% M.S. - Architectural Acoustics 2015
%