codeunit 50048 "MidJourney AR - Landscape" implements "IMidJourney Aspect Ratio"
{
    procedure ARPrompt(): Text;
    begin
        exit('--ar 7:4')
    end;
}