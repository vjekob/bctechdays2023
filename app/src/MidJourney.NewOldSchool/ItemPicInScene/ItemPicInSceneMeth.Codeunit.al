codeunit 50062 "ItemPic-In-Scene Meth"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        Item: Record Item;
        RecRef: RecordRef;
        Send: Codeunit "MidJourney - Send";
    begin
        Rec.Testfield("Record ID to Process");
        RecRef.Get(Rec."Record ID to Process");
        RecRef.SetTable(Item);
        Item.Find();

        ImagineScenery(Item, Send);
    end;

    internal procedure ImagineScenery(var Item: Record Item; Send: interface IMidJourneySend)
    var
        IsHandled: Boolean;
    begin
        OnBeforeImagine(Item, IsHandled);

        DoImagine(Item, Send, IsHandled);

        OnAfterImagine(Item);
    end;

    local procedure DoImagine(var Item: Record Item; var Send: interface IMidJourneySend; IsHandled: Boolean);
    var
        Setup: Record "Midjourney Setup";
        ImagineWithMidJourneyMeth: Codeunit "ImagineWithMidJourney Meth";
        ImportItemPicInSceneMeth: Codeunit "ImportItemPicInScene Meth";
        MidJourneyImagine: Codeunit "MidJourney - Imagine";
        MidJourneyResult: Codeunit "MidJourney - Result";
        Url: Text;
    begin
        if IsHandled then
            exit;

        ClearPicInSceneImage(Item);

        Item.TestField("MidJourney Prompt");
        Setup.Get();
        Url := ImagineWithMidJourneyMeth.GetImageUrl(Item.GetPrompt(), Setup, MidJourneyImagine, MidJourneyResult, Send);
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
    local procedure OnBeforeImagine(var Item: Record Item; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterImagine(var Item: Record Item);
    begin
    end;
}