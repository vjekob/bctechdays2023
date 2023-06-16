codeunit 50062 "ItemPic-In-Scene Meth"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        Item: Record Item;
        RecRef: RecordRef;
    begin
        Rec.Testfield("Record ID to Process");
        RecRef.Get(Rec."Record ID to Process");
        RecRef.SetTable(Item);
        Item.Find();

        ImagineScenery(Item);
    end;

    internal procedure ImagineScenery(var Item: Record Item)
    var
        Setup: Record "Midjourney Setup";
    begin
        Setup.Get();
        ImagineScenery(Item, Setup);
    end;

    internal procedure ImagineScenery(var Item: Record Item; var Setup: Record "Midjourney Setup")
    var
        IsHandled: Boolean;
    begin
        OnBeforeImagine(Item, Setup, IsHandled);

        DoImagine(Item, Setup, IsHandled);

        OnAfterImagine(Item, Setup);
    end;

    local procedure DoImagine(var Item: Record Item; var Setup: Record "Midjourney Setup"; IsHandled: Boolean);
    var
        Imagine: Codeunit "Midjourney - Imagine";
        Send: Codeunit "MidJourney - Send";
        ImportItemPicInSceneMeth: Codeunit "ImportItemPicInScene Meth";
        MidJourneySendResponseHandler: Codeunit "MidJourneySend ResponseHandler";
        Url: Text;
    begin
        if IsHandled then
            exit;

        ClearPicInSceneImage(Item);

        Item.TestField("MidJourney Prompt");
        Url := Imagine.Imagine(Item.GetPrompt(), Setup, Send, MidJourneySendResponseHandler);
        ImportItemPicInSceneMeth.ImportImage(Url, Item);
        Item.Modify();
    end;

    local procedure ClearPicInSceneImage(var Item: Record Item)
    begin
        item."Pic-In-Scene URL (MidJourney)" := '';
        clear(Item."Pic-In-Scene");
        Item.Modify();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeImagine(var Item: Record Item; var Setup: Record "Midjourney Setup"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterImagine(var Item: Record Item; var Setup: Record "Midjourney Setup");
    begin
    end;
}