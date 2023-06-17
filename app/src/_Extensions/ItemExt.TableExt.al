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
        field(50003; "Pic-In-Scene URL (Midjourney)"; Text[250])
        {
            Caption = 'Picture URL (Midjourney)';
            DataClassification = CustomerContent;
        }
        field(50005; "Midjourney Prompt"; Enum "Midjourney Prompt")
        {
            Caption = 'Midjourney Prompt';
            DataClassification = CustomerContent;
        }
    }

    procedure DownloadPicInSceneImage()
    var
        DownloadPicInSceneImageMeth: Codeunit "ImportItemPicInScene Meth";
    begin
        DownloadPicInSceneImageMeth.ImportImage(Rec."Pic-In-Scene URL (Midjourney)", Rec);
    end;

    procedure GetPrompt(): Text
    var
        PromptMeth: Codeunit "Midjourney Prompt Meth";
    begin
        exit(PromptMeth.GetPrompt(Rec."Midjourney Prompt", Rec."Picture URL"));
    end;

    procedure ImagineScenery()
    var
        ItemPicInSceneMeth: Codeunit "ItemPic-In-Scene Meth";
    begin
        ItemPicInSceneMeth.ImagineScenery(Rec);
    end;
}