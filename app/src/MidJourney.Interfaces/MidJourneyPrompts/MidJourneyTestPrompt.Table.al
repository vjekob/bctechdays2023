table 50004 "MidJourney Test Prompt"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(2; "Setting"; enum "MidJourney Setting")
        {
            DataClassification = CustomerContent;
        }
        field(3; "Style"; enum "MidJourney Style")
        {
            DataClassification = CustomerContent;
        }
        field(4; "Aspect Ratio"; enum "MidJourney Aspect Ratio")
        {
            DataClassification = CustomerContent;
        }
        field(5; "ImageUrl"; Text[1024])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Lighting"; enum "MidJourney Lighting")
        {
            DataClassification = CustomerContent;
        }
    }


    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GeneratePrompt(CustomPrompt: Text; MidJourneyPromptFactory: Codeunit "MidJourney Prompt Factory"): Text
    var
        GeneratePromptMeth: Codeunit "GeneratePrompt Meth";
    begin
        exit(GeneratePromptMeth.GeneratePrompt(Rec, CustomPrompt, MidJourneyPromptFactory));
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

}