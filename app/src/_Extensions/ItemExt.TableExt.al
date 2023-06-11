tableextension 50000 "Item Ext" extends Item
{
    fields
    {
        field(50000; "Picture URL"; Text[250])
        {
            Caption = 'Picture URL';
            DataClassification = CustomerContent;
        }
        field(50001; "Pic-In-Scene"; Media)
        {
            Caption = 'Picture 2';
            DataClassification = CustomerContent;
        }
        field(50003; "Pic-In-Scene URL (MidJourney)"; Text[250])
        {
            Caption = 'Picture URL (MidJourney)';
            DataClassification = CustomerContent;
        }
        field(50004; "MidJourney TaskId"; Text[50])
        {
            Caption = 'MidJourney TaskId';
            DataClassification = CustomerContent;
        }
        field(50005; "MidJourney Prompt"; Enum "Midjourney Prompt")
        {
            Caption = 'MidJourney Prompt';
            DataClassification = CustomerContent;
        }
        field(50006; "MidJourney PromptText"; Text[1024])
        {
            Caption = 'MidJourney PromptText';
            DataClassification = CustomerContent;
        }
        field(50007; "MidJourney Status"; Text[1024])
        {
            Caption = 'MidJourney Status';
            DataClassification = CustomerContent;
        }
        field(50008; "MidJourney Done"; boolean)
        {
            Caption = 'MidJourney Done';
            DataClassification = CustomerContent;
        }
    }

    procedure GetAzureBLOBURL(): Text;
    var
        GetURLMeth: Codeunit "Azure BLOB Get URL Meth";
        URL: Text;
    begin
        URL := GetURLMeth.GetPictureURL(Rec);
        exit(URL);
    end;

    procedure DownloadPicInSceneImage()
    var
        DownloadPicInSceneImageMeth: Codeunit "ImportItemPicInScene Meth";
    begin
        DownloadPicInSceneImageMeth.ImportImage(Rec."Pic-In-Scene URL (MidJourney)", Rec);
    end;

    procedure GetPrompt(): Text
    var
        PromptMeth: Codeunit "Midjourney Prompt Meth";
    begin
        exit(PromptMeth.GetPrompt(Rec."MidJourney Prompt", Rec."Picture URL"));
    end;
}