codeunit 50047 "MidJourney AR - Portrait" implements "IMidJourney Aspect Ratio"
{
    procedure ARPrompt(): Text;
    begin
        exit('--ar 2:3')
    end;
}