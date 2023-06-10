codeunit 50046 "MidJourney AR - Square" implements "IMidJourney Aspect Ratio"
{
    procedure ARPrompt(): Text;
    begin
        exit('--ar 1:1')
    end;
}