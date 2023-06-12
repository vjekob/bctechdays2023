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
        IsHandled: Boolean;
    begin
        OnBeforeImagine(Item, IsHandled);

        DoImagine(Item, IsHandled);

        OnAfterImagine(Item);
    end;

    local procedure DoImagine(var Item: Record Item; IsHandled: Boolean);
    var
        Setup: Record "Midjourney Setup";
        ImagineWithMidJourneyMeth: Codeunit "ImagineWithMidJourney Meth";
        ImportItemPicInSceneMeth: Codeunit "ImportItemPicInScene Meth";
        Url: Text;
    begin
        if IsHandled then
            exit;

        ClearPicInSceneImage(Item);

        Item.TestField("MidJourney Prompt");
        Setup.Get();
        Url := ImagineWithMidJourneyMeth.GetImageUrl(Item.GetPrompt(), Setup);
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